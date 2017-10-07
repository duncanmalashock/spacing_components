module Container exposing (container, Container(..))

import Space exposing (Space(..))
import Html exposing (Html, div)
import Html.Attributes exposing (class)


type Container
    = InsetContainer Space
    | StackContainer Space
    | InlineContainer Space Space


container : Container -> List (Html msg) -> Html msg
container c containerItems =
    let
        modifierClasses =
            case c of
                InsetContainer insetSpace ->
                    "container--inset-" ++ (Space.classSuffix insetSpace)

                StackContainer stackSpace ->
                    "container--stack-" ++ (Space.classSuffix stackSpace)

                InlineContainer inlineSpace stackSpace ->
                    "container--inline-"
                        ++ (Space.classSuffix inlineSpace)
                        ++ " container--inline-stack-"
                        ++ (Space.classSuffix stackSpace)

        containerItemView containerItem =
            div [ class "container__item" ]
                [ containerItem ]
    in
        div [ class <| "container " ++ modifierClasses ]
            (List.map containerItemView containerItems)
