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
Open Scope string.

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
              maybeSingleton (Channel_getItemsObjects c m)
            )
          )
        );
        (* link [ChannelClass] ATOMClass ATOMLinksReference
        (
          fun tls i m c a => maybeBuildATOMLinks a
          (
            maybeResolveAll tls m "link" ATOM.Link
            (
              maybeSingleton (Channel_getLink c)
            )
          )
        ); *)
        (* link [ChannelClass] ATOMClass ATOMAuthorsReference
        (
          fun tls i m c a => maybeBuildATOMAuthors a
          (
            maybeResolveAll tls m "auth" ATOM.Author
            (
              maybeSingleton (
                BuildATOMAuthors a (
                  BuildAuthor (
                    BuildPerson
                    (Channel_getManagingEditor c) 
                    None 
                    (Some (Channel_getWebmaster c))
                  )
                )
              )
            )
          )
        ) *)
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
        (Some "???") (*TODO*)
        (Item_getComments item)
        (Item_getPubDate item)
        "lastUpdate ???" (*TODO*)
      )
      nil
      (*TODO : links*)
    ];
    rule "Category2Category"
    from [RSS.CategoryClass]
    to
    [
      elem [RSS.CategoryClass] ATOM.CategoryClass "category"
      (
        fun i m c => ATOM.BuildCategory
        "term ???" (*TODO*)
        (Some (Category_getDomain c))
        (Some (Category_getValue c))
      )
      nil
    ]
  ].

Close Scope string.
Close Scope coqtl.