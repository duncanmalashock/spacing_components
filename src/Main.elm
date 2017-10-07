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
    = SpaceZero
    | SpaceXS
    | SpaceS
    | SpaceM
    | SpaceL
    | SpaceXL


spaceClassSuffix : Space -> String
spaceClassSuffix space =
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


type Container
    = InsetContainer Space
    | StackContainer Space
    | InlineContainer Space Space


type GridItem msg
    = GridItem Int (Html msg)


grid : ( Int, Space, Space ) -> List (GridItem msg) -> Html msg
grid ( columns, gutterSpace, stackSpace ) gridItems =
    let
        modifierClasses =
            "grid--columns-"
                ++ (toString columns)
                ++ " grid--gutter-"
                ++ (spaceClassSuffix gutterSpace)
                ++ " grid--stack-"
                ++ (spaceClassSuffix stackSpace)

        gridItemView item =
            case item of
                GridItem columnsWide itemHtml ->
                    div [ class "grid__item" ]
                        [ itemHtml ]
    in
        div [ class <| "grid " ++ modifierClasses ]
            (List.map gridItemView gridItems)


container : Container -> List (Html msg) -> Html msg
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
                ( 7, SpaceM, SpaceM )
                [ GridItem 1 <| exampleComponent "Hello, world!"
                , GridItem 1 <| exampleComponent "Hello, world!"
                , GridItem 1 <| exampleComponent "Hello, world!"
                , GridItem 1 <| exampleComponent "Hello, world!"
                ]
            , container
                (InlineContainer SpaceM SpaceM)
                exampleComponents
            ]
        ]
