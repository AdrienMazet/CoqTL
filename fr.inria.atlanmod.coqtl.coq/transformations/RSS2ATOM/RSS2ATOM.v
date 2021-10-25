Require Import RSS2ATOM.ATOM.
Require Import RSS2ATOM.RSS.

Definition RSS2ATOM :=
  transformation from RSS to ATOM
    with m as RSSModel := [
      rule "..." 
        from 
          r class RSS 
        to [
          "..."
        ];
    ].