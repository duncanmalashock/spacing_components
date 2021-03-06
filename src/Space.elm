module Space exposing (Space(..), classSuffix)


type Space
    = SpaceZero
    | SpaceXS
    | SpaceS
    | SpaceM
    | SpaceL
    | SpaceXL
    | SpaceXXL


classSuffix : Space -> String
classSuffix space =
    case space of
        SpaceZero ->
            "zero"

        SpaceXS ->
            "xs"

        SpaceS ->
            "s"

        SpaceM ->
            "m"

        SpaceL ->
            "l"

        SpaceXL ->
            "xl"

        SpaceXXL ->
            "xxl"
