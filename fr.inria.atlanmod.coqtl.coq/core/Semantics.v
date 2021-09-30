Require Import String.

Require Import core.utils.Utils.
Require Import core.Model.
Require Import core.Syntax.
Require Import core.EqDec. 
Require Import Bool.
Require Import Arith.
Require Import TransformationConfiguration.
Require Import Expressions.
Scheme Equality for list.


Section Semantics.

Context {tc: TransformationConfiguration}.

(** * Instantiate **)

Definition matchRuleOnPattern (r: Rule) (sm : SourceModel) (sp: list SourceNode) : bool :=
  match evalGuardExpr r sm sp with Some true => true | _ => false end.

Definition matchPattern (tr: Transformation) (sm : SourceModel) (sp: list SourceNode) : list Rule :=
  filter (fun (r:Rule) => matchRuleOnPattern r sm sp) (Transformation_getRules tr).

Definition instantiateNodeOnPattern (o: OutputPatternNode) (sm: SourceModel) (sp: list SourceNode) (iter: nat)
  : option TargetNode :=
  evalOutputPatternNodeExpr sm sp iter o.

Definition instantiateNodesOnPattern (o: OutputPatternNode) (sm: SourceModel) (sp: list SourceNode):  list TargetNode :=
  flat_map (fun n => optionToList (instantiateNodeOnPattern o sm sp n))
    (seq 0 (evalNodeIteratorExpr o sm sp)).  

Definition instantiateRuleOnPattern (r: Rule) (sm: SourceModel) (sp: list SourceNode) :  list TargetNode :=
  flat_map (fun o => instantiateNodesOnPattern o sm sp)
  (Rule_getOutputPatternNodes r).

Definition instantiatePattern (tr: Transformation) (sm : SourceModel) (sp: list SourceNode) : list TargetNode :=
  flat_map (fun r => instantiateRuleOnPattern r sm sp) (matchPattern tr sm sp).

Definition instantiateRuleOnPatternIterName (r: Rule) (sm: SourceModel) (sp: list SourceNode) (iter: nat) (name: string): option (TargetNode) :=
  match (Rule_findOutputPatternNode r name) with
  | Some o =>  instantiateNodeOnPattern o sm sp iter
  | None => None
  end.

(** * Trace **)

Definition traceNodeOnPattern (o: OutputPatternNode) (sm: SourceModel) (sp: list SourceNode) (iter: nat)
  : option TraceLink :=
  match (instantiateNodeOnPattern o sm sp iter) with
  | Some e => Some (buildTraceLink (sp, iter, OutputPatternNode_getName o) e)
  | None => None
  end.

Definition traceNodesOnPattern (o: OutputPatternNode) (sm: SourceModel) (sp: list SourceNode):  list TraceLink :=
  flat_map (fun n => optionToList (traceNodeOnPattern o sm sp n))
    (seq 0 (evalNodeIteratorExpr o sm sp)).  

Definition traceRuleOnPattern (r: Rule) (sm: SourceModel) (sp: list SourceNode) :  list TraceLink :=
  flat_map (fun o => traceNodesOnPattern o sm sp)
  (Rule_getOutputPatternNodes r).

Definition tracePattern (tr: Transformation) (sm : SourceModel) (sp: list SourceNode) : list TraceLink :=
  flat_map (fun r => traceRuleOnPattern r sm sp) (matchPattern tr sm sp).

Definition maxArity (tr: Transformation) : nat := Transformation_getArity tr.

Definition allTuples (tr: Transformation) (sm : SourceModel) :list (list SourceNode) :=
  tuples_up_to_n (allNodes sm) (maxArity tr).

Definition trace (tr: Transformation) (sm : SourceModel) : list TraceLink :=
  flat_map (tracePattern tr sm) (allTuples tr sm).  

Definition resolveIter (tls: list TraceLink) (sm: SourceModel) (name: string)
            (sp: list SourceNode)
            (iter : nat) : option TargetNode :=
let tl := find (fun tl: TraceLink => 
  (list_beq SourceNode SourceNode_eqb (TraceLink_getSourcePattern tl) sp) &&
  ((TraceLink_getIterator tl) =? iter) &&
  ((TraceLink_getName tl) =? name)%string) tls in
match tl with
  | Some tl' => Some (TraceLink_getTargetNode tl')
  | None => None
end.

Definition resolve (tr: list TraceLink) (sm: SourceModel) (name: string)
  (sp: list SourceNode) : option TargetNode :=
  resolveIter tr sm name sp 0.

Definition resolveAllIter (tr: list TraceLink) (sm: SourceModel) (name: string)
  (sps: list(list SourceNode)) (iter: nat)
  : option (list TargetNode) :=
  Some (flat_map (fun l:(list SourceNode) => optionToList (resolveIter tr sm name l iter)) sps).

Definition resolveAll (tr: list TraceLink) (sm: SourceModel) (name: string)
  (sps: list(list SourceNode)) : option (list TargetNode) :=
  resolveAllIter tr sm name sps 0.

Definition maybeResolve (tr: list TraceLink) (sm: SourceModel) (name: string)
  (sp: option (list SourceNode)) : option TargetNode :=
  match sp with 
  | Some sp' => resolve tr sm name sp'
  | None => None
  end.

Definition maybeResolveAll (tr: list TraceLink) (sm: SourceModel) (name: string)
  (sp: option (list (list SourceNode))) : option (list TargetNode) :=
  match sp with 
  | Some sp' => resolveAll tr sm name sp'
  | None => None
  end.

(** * Apply **)

Definition applyLinkOnPattern
            (oper: OutputPatternLink)
            (tr: Transformation)
            (sm: SourceModel)
            (sp: list SourceNode) (iter: nat) (te: TargetNode) (iterl: nat): option TargetEdge :=
  evalOutputPatternLinkExpr iterl sm sp te iter (trace tr sm) oper.

Definition applyLinksOnPattern
  (oper: OutputPatternLink)
  (tr: Transformation)
  (sm: SourceModel)
  (sp: list SourceNode) (iter: nat) (te: TargetNode): list TargetEdge :=
  flat_map (fun n => optionToList (applyLinkOnPattern oper tr sm sp iter te n))
    (seq 0 (evalLinkIteratorExpr oper sm sp te iter (trace tr sm))).  

Definition applyNodeOnPattern
            (ope: OutputPatternNode)
            (tr: Transformation)
            (sm: SourceModel)
            (sp: list SourceNode) (iter: nat) : list TargetEdge :=
  flat_map (fun oper => 
    match (evalOutputPatternNodeExpr sm sp iter ope) with 
    | Some l => applyLinksOnPattern oper tr sm sp iter l
    | None => nil
    end) (OutputPatternNode_getOutputLinks ope).

Definition applyNodesOnPattern (o: OutputPatternNode) (tr: Transformation) (sm: SourceModel) (sp: list SourceNode):  list TargetEdge :=
  flat_map (fun n => applyNodeOnPattern o tr sm sp n)
    (seq 0 (evalNodeIteratorExpr o sm sp)).  

Definition applyRuleOnPattern (r: Rule) (tr: Transformation) (sm: SourceModel) (sp: list SourceNode) :  list TargetEdge :=
  flat_map (fun o => applyNodesOnPattern o tr sm sp)
  (Rule_getOutputPatternNodes r).

Definition applyPattern (tr: Transformation) (sm : SourceModel) (sp: list SourceNode) : list TargetEdge :=
  flat_map (fun r => applyRuleOnPattern r tr sm sp) (matchPattern tr sm sp).

(** * Execute **)

Definition execute (tr: Transformation) (sm : SourceModel) : TargetModel :=
  Build_Model
    (* elements *) (flat_map (instantiatePattern tr sm) (allTuples tr sm))
    (* links *) (flat_map (applyPattern tr sm) (allTuples tr sm)).

End Semantics.
