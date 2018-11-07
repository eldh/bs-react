type reactClass;
type jsProps;
type reactElement;
type reactRef;
[@bs.val] external null: reactElement = "null";
external string: string => reactElement = "%identity";
external array: array(reactElement) => reactElement = "%identity";
external refToJsObj: reactRef => Js.t({..}) = "%identity";
[@bs.splice] [@bs.val] [@bs.module "react"]
external createElement:
  (reactClass, ~props: Js.t({..})=?, array(reactElement)) => reactElement =
  "createElement";

[@bs.splice] [@bs.module "react"]
external cloneElement:
  (reactElement, ~props: Js.t({..})=?, array(reactElement)) => reactElement =
  "cloneElement";
[@bs.module "react"] external createElementVerbatim: 'a = "createElement";
let createDomElement: ('a, ~props: 'b, Js.Array.t('c)) => 'd;
[@bs.val] external magicNull: 'a = "null";
type reactClassInternal = reactClass;
type renderNotImplemented =
  | RenderNotImplemented;
type element =
  | Element(component): element
and jsPropsToReason('jsProps) = (. 'jsProps) => component
and component = {
  debugName: string,
  reactClassInternal,
  render: unit => reactElement,
};
let anyToUnit: 'a => unit;
let anyToTrue: 'a => bool;
let renderDefault: unit => reactElement;
let convertPropsIfTheyreFromJs: ('a, string) => 'b;
let createClass: string => reactClass;
let component: string => component;
let statelessComponent: string => component;
let element:
  (~key: string=?, ~ref: Js.nullable(reactRef) => unit=?, component) =>
  reactElement;
let wrapReasonForJs:
  (~component: component, jsPropsToReason('jsProps)) => reactClassInternal;
module WrapProps: {
  let wrapProps:
    (
      ~reactClass: 'a,
      ~props: 'b,
      'c,
      ~key: Js.nullable(string),
      ~ref: Js.nullable(Js.nullable(reactRef) => unit)
    ) =>
    'd;
};
[@bs.module "react"] external fragment: 'a = "Fragment";