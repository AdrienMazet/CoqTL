Require Import String.
Require Import List.
Require Import Multiset.
Require Import ListSet.

Require Import core.utils.Utils.

Require Import core.modeling.ConcreteSyntax.
Require Import core.modeling.ModelingSemantics.
Require Import core.modeling.ModelingMetamodel.
Require Import core.modeling.ConcreteExpressions.
Require Import core.modeling.Parser.

Require Import RSS2ATOM.ATOM.
Require Import RSS2ATOM.RSS.

Require Import core.TransformationConfiguration.
Require Import core.modeling.ModelingTransformationConfiguration.

Instance R2AConfiguration : TransformationConfiguration := 
  Build_TransformationConfiguration RSSMetamodel_Metamodel_Instance ATOMMetamodel_Metamodel_Instance.

Instance RSS2ATOMConfiguration : ModelingTransformationConfiguration R2AConfiguration :=
 Build_ModelingTransformationConfiguration R2AConfiguration RSSMetamodel_ModelingMetamodel_Instance ATOMMetamodel_ModelingMetamodel_Instance.

Open Scope coqtl.

Definition RSS2ATOM :=
  transformation
  [
    rule "Channel2ATOM"
    from [ChannelClass]
    to
    [
      elem [ChannelClass] ATOMClass "atom"
        (
          fun i m c => BuildATOM
          (Channel_getTitle c)
          "What do I put for Index?"
          (Channel_getDescription c)
          (Channel_getCopyright c)
          "What do I put for Icon?"
          "What do I put for Logo?"
          (Channel_getLastBuildDate c)
        )
        [
          link [ChannelClass] ATOMClass ATOMCategoriesReference
          (
            fun tls i m c a => maybeBuildATOMCategories a
            (
              maybeResolveAll tls m "categories" ATOM.CategoryClass
              (
                maybeSingleton (Channel_getItemsObjects c m)
              )
            )
          )
        ]
    ]
  ].
  (*TODO : ITEM TO ENTRY*)
  (*TODO : CATEGORY TO CATEGORY*)
Close Scope coqtl.
(*
rule "Attribute2Column"
from [AttributeClass]
where (fun m a => negb (getAttributeDerived a))
to [elem [AttributeClass] ColumnClass "col"
    (fun i m a => BuildColumn (getAttributeId a) (getAttributeName a))
    [link [AttributeClass] ColumnClass ColumnReferenceReference
      (fun tls i m a c =>
        maybeBuildColumnReference c
          (maybeResolve tls m "tab" TableClass 
            (maybeSingleton (getAttributeTypeObject a m))))]]
 *)