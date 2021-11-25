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

Instance A2RConfiguration : TransformationConfiguration := 
  Build_TransformationConfiguration ATOMMetamodel_Metamodel_Instance RSSMetamodel_Metamodel_Instance.

Instance ATOM2RSSConfiguration : ModelingTransformationConfiguration A2RConfiguration :=
 Build_ModelingTransformationConfiguration A2RConfiguration ATOMMetamodel_ModelingMetamodel_Instance RSSMetamodel_ModelingMetamodel_Instance.

Open Scope coqtl.
Open Scope string.

Definition ATOM2RSS :=
  transformation
  [
    rule "ATOM2Channel"
    from [ATOMClass]
    to
    [
      elem [ATOMClass] ChannelClass "channel"
      (
        fun i m a => BuildChannel
        (ATOM_getTitle a)
        (* link *)  
        (ATOM_getSubtitle a) 
        (* language *)  
        (value (ATOM_getRights a))  
        (* managingEditor *)  
        (* webmaster *)  
        (* generator *)
        (* docs *)  
        (* ttl *)  
        (* rating *)  
        (* skipHours *)  
        (* pubDate *)  
        (* skipDays *)  
        (Some (ATOM_getLastUpdate a))
      )
      [
        link [ATOMClass] ChannelClass ChannelCategoryReference
        (
          fun tls i m a c => maybeBuildChannelCategory c
          (
            maybeResolveAll tls m "entries" RSS.CategoryClass
            (
              maybeSingleton (ATOM_getEntrieObjects a m)
            )
          )
        )
      ]
    ];
    rule "Entry2Item"
    from [EntryClass]
    to
    [
      elem [EntryClass] ItemClass "item"
      (
        fun i m entry => BuildItem
        (Entry_getTitle entry)
        (* link *)
        (* description *)
        (Entry_getPublished entry)
        (* author *)
        (Entry_getSummary entry)
        (Entry_getId entry)
      )
      [
        link [EntryClass] ItemClass (*to change ->*)EntryLinksReference
        (
          fun tls i m a item => (*to change ->*)maybeBuildEntryLinks item
          (
            (*change the following function*)
            maybeResolveAll tls m "link" ATOM.LinkClass
            (
              None (* TODO *)
            )
          )
        )
      ]
    ]
  ].

Close Scope string.
Close Scope coqtl.