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

[@bs.val] [@bs.module "react"]
external createElementVerbatim: 'a = "createElement";

let createDomElement = (s, ~props, children) => {
  let vararg =
    [|Obj.magic(s), Obj.magic(props)|] |> Js.Array.concat(children);
  /* Use varargs to avoid warnings on duplicate keys in children */
  Obj.magic(createElementVerbatim)##apply(Js.Nullable.null, vararg);
};

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
and component = {
  debugName: string,
  reactClassInternal,
  render: unit => reactElement,
};

let anyToUnit = _ => ();

let anyToTrue = _ => true;

let renderDefault = () => string("RenderNotImplemented");
let convertPropsIfTheyreFromJs = (props, debugName) => {
  let props = Obj.magic(props);
  switch (Js.Nullable.toOption(props##reasonProps)) {
  | Some(props) => props
  | None =>
    raise(
      Invalid_argument(
        "A JS component called the Reason component " ++ debugName,
      ),
    )
  };
};

let createClass = debugName: reactClass =>
  ReasonReactOptimizedCreateClass.createClass(. {
    "displayName": debugName,
    "render": props => {
      let convertedReasonProps = convertPropsIfTheyreFromJs(props, debugName);
      let Element(created) = Obj.magic(convertedReasonProps);
      let component = created;
      component.render();
    },
  });

let component = debugName => {
  let componentTemplate = {
    reactClassInternal: createClass(debugName),
    debugName,
    render: renderDefault,
  };
  componentTemplate;
};

let statelessComponent = debugName: component => component(debugName);

/***
 * Convenience for creating React elements before we have a better JSX transform.  Hopefully this makes it
 * usable to build some components while waiting to migrate the JSX transform to the next API.
 *
 * Constrain the component here instead of relying on the Element constructor which would lead to confusing
 * error messages.
 */
let element =
    (
      ~key: string=Obj.magic(Js.Nullable.undefined),
      ~ref: Js.nullable(reactRef) => unit=Obj.magic(Js.Nullable.undefined),
      component: component,
    ) => {
  let element = Element(component);
  createElement(
    component.reactClassInternal,
    ~props={"key": key, "ref": ref, "reasonProps": element},
    [||],
  );
};

let wrapReasonForJs =
    (~component, jsPropsToReason: jsPropsToReason('jsProps)) => {
  let jsPropsToReason: jsPropsToReason(jsProps) =
    (. jsProps) => (Obj.magic(jsPropsToReason))(. jsProps);
  Obj.magic(component.reactClassInternal)##prototype##jsPropsToReason
  #= Some(jsPropsToReason);
  component.reactClassInternal;
};

module WrapProps = {
  /* We wrap the props for reason->reason components, as a marker that "these props were passed from another
     reason component" */
  let wrapProps =
      (
        ~reactClass,
        ~props,
        children,
        ~key: Js.nullable(string),
        ~ref: Js.nullable(Js.nullable(reactRef) => unit),
      ) => {
    let props =
      Js.Obj.assign(
        Js.Obj.assign(Js.Obj.empty(), Obj.magic(props)),
        {"ref": ref, "key": key},
      );
    let varargs =
      [|Obj.magic(reactClass), Obj.magic(props)|]
      |> Js.Array.concat(Obj.magic(children));
    /* Use varargs under the hood */
    Obj.magic(createElementVerbatim)##apply(Js.Nullable.null, varargs);
  };
};

[@bs.module "react"] external fragment: 'a = "Fragment";