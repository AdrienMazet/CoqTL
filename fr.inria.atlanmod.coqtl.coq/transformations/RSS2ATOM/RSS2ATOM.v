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
        ""
        (Some (Channel_getDescription c))
        (Channel_getCopyright c)
        None
        None
        (value (Channel_getLastBuildDate c))
      )
      [
        link [ChannelClass] ATOMClass ATOMCategoriesReference
        (
          fun tls i m c a => maybeBuildATOMCategories a
          (
            maybeResolveAll tls m "categories" ATOM.CategoryClass
            (
              maybeSingleton (
                maybeSingleton (
                  Channel_getCategoryObject c m
                )
              )
            )
          )
        );
        link [ChannelClass] ATOMClass ATOMLinksReference
        (
          fun tls i m c a => maybeBuildATOMLinks a
          (
            Some [
              BuildLink None (Channel_getLink c) None None None None
            ]
          )
        );
        link [ChannelClass] ATOMClass ATOMAuthorsReference
        (
          fun tls i m c a => maybeBuildATOMAuthors a
          (
            None
            (* TODO *)
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
        (value (Item_getGuid item))
        None
        (Item_getComments item)
        (Item_getPubDate item)
        ""
      )
      [
        link [ItemClass] EntryClass EntryLinksReference
        (
          fun tls i m item e => maybeBuildEntryLinks e
          (
            Some [
              BuildLink None (Some (Item_getLink item)) None None None None
            ]
          )
        )
      ]
    ];
    rule "Category2Category"
    from [RSS.CategoryClass]
    to
    [
      elem [RSS.CategoryClass] ATOM.CategoryClass "category"
      (
        fun i m c => ATOM.BuildCategory
        ""
        (Some (Category_getDomain c))
        (Some (Category_getValue c))
      )
      nil
    ]
  ].

Close Scope coqtl.