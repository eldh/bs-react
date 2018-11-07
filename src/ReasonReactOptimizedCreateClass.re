let createClass = [%bs.raw
  {| function createClass(spec) {
    spec.render.displayName = spec.displayName
    return spec.render
}|}
];