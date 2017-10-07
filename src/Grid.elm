module Grid exposing (GridItem(..), grid)

import Space exposing (Space(..))
import Html exposing (Html, div)
import Html.Attributes exposing (class)


type GridItem msg
    = GridItem Int (Html msg)


grid : ( Int, Space, Space ) -> List (GridItem msg) -> Html msg
grid ( columns, gutterSpace, stackSpace ) gridItems =
    let
        gridModifierClasses =
            "grid--columns-"
                ++ (toString columns)
                ++ " grid--gutter-"
                ++ (Space.classSuffix gutterSpace)
                ++ " grid--stack-"
                ++ (Space.classSuffix stackSpace)

        gridItemView (GridItem columnsWide itemHtml) =
            let
                itemModifierClasses =
                    "grid__item--"
                        ++ (toString columnsWide)
                        ++ "-columns-wide"
            in
                div [ class <| "grid__item " ++ itemModifierClasses ]
                    [ itemHtml ]
    in
        div [ class <| "grid " ++ gridModifierClasses ]
            (List.map gridItemView gridItems)
