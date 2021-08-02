module type mv_base = {
  type action
  type model
  let initialModel: model
  let update: (model, action) => model
  type dispatch = action => unit
}

// model-view
module type mv = {
  include mv_base
  let view: (~model: model, ~dispatch: dispatch) => React.element
}

module ModelView = (Component: mv) => {
  @react.component
  let make = () => {
    let (model, dispatch) = React.useReducer(Component.update, Component.initialModel)
    Component.view(~model, ~dispatch)
  }
}

// model-view-props
module type mvp = {
  include mv_base
  type props
  let view: (~model: model, ~dispatch: dispatch, ~props: props) => React.element
}

module DefaultProps = {
  type props = unit
}

module ModelViewProps = (Component: mvp) => {
  let useMake = (props: Component.props) => {
    let (model, dispatch) = React.useReducer(Component.update, Component.initialModel)
    Component.view(~model, ~dispatch, ~props)
  }
  let make = useMake
}

// model-view-props-subscribe
module type mvps = {
  include mvp
  let useSubscribe: (~model: model, ~props: props, ~dispatch: dispatch) => unit
}

module DefaultSubscribe = {
  let useSubscribe = (~model, ~props, ~dispatch) => ()
}

module ModelViewPropsEffect = (Component: mvps) => {
  let useMake = (props: Component.props) => {
    let (model, dispatch) = React.useReducer(Component.update, Component.initialModel)
    Component.useSubscribe(~model, ~dispatch, ~props)
    Component.view(~model, ~props, ~dispatch)
  }
  let make = useMake
}

// model-view-props-subscribe-trine

module type mvpst = {
  include mv_base

  type props
  type success
  type loading
  type error

  let useSubscribe: (~model: model, ~props: props, ~dispatch: dispatch) => unit

  let successView: (~model: success, ~props: props, ~dispatch: dispatch) => React.element
  let loadingView: (~model: success, ~props: props, ~dispatch: dispatch) => React.element
  let errorView: (~model: success, ~props: props, ~dispatch: dispatch) => React.element
}
