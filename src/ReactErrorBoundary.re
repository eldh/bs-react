%raw
"/* eslint-disable */";

[@bs.module "./jsErrorBoundary"]
external errorBoundary: ReasonReact.reactClass = "ErrorBoundary";

[@bs.deriving abstract]
type errorInfo = {componentStack: string};

let make =
    (
      ~didCatch: (Js_exn.t, errorInfo) => unit,
      ~renderError: Js_exn.t => ReasonReact.reactElement,
      children,
    ) =>
  ReasonReact.wrapJsForReason(
    ~reactClass=errorBoundary,
    ~props={"didCatch": didCatch, "renderError": renderError},
    children,
  );