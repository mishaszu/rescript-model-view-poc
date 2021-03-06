// Generated by ReScript, PLEASE EDIT WITH CARE

import * as RMV from "./RMV.bs.js";
import * as $$Array from "rescript/lib/es6/array.js";
import * as Curry from "rescript/lib/es6/curry.js";
import * as React from "react";
import * as Future from "reason-future/src/Future.bs.js";
import * as FutureJs from "reason-future/src/FutureJs.bs.js";
import * as Json_decode from "@glennsl/bs-json/src/Json_decode.bs.js";

function get(url) {
  return Future.flatMap(FutureJs.fromPromise(fetch(url), (function (_err) {
                    
                  })), (function (value) {
                if (value.TAG !== /* Ok */0) {
                  return Future.value(undefined, {
                              TAG: /* Error */1,
                              _0: "can't connect"
                            });
                }
                var response = value._0;
                if (response.status === 200) {
                  return FutureJs.fromPromise(response.json(), (function (_err) {
                                return "Fetch json parse error";
                              }));
                } else {
                  return Future.value(undefined, {
                              TAG: /* Error */1,
                              _0: "can't connect"
                            });
                }
              }));
}

function update(model, action) {
  return {
          status: action
        };
}

function errorView(model, props, dispatch) {
  return React.createElement("h1", undefined, model);
}

function loadingView(model, props, dispatch) {
  return React.createElement("h1", undefined, model);
}

function successView(model, props, dispatch) {
  return React.createElement("div", undefined, React.createElement("h1", undefined, "List of names:"), $$Array.map((function (value) {
                    return React.createElement("div", {
                                key: value.id
                              }, React.createElement("h2", undefined, value.name + ": " + value.id));
                  }), model.values));
}

function view(model, props, dispatch) {
  var result = model.status;
  switch (result.TAG | 0) {
    case /* Loading */0 :
        return loadingView(result._0, props, dispatch);
    case /* Success */1 :
        return successView(result._0, props, dispatch);
    case /* CompError */2 :
        return errorView(result._0, props, dispatch);
    
  }
}

function decodeName(json) {
  return {
          id: Json_decode.field("id", Json_decode.string, json),
          name: Json_decode.field("name", Json_decode.string, json)
        };
}

function useSubscribe(model, props, dispatch) {
  React.useEffect((function () {
          Future.get(get(props.url), (function (value) {
                  if (value.TAG === /* Ok */0) {
                    return Curry._1(dispatch, {
                                TAG: /* Success */1,
                                _0: {
                                  values: Json_decode.array(decodeName, value._0)
                                }
                              });
                  } else {
                    return Curry._1(dispatch, {
                                TAG: /* CompError */2,
                                _0: "Can't load"
                              });
                  }
                }));
          
        }), []);
  
}

var Definition_initialModel = {
  status: {
    TAG: /* Loading */0,
    _0: "Loading names"
  }
};

var Definition = {
  initialModel: Definition_initialModel,
  update: update,
  useSubscribe: useSubscribe,
  successView: successView,
  loadingView: loadingView,
  errorView: errorView,
  view: view
};

var include = RMV.ModelViewPropsSubscribeTrine(Definition);

var useMake = include.useMake;

var make = include.make;

export {
  get ,
  Definition ,
  useMake ,
  make ,
  
}
/* include Not a pure module */
