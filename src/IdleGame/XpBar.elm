module IdleGame.XpBar exposing (create)


type XpBar
    = XpBar Float


create : XpBar
create =
    XpBar 0

level : XpBar -> Int
level 
