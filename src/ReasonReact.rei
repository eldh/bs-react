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
and jsElementWrapped =
  option(
    (
      ~key: Js.nullable(string),
      ~ref: Js.nullable(Js.nullable(reactRef) => unit)
    ) =>
    reactElement,
  )
and component = {
  debugName: string,
  reactClassInternal,
  jsElementWrapped,
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
let wrapJsForReason: (~reactClass: reactClass, ~props: 'a, 'b) => component;

module Router: {
  /** update the url with the string path. Example: `push("/book/1")`, `push("/books#title")` */
  let push: string => unit;
  type watcherID;
  type url = {
    /* path takes window.location.path, like "/book/title/edit" and turns it into `["book", "title", "edit"]` */
    path: list(string),
    /* the url's hash, if any. The # symbol is stripped out for you */
    hash: string,
    /* the url's query params, if any. The ? symbol is stripped out for you */
    search: string,
  };
  /** start watching for URL changes. Returns a subscription token. Upon url change, calls the callback and passes it the url record */
  let watchUrl: (url => unit) => watcherID;
  /** stop watching for URL changes */
  let unwatchUrl: watcherID => unit;
  /** this is marked as "dangerous" because you technically shouldn't be accessing the URL outside of watchUrl's callback;
      you'd read a potentially stale url, instead of the fresh one inside watchUrl.
      But this helper is sometimes needed, if you'd like to initialize a page whose display/state depends on the URL,
      instead of reading from it in watchUrl's callback, which you'd probably have put inside didMount (aka too late,
      the page's already rendered).
      So, the correct (and idiomatic) usage of this helper is to only use it in a component that's also subscribed to
      watchUrl. Please see https://github.com/reasonml-community/reason-react-example/blob/master/src/todomvc/TodoItem.re
      for an example.
      */
  let dangerouslyGetInitialUrl: unit => url;
  let useUrl: unit => url;
};

[@bs.module "react"] external fragment: 'a = "Fragment";