

(********************************************************************
	@name Coq declarations for metamodel: <Persons>
	@date 2021/11/22 09:57:52
	@description Automatically generated by Ecore2Coq transformation.
 ********************************************************************)

(* Coq libraries *)
Require Import String.
Require Import Bool.
Require Import List.      (* sequence *)
Require Import Multiset.  (* bag *)
Require Import ListSet.   (* set *)
Require Import PeanoNat.
Require Import EqNat.
Require Import Coq.Logic.Eqdep_dec.
Scheme Equality for option. (* equality for option type *)

Require Import core.EqDec.
Require Import core.utils.Utils.
Require Import core.Metamodel.
Require Import core.modeling.ModelingMetamodel.
Require Import core.Model.
Require Import core.utils.CpdtTactics.

(* Base types *)


Inductive Person : Set :=
  BuildPerson :
  (* fullName *)  string ->
  Person.

Inductive Male : Set :=
  BuildMale :
  (* Inheritence Attribute *) Person -> 
  Male.

Inductive Female : Set :=
  BuildFemale :
  (* Inheritence Attribute *) Person -> 
  Female.







(* Accessors *)
Definition Person_getFullName (p : Person) :  string :=
  match p with BuildPerson  fullName  => fullName end.

Definition Male_getPerson (m : Male) : Person :=
  match m with BuildMale person  => person end.

Definition Female_getPerson (f : Female) : Person :=
  match f with BuildFemale person  => person end.


Definition beq_Person (pe_arg1 : Person) (pe_arg2 : Person) : bool :=
(  beq_string (Person_getFullName pe_arg1) (Person_getFullName pe_arg2) )
.

Definition beq_Male (ma_arg1 : Male) (ma_arg2 : Male) : bool :=
beq_Person (Male_getPerson ma_arg1) (Male_getPerson ma_arg2)
.

Definition beq_Female (fe_arg1 : Female) (fe_arg2 : Female) : bool :=
beq_Person (Female_getPerson fe_arg1) (Female_getPerson fe_arg2)
.


(* Meta-types *)	
Inductive PersonsMetamodel_Class : Set :=
  | PersonClass
  | MaleClass
  | FemaleClass
.

Definition PersonsMetamodel_getTypeByClass (pecl_arg : PersonsMetamodel_Class) : Set :=
  match pecl_arg with
    | PersonClass => Person
    | MaleClass => Male
    | FemaleClass => Female
  end.	

Inductive PersonsMetamodel_Reference : Set :=
.

Definition PersonsMetamodel_getTypeByReference (pere_arg : PersonsMetamodel_Reference) : Set :=
  match pere_arg with
  end.

Definition PersonsMetamodel_getERoleTypesByEReference (pere_arg : PersonsMetamodel_Reference) : Set :=
  match pere_arg with
  end.

(* Generic types *)			
Inductive PersonsMetamodel_Object : Set :=
 | Build_PersonsMetamodel_Object : 
    forall (pecl_arg: PersonsMetamodel_Class), (PersonsMetamodel_getTypeByClass pecl_arg) -> PersonsMetamodel_Object.

Definition beq_PersonsMetamodel_Object (c1 : PersonsMetamodel_Object) (c2 : PersonsMetamodel_Object) : bool :=
  match c1, c2 with
  | Build_PersonsMetamodel_Object PersonClass o1, Build_PersonsMetamodel_Object PersonClass o2 => beq_Person o1 o2
  | Build_PersonsMetamodel_Object MaleClass o1, Build_PersonsMetamodel_Object MaleClass o2 => beq_Male o1 o2
  | Build_PersonsMetamodel_Object FemaleClass o1, Build_PersonsMetamodel_Object FemaleClass o2 => beq_Female o1 o2
  | _, _ => false
  end.

Inductive PersonsMetamodel_Link : Set :=
 | Build_PersonsMetamodel_Link : 
    forall (pere_arg:PersonsMetamodel_Reference), (PersonsMetamodel_getTypeByReference pere_arg) -> PersonsMetamodel_Link.

(* TODO *)
Definition beq_PersonsMetamodel_Link (l1 : PersonsMetamodel_Link) (l2 : PersonsMetamodel_Link) : bool := true.

(* Reflective functions *)
Lemma PersonsMetamodel_eqEClass_dec : 
 forall (pecl_arg1:PersonsMetamodel_Class) (pecl_arg2:PersonsMetamodel_Class), { pecl_arg1 = pecl_arg2 } + { pecl_arg1 <> pecl_arg2 }.
Proof. repeat decide equality. Defined.

Lemma PersonsMetamodel_eqEReference_dec : 
 forall (pere_arg1:PersonsMetamodel_Reference) (pere_arg2:PersonsMetamodel_Reference), { pere_arg1 = pere_arg2 } + { pere_arg1 <> pere_arg2 }.
Proof. repeat decide equality. Defined.

Definition PersonsMetamodel_getEClass (peob_arg : PersonsMetamodel_Object) : PersonsMetamodel_Class :=
   match peob_arg with
  | (Build_PersonsMetamodel_Object peob_arg _) => peob_arg
   end.

Definition PersonsMetamodel_getEReference (peli_arg : PersonsMetamodel_Link) : PersonsMetamodel_Reference :=
   match peli_arg with
  | (Build_PersonsMetamodel_Link peli_arg _) => peli_arg
   end.

Definition PersonsMetamodel_instanceOfEClass (pecl_arg: PersonsMetamodel_Class) (peob_arg : PersonsMetamodel_Object): bool :=
  if PersonsMetamodel_eqEClass_dec (PersonsMetamodel_getEClass peob_arg) pecl_arg then true else false.

Definition PersonsMetamodel_instanceOfEReference (pere_arg: PersonsMetamodel_Reference) (peli_arg : PersonsMetamodel_Link): bool :=
  if PersonsMetamodel_eqEReference_dec (PersonsMetamodel_getEReference peli_arg) pere_arg then true else false.


Definition PersonsMetamodel_toClass (pecl_arg : PersonsMetamodel_Class) (peob_arg : PersonsMetamodel_Object) : option (PersonsMetamodel_getTypeByClass pecl_arg).
Proof.
  destruct peob_arg as [arg1 arg2].
  destruct (PersonsMetamodel_eqEClass_dec arg1 pecl_arg) as [e|] eqn:dec_case.
  - rewrite e in arg2.
    exact (Some arg2).
  - exact None.
Defined.

Definition PersonsMetamodel_toReference (pere_arg : PersonsMetamodel_Reference) (peli_arg : PersonsMetamodel_Link) : option (PersonsMetamodel_getTypeByReference pere_arg).
Proof.
  destruct peli_arg as [arg1 arg2].
  destruct (PersonsMetamodel_eqEReference_dec arg1 pere_arg) as [e|] eqn:dec_case.
  - rewrite e in arg2.
  	exact (Some arg2).
  - exact None.
Defined.

(* Generic functions *)
Definition PersonsModel := Model PersonsMetamodel_Object PersonsMetamodel_Link.

Definition PersonsMetamodel_toObject (pecl_arg: PersonsMetamodel_Class) (t: PersonsMetamodel_getTypeByClass pecl_arg) : PersonsMetamodel_Object :=
  (Build_PersonsMetamodel_Object pecl_arg t).

Definition PersonsMetamodel_toLink (pere_arg: PersonsMetamodel_Reference) (t: PersonsMetamodel_getTypeByReference pere_arg) : PersonsMetamodel_Link :=
  (Build_PersonsMetamodel_Link pere_arg t).


Fixpoint PersonsMetamodel_Person_downcastMale (pe_arg : Person) (l : list PersonsMetamodel_Object) : option Male := 
  match l with
	 | Build_PersonsMetamodel_Object MaleClass (BuildMale eSuper ) :: l' => 
		if beq_Person pe_arg eSuper then (Some (BuildMale eSuper )) else (PersonsMetamodel_Person_downcastMale pe_arg l')
	 | _ :: l' => (PersonsMetamodel_Person_downcastMale pe_arg l')
	 | nil => None
end.

Definition Person_downcastMale (pe_arg : Person) (m : PersonsModel) : option Male :=
  PersonsMetamodel_Person_downcastMale pe_arg (@allModelElements _ _ m).

Fixpoint PersonsMetamodel_Person_downcastFemale (pe_arg : Person) (l : list PersonsMetamodel_Object) : option Female := 
  match l with
	 | Build_PersonsMetamodel_Object FemaleClass (BuildFemale eSuper ) :: l' => 
		if beq_Person pe_arg eSuper then (Some (BuildFemale eSuper )) else (PersonsMetamodel_Person_downcastFemale pe_arg l')
	 | _ :: l' => (PersonsMetamodel_Person_downcastFemale pe_arg l')
	 | nil => None
end.

Definition Person_downcastFemale (pe_arg : Person) (m : PersonsModel) : option Female :=
  PersonsMetamodel_Person_downcastFemale pe_arg (@allModelElements _ _ m).








(* Typeclass Instances *)	
Instance PersonsMetamodel_ElementSum : Sum PersonsMetamodel_Object PersonsMetamodel_Class :=
{
	denoteSubType := PersonsMetamodel_getTypeByClass;
	toSubType := PersonsMetamodel_toClass;
	toSumType := PersonsMetamodel_toObject;
}.

Instance PersonsMetamodel_LinkSum : Sum PersonsMetamodel_Link PersonsMetamodel_Reference :=
{
	denoteSubType := PersonsMetamodel_getTypeByReference;
	toSubType := PersonsMetamodel_toReference;
	toSumType := PersonsMetamodel_toLink;
}.

Instance PersonsMetamodel_EqDec : EqDec PersonsMetamodel_Object := {
    eq_b := beq_PersonsMetamodel_Object;
}.

Instance PersonsMetamodel_Metamodel_Instance : 
	Metamodel :=
{
	ModelElement := PersonsMetamodel_Object;
	ModelLink := PersonsMetamodel_Link;
}.

Instance PersonsMetamodel_ModelingMetamodel_Instance : 
	ModelingMetamodel PersonsMetamodel_Metamodel_Instance :=
{ 
    elements := PersonsMetamodel_ElementSum;
    links := PersonsMetamodel_LinkSum; 
}.

(* Useful lemmas *)

Lemma Persons_invert : 
  forall (pecl_arg: PersonsMetamodel_Class) (t1 t2: PersonsMetamodel_getTypeByClass pecl_arg), 
    Build_PersonsMetamodel_Object pecl_arg t1 = Build_PersonsMetamodel_Object pecl_arg t2 -> t1 = t2.
Admitted.
