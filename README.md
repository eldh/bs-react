# SimpleReasonReact

```sh
npm install --save simple-reason-react
```

SimpleReasonReact is a fork of [ReasonReact](https://reasonml.github.io/reason-react) adapted to work with [Hooks](https://reactjs.org/docs/hooks-intro.html), with Hooks types from [Jared Forsyth](https://github.com/jaredly/hooks-experimental).

Reason React uses the good old `createClass` under the hood. SimpleReasonReact has a simplified api that converts components defined in Reason to plain function components, allowing hooks to be used.

## API

The api is similar to ReasonReact, but there's only one type of component, and you can only define a `render` function.

Example:

```reasonml
module Counter = {
  let component = ReasonReact.component("Counter");

  let make = (~initial=0, _children) => {
    ...component,
    render: _self => {
      let (count, setCount) = Hooks.useState(initial);
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

### Status

Very early experimentation. Only for the brave, not for production. Some things are broken.

Let's chat on [Discord](https://discord.gg/reasonml)!

