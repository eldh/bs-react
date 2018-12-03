%raw
"/* eslint-disable */";

[@bs.module "react"] external useState: 'a => ('a, (. 'a) => unit) = "";

[@bs.module "react"]
external useEffect: (unit => (. unit) => unit, array('a)) => unit = "";

[@bs.module "react"]
external useEffectWithoutDependencies: (unit => (. unit) => unit) => unit = "useEffect";

[@bs.module "react"]
external useEffectWithoutCleanup: (unit => option(unit), array('a)) => unit = "useEffect";

[@bs.module "react"]
external useEffectWithoutCleanupOrDependencies: (unit => option(unit)) => unit = "useEffect";

[@bs.module "react"]
external useMutationEffect: (unit => (. unit) => unit) => unit = "";

[@bs.module "react"]
external useLayoutEffect: (unit => (. unit) => unit) => unit = "";

[@bs.module "react"]
external useMutationEffectWithoutCleanup: (unit => unit) => unit = "";

[@bs.module "react"]
external useLayoutEffectWithoutCleanup: (unit => unit) => unit = "";

[@bs.module "react"] external useCallback: (unit => 'a, 'b, unit) => 'a = "";

[@bs.module "react"] external useMemo: (unit => 'a, 'b) => 'a = "";

[@bs.module "react"] external useRef: 'a => {. "current": 'a} = "";

[@bs.module "react"]
external useDomRef: unit => {. "current": option(Dom.node)} = "useRef";

[@bs.module "react"]
external useReducer:
  (~reducer: (. 'state, 'action) => 'state, ~initial: 'state) =>
  ('state, (. 'action) => unit) =
  "";

/* Not doing useImperativeMethods because it's super confusing. */