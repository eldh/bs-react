let _assign = Js.Obj.assign;

let emptyObject = Js.Obj.empty();

let factory = [%bs.raw
  {| function factory() {
  return function createClass(spec) {
    spec.render.displayName = spec.displayName
    return spec.render
  }
}|}
];


let createClass = [@bs] factory();
