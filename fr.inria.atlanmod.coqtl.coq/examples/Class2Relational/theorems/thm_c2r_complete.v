Require Import Coq.Logic.Eqdep_dec.
Require Import Coq.Arith.EqNat.
Require Import List.
Require Import String.
From mathcomp Require Import ssreflect ssrfun ssrbool eqtype.  

Require Import core.utils.tTop.
Require Import core.Notations.
Require Import core.CoqTL.
Require Import core.Metamodel.
Require Import core.Model.
Require Import core.utils.CpdtTactics.

Require Import examples.Class2Relational.Class2Relational.
Require Import examples.Class2Relational.ClassMetamodel.
Require Import examples.Class2Relational.RelationalMetamodel.

Theorem All_classes_match :
  forall (cm : ClassModel) (c: Class) ,
    exists (r: RuleA ClassMetamodel_EClass RelationalMetamodel_EClass RelationalMetamodel_EReference),
      matchPattern Class2Relational cm [ClassMetamodel_toEObject c] = Some r.    
Proof.
  intros.
  unfold matchPattern. simpl.
  unfold parseRuleDeclaration. simpl.
  exists (BuildRuleA "" [ClassEClass] (BuildGuardExpressionA 0)
             [BuildOutputPatternElementA "tab" TableEClass
                (BuildOutputPatternElementExpressionA 0 0)
                [BuildOutputPatternElementReferenceA TableColumnsEReference
                                                     (BuildOutputBindingExpressionA 0 0 0)]]).
  reflexivity.
Qed.

Theorem All_classes_instantiate :
  forall (cm : ClassModel) (c: Class),
    exists (t: Table),
      instantiatePattern Class2Relational cm [ClassMetamodel_toEObject c] = Some [RelationalMetamodel_toEObject t].
Proof.
  intros.
    unfold instantiatePattern.
    unfold instantiateRuleOnPattern.
    unfold setTargetElementId.
    simpl.
    unfold setTableId.
    simpl.

    exists (BuildTable
         (((getClassId c) ++ "__") ++ "0_0") 
         (getClassName c)).

    reflexivity.
Qed.

Theorem Concrete_attributes_instantiate :
  forall (cm : ClassModel) (a: Attribute), getAttributeMultiValued a=false -> 
    exists (c: Column), 
      instantiatePattern Class2Relational cm [ClassMetamodel_toEObject a] = Some [RelationalMetamodel_toEObject c].
Proof.
  intros.
  unfold instantiatePattern. simpl.
  unfold instantiateRuleOnPattern. simpl.
  unfold matchPattern. simpl.
  rewrite H. simpl.
  rewrite H. simpl.
  unfold setTargetElementId. simpl.
  exists (setColumnId (BuildColumn newId (getAttributeName a))
                 (((getAttributeId a) ++ "__") ++
                                "1_0")).
  reflexivity.
Qed.

