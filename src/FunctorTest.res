module Definition = {
  type action =
    | Add
    | Remove

  type model = {value: int}

  type dispatch = action => unit

  type props = {title: string}

  let update = (model, action) =>
    switch action {
    | Add => {value: model.value + 1}
    | Remove => {value: model.value - 1}
    }

  let initialModel = {value: 0}

  let view = (~model, ~dispatch, ~props) => {
    module AddButton = {
      @react.component
      let make = () => <button onClick={_ => dispatch(Add)}> {"Add" |> React.string} </button>
    }

    module RemoveButton = {
      @react.component
      let make = () => <button onClick={_ => dispatch(Remove)}> {"Remove" |> React.string} </button>
    }

    <div>
      <h1> {props.title |> React.string} </h1>
      <h2> {("Counter: " ++ string_of_int(model.value))->React.string} </h2>
      <AddButton />
      <RemoveButton />
    </div>
  }

}

include RMV.ModelViewProps(Definition)
@obj external makeProps: (~title: string, unit) => Definition.props = ""
