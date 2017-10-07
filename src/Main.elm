module Main exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    {}


initialModel : Model
initialModel =
    {}


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type Space
    = SpaceXS
    | SpaceS
    | SpaceM
    | SpaceL
    | SpaceXL


spaceClassSuffix : Space -> String
spaceClassSuffix space =
    case space of
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


type Container msg
    = InsetContainer Space
    | StackContainer Space
    | InlineContainer Space Space
    | GridContainer Int Space Space


container : Container Msg -> List (Html Msg) -> Html Msg
container c containerItems =
    let
        modifierClasses =
            case c of
                InsetContainer insetSpace ->
                    "container--inset-" ++ (spaceClassSuffix insetSpace)

                StackContainer stackSpace ->
                    "container--stack-" ++ (spaceClassSuffix stackSpace)

                InlineContainer inlineSpace stackSpace ->
                    "container--inline-"
                        ++ (spaceClassSuffix inlineSpace)
                        ++ " container--inline-stack-"
                        ++ (spaceClassSuffix stackSpace)

                GridContainer columns gutterSpace stackSpace ->
                    "container--grid-"
                        ++ (toString columns)
                        ++ " container--grid-inline-"
                        ++ (spaceClassSuffix gutterSpace)
                        ++ " container--grid-stack-"
                        ++ (spaceClassSuffix stackSpace)

        containerItemView containerItem =
            div [ class "container__item" ]
                [ containerItem ]
    in
        div [ class <| "container " ++ modifierClasses ]
            (List.map containerItemView containerItems)


exampleComponent : String -> Html msg
exampleComponent string =
    div [ class "example-component" ]
        [ text string ]


view : Model -> Html Msg
view model =
    container
        (InsetContainer SpaceXL)
        [ container
            (StackContainer SpaceXL)
            [ container
                (InlineContainer SpaceM SpaceM)
                [ exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                ]
            , container
                (StackContainer SpaceM)
                [ exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                ]
            , container
                (GridContainer 7 SpaceM SpaceM)
                [ exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                ]
            , container
                (GridContainer 3 SpaceM SpaceM)
                [ exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                ]
            , container
                (InlineContainer SpaceM SpaceM)
                [ exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                , exampleComponent "Hello world!"
                ]
            ]
        ]
