module Layer exposing (layer, LayerCoverage(..), LayerMouseEvents(..))

import Html exposing (Html, div)
import Html.Attributes exposing (class)


type LayerCoverage
    = CoverToFit
    | CoverWithOverflow


type LayerMouseEvents
    = PassEvents
    | BlockEvents


layer : LayerCoverage -> LayerMouseEvents -> List (Html msg) -> Html msg
layer layerCoverage mouseEvents content =
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
        div [ class <| "layer " ++ coverageModifierClasses ++ " " ++ mouseModifierClasses ]
            [ div [ class "layer__content" ]
                content
            ]
