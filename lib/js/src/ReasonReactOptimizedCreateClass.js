'use strict';


var createClass = ( function createClass(spec) {
    spec.render.displayName = spec.displayName
    return spec.render
});

exports.createClass = createClass;
/* createClass Not a pure module */
