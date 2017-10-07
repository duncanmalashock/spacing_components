module Main exposing (..)

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
    div [ class "example-component" ]
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


view : Model -> Html Msg
view model =
    container
        (InsetContainer SpaceXL)
        [ container
            (StackContainer SpaceXL)
            [ container
                (InlineContainer SpaceM SpaceM)
                exampleComponents
            , container
                (StackContainer SpaceM)
                exampleComponents
            , grid
                ( 6, SpaceM, SpaceM )
                [ GridItem 1 <| exampleComponent "Hello, world!"
                , GridItem 1 <| exampleComponent "Hello, world!"
                , GridItem 1 <| exampleComponent "Hello, world!"
                , GridItem 1 <| exampleComponent "Hello, world!"
                , GridItem 1 <| exampleComponent "Hello, world!"
                , GridItem 1 <| exampleComponent "Hello, world!"
                , GridItem 1 <| exampleComponent "Hello, world!"
                ]
            , container
                (InlineContainer SpaceM SpaceM)
                exampleComponents
            ]
        ]
