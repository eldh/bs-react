export function createMake(component, displayName) {
  component.displayName = displayName

  function internalComponent(props) {
    // console.log('internal', props.reasonProps)
    console.log('component.length', component.length, props.reasonProps.length)

    return component(/*props.key, props.ref, */ ...props.reasonProps)
  }

  switch (component.length) {
    case 1:
      return function make(a) {
        return [internalComponent, [a]]
      }
      break
    case 2:
      return function make(a, b) {
        return [internalComponent, [a, b]]
      }
      break
    case 3:
      return function make(a, b, c) {
        return [internalComponent, [a, b, c]]
      }
      break
    case 4:
      return function make(a, b, c, d) {
        return [internalComponent, [a, b, c, d]]
      }
      break
    case 5:
      return function make(a, b, c, d, e) {
        return [internalComponent, [a, b, c, d, e]]
      }
      break
    case 6:
      return function make(a, b, c, d, e, f) {
        return [internalComponent, [a, b, c, d, e, f]]
      }
      break
    case 7:
      return function make(a, b, c, d, e, f, g) {
        return [internalComponent, [a, b, c, d, e, f, g]]
      }
      break
    case 8:
      return function make(a, b, c, d, e, f, g, h) {
        return [internalComponent, [a, b, c, d, e, f, g, h]]
      }
      break
    default:
      //  TODO fix
      break
  }
}
export function createClass([component, args]) {
  let reasonProps = args.slice(0, args.length - 1)
  let children = args[args.length - 1]
  return [reasonProps, component, children]
}
