'use strict';

var React = require("react");
var ReasonReact = require("./ReasonReact.js");

function Create(Config) {
  var _pair = React.createContext(Config[/* defaultValue */0]);
  var make = function (value, children) {
    return ReasonReact.wrapJsForReason(_pair.Provider, {
                value: value
              }, children);
  };
  var Provider = /* module */[/* make */make];
  var make$1 = function (children) {
    return ReasonReact.wrapJsForReason(_pair.Consumer, { }, children);
  };
  var Consumer = /* module */[/* make */make$1];
  return /* module */[
          /* _pair */_pair,
          /* Provider */Provider,
          /* Consumer */Consumer
        ];
}

exports.Create = Create;
/* react Not a pure module */
