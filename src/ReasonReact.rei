type reactClass;

type jsProps;

type reactElement;

[@bs.val] external null: reactElement = "null";

external string: string => reactElement = "%identity";

type reactRefCurrent = Js.nullable(reactElement);

[@bs.deriving abstract]
type reactRef = {
  [@bs.as "current"]
  currentRef: reactRefCurrent,
};

external array: array(reactElement) => reactElement = "%identity";

external __currentToJsObj__: reactRefCurrent => Js.nullable(Js.t({..})) =
  "%identity";

let currentRefGetJs: reactRef => option(Js.t({..}));

[@bs.splice] [@bs.val] [@bs.module "react"]
external createElement:
  (reactClass, ~props: Js.t({..})=?, array(reactElement)) => reactElement =
  "createElement";

[@bs.val] [@bs.module "react"]
external createRef: unit => reactRef = "createRef";

[@bs.val] [@bs.module "react"]
external forwardRef: (. 'a) => 'a = "forwardRef";

[@bs.splice] [@bs.module "react"]
external cloneElement:
  (reactElement, ~props: Js.t({..})=?, array(reactElement)) => reactElement =
  "cloneElement";

[@bs.val] [@bs.module "react"]
external createElementVerbatim: 'a = "createElement";

let createDomElement: ('a, ~props: 'b, Js.Array.t('c)) => 'd;

[@bs.val] external magicNull: 'a = "null";

type reactClassInternal = reactClass;

type renderNotImplemented =
  | RenderNotImplemented;

/***
 * Elements are what JSX blocks become. They represent the *potential* for a
 * component instance and state to be created / updated. They are not yet
 * instances.
 */
 
type element =
  | Element(component): element
and jsPropsToReason('jsProps) = (. 'jsProps) => component
and jsElementWrapped =
  option(
    (~key: Js.nullable(string), ~ref: option(reactRef)) => reactElement,
  )
and component = {
  debugName: string,
  reactClassInternal,
  jsElementWrapped,
  render: option(reactRef) => reactElement,
};
let anyToUnit: 'a => unit;
let anyToTrue: 'a => bool;
let renderDefault: unit => reactElement;
let convertPropsIfTheyreFromJs: ('a, string) => 'b;
let createClass: string => reactClass;
let createForwardRefClass: string => reactClass;
let component: string => component;
let forwardRefComponent: string => component;
let statelessComponent: string => component;
/* 
let createForwardRefClass = debugName: reactClass =>
  ReasonReactOptimizedCreateClass.createClass(. {
    "displayName": debugName,
    "render":
      forwardRef(.(props, ref: option(reactRef)) => {
        let convertedReasonProps =
          convertPropsIfTheyreFromJs(props, debugName);
        let Element(created) = Obj.magic(convertedReasonProps);
        let component = created;
        Js.log2("ref", ref);

        component.render(ref);
      }),
  }); */

let element:
  (~key: string=?, ~ref: option(reactRef)=?, component) =>
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
      ~ref: option(reactRef),
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