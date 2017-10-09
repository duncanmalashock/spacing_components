module Main exposing (..)

import Layer exposing (layers, Layer(..), LayerCoverage(..), LayerMouseEvents(..))
import Space exposing (Space(..))
import Container exposing (Container(..), container)
import Grid exposing (grid, GridItem(..))
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


exampleComponent : String -> Html msg
exampleComponent string =
    div [ class "example-component clickable" ]
        [ text string ]


exampleComponents : List (Html msg)
exampleComponents =
    repeat 7 (exampleComponent "Hello world!")


repeat : Int -> a -> List a
repeat n x =
    if n <= 0 then
        []
    else
        x :: repeat (n - 1) x


card : Html msg
card =
    div []
        [ div [ class "image" ] []
        , div [ class "fill fill--light" ]
            [ container (InsetContainer SpaceL)
                [ container (StackContainer SpaceL)
                    [ container (StackContainer SpaceS)
                        [ header "s" "Video"
                        , header "l" "Supernova"
                        ]
                    , paragraph "s" "An astronomical event that occurs during the last stages of a massive star's life."
                    , container (InlineContainer SpaceM SpaceM)
                        [ tag "Galaxies"
                        , tag "Milky Way"
                        , tag "Speed of Light"
                        ]
                    , container (InlineContainer SpaceM SpaceM)
                        [ button "View" ]
                    ]
                ]
            ]
        ]


tag : String -> Html msg
tag txt =
    div [ class "tag fill fill--medium" ]
        [ div [ class "tag__text" ]
            [ text txt ]
        ]


button : String -> Html msg
button txt =
    div [ class "button fill fill--blue" ]
        [ div [ class "button__text" ]
            [ text txt ]
        ]


header : String -> String -> Html msg
header classModifier txt =
    div [ class <| "header header--" ++ classModifier ]
        [ text txt ]


paragraph : String -> String -> Html msg
paragraph classModifier txt =
    div [ class <| "paragraph paragraph--" ++ classModifier ]
        [ text txt ]


appContentView : Model -> List (Html Msg)
appContentView model =
    [ container
        (InsetContainer SpaceXXL)
        [ grid ( 3, SpaceL, SpaceL )
            [ GridItem 1 card
            , GridItem 1 card
            , GridItem 1 card
            , GridItem 1 card
            , GridItem 1 card
            ]
        ]
    ]


menusView : Model -> List (Html Msg)
menusView model =
    [ container
        (InlineContainer SpaceM SpaceM)
        exampleComponents
    ]


view : Model -> Html Msg
view model =
    layers
        [ Layer "app-content" CoverWithOverflow BlockEvents (appContentView model)
        , Layer "menus" CoverToFit PassEvents (menusView model)
        ]
