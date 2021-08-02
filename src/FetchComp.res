let get = url => {
  Fetch.fetch(url)
  ->FutureJs.fromPromise(_err => None)
  ->Future.flatMap(value =>
    switch value {
    | Ok(response) if response |> Fetch.Response.status == 200 =>
      (response |> Fetch.Response.json)->FutureJs.fromPromise(_err => "Fetch json parse error")
    | _ => Future.value(Error("can't connect"))
    }
  )
}

module Definition: RMV.mvpst = {
  type nameObj = {id: string, name: string}
  type success = {values: array<nameObj>}
  type loading = string
  type error = string

  type action =
    | Loading(loading)
    | Success(success)
    | CompError(error)

  type dispatch = action => unit

  type model = {status: action}
  let update = (model, action) => {status: action}
  let initialModel = {status: Loading("Loading names")}

  type props = {url: string}

  let errorView = (~model, ~props, ~dispatch) => <h1> {model->React.string} </h1>
  let loadingView = (~model, ~props, ~dispatch) => <h1> {model->React.string} </h1>
  let successView = (~model, ~props, ~dispatch) =>
    <div>
      <h1> {"List of names:"->React.string} </h1>
      {model.values
      |> Array.map(value =>
        <div key=value.id> <h2> {(value.name ++ ": " ++ value.id)->React.string} </h2> </div>
      )
      |> React.array}
    </div>
  let view = (~model, ~props, ~dispatch) => {
    switch model.status {
        | Success(result) => successView(~model=result, ~props, ~dispatch)
        | Loading(result) => loadingView(~model=result, ~props, ~dispatch)
        | CompError(result) => errorView(~model=result, ~props, ~dispatch)
    }
  }

  let decodeName = json => {
    open Json.Decode
    {
      id: json |> field("id", string),
      name: json |> field("name", string),
    }
    }

  let useSubscribe = (~model, ~props, ~dispatch) => {
    React.useEffect0(() => {
      get(props.url)
      -> Future.get(value => switch value {
        |Ok(value) => Success({values: value |> Json.Decode.array(decodeName)}) |> dispatch
        |Error(_) => CompError("Can't load") |> dispatch
      })
      None
    })
  }
}

include RMV.ModelViewPropsSubscribeTrine(Definition)
@obj external makeProps: (~url: string, unit) => Definition.props = ""
