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
                  return Curry._1(convertedReasonProps[0][/* render */3], /* () */0);
                })
            });
}

function component(debugName) {
  return /* record */[
          /* debugName */debugName,
          /* reactClassInternal */createClass(debugName),
          /* jsElementWrapped */undefined,
          /* render */renderDefault
        ];
}

var statelessComponent = component;

function element($staropt$star, $staropt$star$1, component) {
  var key = $staropt$star !== undefined ? $staropt$star : undefined;
  var ref = $staropt$star$1 !== undefined ? $staropt$star$1 : undefined;
  var element$1 = /* Element */[component];
  var match = component[/* jsElementWrapped */2];
  if (match !== undefined) {
    return Curry._2(match, key, ref);
  } else {
    return React.createElement(component[/* reactClassInternal */1], {
                key: key,
                ref: ref,
                reasonProps: element$1
              });
  }
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

var dummyInteropComponent = component("Interop");

function wrapJsForReason(reactClass, props, children) {
  var jsElementWrapped = (function (param, param$1) {
      return wrapProps(reactClass, props, children, param, param$1);
    });
  return /* record */[
          /* debugName */dummyInteropComponent[/* debugName */0],
          /* reactClassInternal */dummyInteropComponent[/* reactClassInternal */1],
          /* jsElementWrapped */jsElementWrapped,
          /* render */dummyInteropComponent[/* render */3]
        ];
}

var WrapProps = [wrapProps];

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
exports.wrapJsForReason = wrapJsForReason;
/* dummyInteropComponent Not a pure module */
