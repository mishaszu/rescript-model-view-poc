// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as React from "react";

function ModelView(Component) {
  var RMV$ModelView = function (Props) {
    var match = React.useReducer((function (param, param$1) {
            return Curry._2(Component.update, param, param$1);
          }), Component.initialModel);
    return Curry._2(Component.view, match[0], match[1]);
  };
  return {
          make: RMV$ModelView
        };
}

var DefaultProps = {};

function ModelViewProps(Component) {
  var useMake = function (props) {
    var match = React.useReducer((function (param, param$1) {
            return Curry._2(Component.update, param, param$1);
          }), Component.initialModel);
    return Curry._3(Component.view, match[0], match[1], props);
  };
  return {
          useMake: useMake,
          make: useMake
        };
}

function useSubscribe(model, props, dispatch) {
  
}

var DefaultSubscribe = {
  useSubscribe: useSubscribe
};

function ModelViewPropsEffect(Component) {
  var useMake = function (props) {
    var match = React.useReducer((function (param, param$1) {
            return Curry._2(Component.update, param, param$1);
          }), Component.initialModel);
    var dispatch = match[1];
    var model = match[0];
    Curry._3(Component.useSubscribe, model, props, dispatch);
    return Curry._3(Component.view, model, dispatch, props);
  };
  return {
          useMake: useMake,
          make: useMake
        };
}

export {
  ModelView ,
  DefaultProps ,
  ModelViewProps ,
  DefaultSubscribe ,
  ModelViewPropsEffect ,
  
}
/* react Not a pure module */