type model = {value: int}
type state = 
    | Loading
    | Error
    | Loaded(model)

let initialModel = {
  value: 0,
}

type action =
  | Add
  | Remove

let update = (model: model, action: action) => {
  switch action {
  | Add => {value: model.value + 1}
  | Remove => {value: model.value - 1}
  }
}

type props = {title: string}

let view = (~model: model, ~dispatch: action => unit, (), ~props) => {
  module AddButton = {
    @react.component
    let make = () => <button onClick={_ => dispatch(Add)}> {"Add"->React.string} </button>
  }
  let remove = () => <button onClick={_ => dispatch(Remove)}> {"Remove"->React.string} </button>
  <div>
    <h1>{props.title |> React.string}</h1>
    <h2> {("Counter: " ++ string_of_int(model.value))->React.string} </h2> <AddButton /> {remove()}
  </div>
}

let initEffects = (~model, ~dispatch) => ()
let useSubscribe = (~model, ~dispatch) => ()

let componentInitialization = model => {
  model
}

let make = (props) => {
  let (model, dispatch) = React.useReducerWithMapState(
    update,
    initialModel,
    componentInitialization,
  )
  view(~model, ~dispatch, ~props)()
}

@obj external makeProps: (~title: string, unit) => props = ""
