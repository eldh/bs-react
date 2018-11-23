# BsReact

```sh
npm install --save bs-react
```

## What?
BsReact is a fork of [ReasonReact](https://reasonml.github.io/reason-react) adapted to work with [Hooks](https://reactjs.org/docs/hooks-intro.html) and [Context](https://reactjs.org/docs/context.html).

Reason React uses the good old `createClass` under the hood. BsReact has a simplified api that converts components defined in Reason to plain function components, allowing hooks to be used.

## Why?

We all want to use all the shiny new things from React in Reason. With Hooks, there's no need for anything other than function components, so it makes sense to have a more minimal set of React bindings for Reason.

## API

The api is similar to ReasonReact, but there's only one type of component, and you can only define a `render` function.

Example:

```reasonml
module Counter = {
  let component = ReasonReact.component("Counter");

  let make = (~initial=0, _children) => {
    ...component,
    render: _self => {
      let (count, setCount) = ReactHooks.useState(initial);
      <div>
        {ReasonReact.string(string_of_int(count))}
        <button onClick={_ => setCount(. count + 1)}>
          {ReasonReact.string("Click me")}
        </button>
      </div>;
    },
  };
};
```

For more details, check out the source. Better docs are coming.

### Status

Early experimentation. Only for the brave.

## Future

The plan is to support all functionality from React 16/17.

- Suspense
- React.lazy
- React.pure
- Error boundaries
- React Native
- etc

I hope some of these things will make it into ReasonReact in some form.

Later on, making this work with ReactMini or some other pure Reason implementation of React would be cool.

Let's chat on [Discord](https://discord.gg/reasonml)!

## Contributions

More than welcome!

## Thanks

Hooks and Context types are copied from [Jared Forsyth](https://github.com/jaredly).
