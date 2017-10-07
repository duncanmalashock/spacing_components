module Grid exposing (GridItem(..), grid)

import Space exposing (Space(..))
import Html exposing (Html, div)
import Html.Attributes exposing (class)


type GridItem msg
    = GridItem Int (Html msg)


grid : ( Int, Space, Space ) -> List (GridItem msg) -> Html msg
grid ( columns, gutterSpace, stackSpace ) gridItems =
    let
        modifierClasses =
            "grid--columns-"
                ++ (toString columns)
                ++ " grid--gutter-"
                ++ (Space.classSuffix gutterSpace)
                ++ " grid--stack-"
                ++ (Space.classSuffix stackSpace)

        gridItemView item =
            case item of
                GridItem columnsWide itemHtml ->
                    div [ class "grid__item" ]
                        [ itemHtml ]
    in
        div [ class <| "grid " ++ modifierClasses ]
            (List.map gridItemView gridItems)
