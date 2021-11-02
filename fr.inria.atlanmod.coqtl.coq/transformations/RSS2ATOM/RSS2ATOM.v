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
    ];
    rule "Item2Entry"
    from [ItemClass]
    to
    [
      elem [ItemClass] EntryClass "entry"
      (
        fun i m item => BuildEntry
        (Item_getTitle item)
        (Item_getGuid item)
        "What do I put for Rights?"
        (Item_getComments item)
        (Item_getPubDate item)
        "What do I put for LastUpdate?"
      )
      nil
    ]
    (* rule "Category2Category"
    from [CategoryClass]
    to
    [
      elem [CategoryClass] CategoryClass "category"
      (
        fun i m c => BuildCategory
        "What do I put for term?"
        (Category_getDomain c)
        (Category_getValue c)
      )
      nil
    ] *)
  ].
Close Scope coqtl.