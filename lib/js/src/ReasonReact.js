'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Js_primitive = require("bs-platform/lib/js/js_primitive.js");
var Caml_builtin_exceptions = require("bs-platform/lib/js/caml_builtin_exceptions.js");
var ReasonReactOptimizedCreateClass = require("./ReasonReactOptimizedCreateClass.js");

function createDomElement(s, props, children) {
  var vararg = /* array */[
      s,
      props
    ].concat(children);
  return React.createElement.apply(null, vararg);
}

function anyToUnit(param) {
  return /* () */0;
}

function anyToTrue(param) {
  return true;
}

function renderDefault(param) {
  return "RenderNotImplemented";
}

function convertPropsIfTheyreFromJs(props, debugName) {
  var match = props.reasonProps;
  if (match == null) {
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "A JS component called the Reason component " + debugName
        ];
  } else {
    return match;
  }
}

function createClass(debugName) {
  return ReasonReactOptimizedCreateClass.createClass({
              displayName: debugName,
              render: (function (props) {
                  var convertedReasonProps = convertPropsIfTheyreFromJs(props, debugName);
                  return Curry._1(convertedReasonProps[0][/* render */2], /* () */0);
                })
            });
}

function component(debugName) {
  return /* record */[
          /* debugName */debugName,
          /* reactClassInternal */createClass(debugName),
          /* render */renderDefault
        ];
}

var statelessComponent = component;

function element($staropt$star, $staropt$star$1, component) {
  var key = $staropt$star !== undefined ? $staropt$star : undefined;
  var ref = $staropt$star$1 !== undefined ? $staropt$star$1 : undefined;
  var element$1 = /* Element */[component];
  return React.createElement(component[/* reactClassInternal */1], {
              key: key,
              ref: ref,
              reasonProps: element$1
            });
}

function wrapReasonForJs(component, jsPropsToReason) {
  var jsPropsToReason$1 = function (jsProps) {
    return jsPropsToReason(jsProps);
  };
  var tmp = component[/* reactClassInternal */1].prototype;
  tmp.jsPropsToReason = Js_primitive.some(jsPropsToReason$1);
  return component[/* reactClassInternal */1];
}

function wrapProps(reactClass, props, children, key, ref) {
  var props$1 = Object.assign(Object.assign({ }, props), {
        ref: ref,
        key: key
      });
  var varargs = /* array */[
      reactClass,
      props$1
    ].concat(children);
  return React.createElement.apply(null, varargs);
}

var WrapProps = /* module */[/* wrapProps */wrapProps];

exports.createDomElement = createDomElement;
exports.anyToUnit = anyToUnit;
exports.anyToTrue = anyToTrue;
exports.renderDefault = renderDefault;
exports.convertPropsIfTheyreFromJs = convertPropsIfTheyreFromJs;
exports.createClass = createClass;
exports.component = component;
exports.statelessComponent = statelessComponent;
exports.element = element;
exports.wrapReasonForJs = wrapReasonForJs;
exports.WrapProps = WrapProps;
/* react Not a pure module */
