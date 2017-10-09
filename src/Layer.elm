module Layer
    exposing
        ( layers
        , Layer(..)
        , LayerCoverage(..)
        , LayerMouseEvents(..)
        )

import Html exposing (Html, div)
import Html.Attributes exposing (class)


type LayerCoverage
    = CoverToFit
    | CoverWithOverflow


type LayerMouseEvents
    = PassEvents
    | BlockEvents


type Layer msg
    = Layer String LayerCoverage LayerMouseEvents (List (Html msg))


layers : List (Layer msg) -> Html msg
layers layerList =
    div [ class "layers" ]
        (List.map layer layerList)


layer : Layer msg -> Html msg
layer (Layer layerName layerCoverage mouseEvents content) =
    let
        coverageModifierClasses =
            case layerCoverage of
                CoverToFit ->
                    "layer--cover-to-fit"

                CoverWithOverflow ->
                    "layer--cover-with-overflow"

        mouseModifierClasses =
            case mouseEvents of
                PassEvents ->
                    "layer--pass-events"

                BlockEvents ->
                    "layer--block-events"
    in
        div
            [ class <|
                "layer layer--name-"
                    ++ layerName
                    ++ " "
                    ++ coverageModifierClasses
                    ++ " "
                    ++ mouseModifierClasses
            ]
            [ div [ class "layer__content" ]
                content
            ]
