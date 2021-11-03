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
            (* title *)  
            (* link *)  
            (* description *)  
            (* language *)  
            (* copyright *)  
            (* managingEditor *)  
            (* webmaster *)  
            (* generator *)
            (* docs *)  
            (* ttl *)  
            (* rating *)  
            (* skipHours *)  
            (* pubDate *)  
            (* skipDays *)  
            (* lastBuildDate *)  
        )
        nil
    ]
  ].
Close Scope coqtl.