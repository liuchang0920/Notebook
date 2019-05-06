



## ES Module Syntax

export keyword

eg:

```js
// uppercase.js
export default  str => str.toUpperCase();

```

since uppercase.js uses a default export, when we import it, we can assign it a name we prefer??

```js
import toUpperCase from './uppercase.js';

toUpperCase('test') // TEST

```

We just saw the default export.

In a file, however, we can export more than one thing:

```js

const a = 1;
const b = 2;
const c = 3;

export {a, b, c}

```

then


```js

// when importing the value:
import { a } from 'module';
import {a, b} from 'module';

// or use alias
import { a, b as two } from 'module';


```

as for React, you can also import default export, and other non-defualt export,


```js
import React, { Component } from 'react';

```

# Section 2: React concepts

notable example of SPA:

gmail, google maps, facebook, twitter, google drive

Progressive web apps: support offline experience for your services


如果需要search engine 能够搜到,还是还需要server side rendering 

history: react-router internally uses History API

## Declarative

声明式的

declerative (html??) <--> imperative(DOM manipulation: jquery, DOM events)


imperative: you tell the browser waht to do, instead of telling it what you need.

We use React, just tell we want a component to be rendered in a specific way, and we never have to interact with the DOM to reference it later.

## Immutability


 
 ....


 # In depth React

 ```jsx
<select>

    <option value="x" selected>
    ddd
    </option>
</select>

// --> 

<select>

    <option defaultValue="x" selected>
        ddd
    </option>
</select>

 ```

## spread attributes

```jsx
<BlogPost title = {data.title} date = {data.date} />

<BlogPost {...data} />
```

## Loop in JSX

```jsx
const element = []

onst items = []

for(const [index, value] o elements.entries()) {
    items.push(<Element key={index} />)
}

// and then embed the items array by wrapping it in curly braces

return (
    <div>
        {items}
    </div>
)

// using map instead of for loop
return (
    <ul> 
        {elements.map((value, index) => {
            return <li key={index}>{value}</li>
        })}
    </ul>
)

```

## Components

everything is a component

## State

setting the default state of a comonent

```jsx
class BlogPostExcerpt extends Component {

    constructor(props) {
        super(props);
        this.state = { clicked: false }
    }

    render() {
        <div>
            <h1>Title</h1>
            <p>Description</p>
            <p> Clicked: {this.state.clicked}</p>
        </div>
    }
}

```

### whyat should always use setState()
use setState() to mutate the state, since then it will start the series of events that will lead to the component being re-rendered, along with DOM udpate.

### unidirectional data flow

only affect it's children comonents

### moving the state up in the tree

If two compoents need to share state,  the state need to be moved up to a common ancestor.

The state can be mutated by a child component by passing a mutating function down as a prop:

```jsx

class Converter extends React.Component {
    constructor(props) {
        super(props);
        this.state = { currency: '$'}
    }

    handleChangeCurrency = event => {
        this.setState({
            currency: this.state.currenty == '$' ?'$':'ss'
        });

        render() {
            return (
                <Display currency={this.state.currenty} />
                <CurrencySwitcher 
                currency={this.state.currency}
                handleChangeCurrency={this.handleChangeCurrency}
                />
            )
        }
    }


}

const CurrencySwitcher = props => {
    return (
        <button onClick={props.handleChangeCurrency}>
            Current currenty is {props.currency}, change it
        </button> 
    )
}

const Display = props => {
    return <p> Current Currency is {props.currency} </p>
}

```
data is passed down by the props 

### Props

in a function component, props is all it gets passed, and they are available by adding props as the function argument:

```jsx

const BlogPostExerpt = props => {
    return (
        <div>
            <h1>{props.title}</h1>
            <p>{props.description}</p>
        </div>
    )
}
```

In class component, props are passed by default. Thereis no need to add anything special. they are accessable by: this.props

```jsx

import React, {Component} from 'react';

class BlogPostExerpt extends Component {
    render() {
        <div>
            <h1>{this.props.title}</h1>
        </div>
    }
}

```
A component either holds data or recerives data through its props


It might gets complicated:

* need access the state of a component fro ma child that's several levels down
* if you need to acces the state of a component fro ma completed unrelated component

### Default values for props


If any value is not required we need to specify a default value ofr it if it's missing

```jsx
BlogPostExcerpt.propTypes = {
    title: PropTypes.string,
    description: PropTypes.string
}

BlogPostExcerpt.defaultProps = {
    title: '',
    description: ''
}

```

tools like ESLint have the ability to enforce defining the defualtProps for a Component with some propTypes not explicitly required.

### how props are passed

when initializing a component, pass the props in a way similar to HTML attributes:

```jsx
const desc = 'abc'
<BlogPostExcerpt title="a title" desciption={desc}>
```


### Children

A special prop is children, that contains the value of anything that is passed in the body of the component. 

```jsx
<BlogPostExcerpt ... >
Something
 </BloPostExcerpt>
```

this.props.children, will access the things inside the div

### Presentational VS container components

基本上分为两类

1.  presendatational components are mostly concerned with generating some markup to be outputted.

they dont manage any kind o state, except fo the state related to the presentation

2. Container components are mostly concerned with the 'backend' operations

They might handle the state of various sub-components. They might wrap severa lpresentational components, and interface with Redux.


==>

    Presentational components are concerned with the look, container components are concerned with making things works.


```jsx

// presentation component
const Users = props => (
    <ul>
        {props.users.map(user => {
            <li>{user}</li>
        })}
    </ul>
)

// user container
class UsersContainer extends React.Component {
    constructor() {
        this.state = {
            users:[]
        }
    }

    componentDidMount() {
        axios.get('/users').then(users => 
            this.setState({
                users: users
            })
        )
    }

    render() {
        return <Users={this.state.users} />
    }
}

```

### State vs Props

* Props are variables passed to it by its parent component
* State on the other hand is still variables, but directly intialized and managed by the component, itself



The parent could include a child component by calling `<ChildComponent />`

The parent can pass a prop by using this syntax `<ChildComponent color=green />`

and inside the CildComponent, we can access the props

```jsx

class ChildComponent extends React.Component {

    constructor(props) {
        super(props);
        console.log(props.color);
        this.state.colorName = props.color
    }    
}

```


Props can be used to set the internal state baed on a prop value in the constructor.


=> props should never be changed in a child component, so if there's something going on that alters some variables, that variable should belong  to the component state.

Props are also used to allow chlid components to access methods defined in the parent component. This is a go dway to centralize managing the state in the parent component, and avoid children having the need to have their own state.

Most of your components will just display some kind of information based on the props they received, and stay stateless.



### propTypes



```jsx
使用propTypes 强制类型

import PropTypes from 'prop-types'
import React from 'react'
class BlogPostExcerpt extends Component {
  render() {
    return (
      <div>
        <h1>{this.props.title}</h1>
        <p>{this.props.description}</p>
      </div>
    )
  }
}
BlogPostExcerpt.propTypes = {
  title: PropTypes.string,
  description: PropTypes.string
}
export default BlogPostExcerpt


```

Types we can use

```
PropTypes.array
PropTypes.bool
PropTypes.func
PropTypes.number
PropTypes.object
PropTypes.string
PropTypes.symbol

```
```
PropTypes.oneOfType([..]) different types
PropTypes.oneOf([..]) certain value

PropTypes.instanceOf([..])
 ..

等等吧..

```

#### Requiring properties

```jsx

PropTypes.string.isRequired

```

append .isRequired to any PropTypes option


### React Fragment

```jsx
import React, { Component } from 'react'
class BlogPostExcerpt extends Component {
  render() {
    return (
      <React.Fragment>
        <h1>{this.props.title}</h1>
        <p>{this.props.description}</p>
      </React.Fragment>
    )
  }
}
```

false div element to wrap things up



### Events

Prepare to say goodby to `addEventListener`

```js

const CurrentSwticher = props => {
    return (
        <button onClick={props.handleChangeCurrency}
        >Current currency is {props.currency}. change it
    )
}
```

in React, you use camelCase for everything, so onclick becomes onClick, onsubmit => onSubmit


### Event handlers

```jsx

class Converter extends React.Component {
    handleChangeCurrency = event => {
        this.setState({
            currency: this....
        })
    }
}

```


### Bind thi sin methods ??

js typical

what this means is that `this` in not defined unless you define methods as arrow functions

如果使用一般的函数,需要绑定this

```jsx
class Converter extends React.Component {
    constructor(props) {
        super(props);
        this.handleClick = this.handleClick.bind(this);
    }

    // if normal function
    handleClick(e) {

    }
}
```

### The events reference

```
Clipboard
onCopy
onCut
onPaste
Composition
onCompositionEnd
onCompositionStart
onCompositionUpdate
Keyboard
onKeyDown
onKeyPress
onKeyUp
Focus
onFocus
onBlur
Form
onChange
onInput
onSubmit
Mouse
onClick
onContextMenu
onDoubleClick
onDrag
onDragEnd
onDragEnter
onDragExit
onDragLeave
onDragOver
onDragStart
onDrop
onMouseDown
onMouseEnter
onMouseLeave
onMouseMove
onMouseOut
onMouseOver
onMouseUp
Selection
onSelect
Touch
onTouchCancel
onTouchEnd
onTouchMove
onTouchStart
UI
onScroll
Mouse Wheel
onWheel
Media
onAbort
onCanPlay
onCanPlayThrough
onDurationChange
onEmptied
onEncrypted
onEnded
onError
onLoadedData
onLoadedMetadata
onLoadStart
onPause
onPlay
onPlaying
onProgress
onRateChange
onSeeked
onSeeking
onStalled
onSuspend
onTimeUpdate
onVolumeChange
onWaiting
Image
onLoad
onError
Animation
onAnimationStart
onAnimationEnd
onAnimationIteration
Transition
onTransitionEnd

```


### Lifecycle Events

Hooks allow function components to access them too, i na diferent way >???


During the lifetime of a component, there's a seriese of events that gets called, and to each evetn you can hook and provide custom functionality.


First, 3 phases in a React component lifecycle.

* Mounting
* Updating
* unmounting

#### mounting

constructor, getDrivedStateFromProps, render, componentDidMount


componentDidMount(): usually use this to perform API calls, or process operations on the DOM


#### updating

When updating you have 5 lifecycle methods before the component is mounted in the DOM: the getDerivedStateFromProps, shouldComponentUpdate, render, getSnapshotBeforeUpdate and componentDidUpdate.



#### unmounting

only have one method: componentWillUnmount

use this function to do any sort of cleanup you need to perform.



### Forms in React

common use of a form:
* search
* contact forms
* shopping carts
* login, registration
* 

### Reference a DOM element

略过..

### Server side rendering

SSR()

why:

* faster page load time
* essential for SEO
* easier to gather metadata

drawback
* growth of complexity
* resource-intensive


其他部分略过

### Context API

It's a neat way to pass state across the app without having to use props.

in many cases, it enables to avoid using Redux, simplifying aps


```jsx
const {Provider, Consumer } from = React.createContext();

class Container extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            someting: 'hey'
        }
    }

    render() {
        return (
            <Provider value={{ state: this.state}}>
                {this.props.children}
            </Provider>
        )
    }
}

class HelloWorld extends React.Compontnt {
    render() {
        return (
            <Container>
                <Button />
            </Container>
        )
    }
}


// 然后在 button里调用

class Button extends React.Component {
    render() {
        <Consumer>
            {
                context =>
                ( 
                <button>
                    {context.state.something}
                </button>
                )
            }
        </Consumer>
    }
}


```

类似的

```jsx
<Provider value={{
  state: this.state,
  updateSomething: () => this.setState({something: 'ho!'})
  {this.props.children}
</Provider>
/* ... */
<Consumer>
  {(context) => (
    <button onClick={context.updateSomething}>{context.state.something}</button>
  )}
</Consumer>
```


### higher order components

HOC()

to me it sounds like decorator...


```jsx

const withColor = Element => props => <Element {...props} color="red" />

const Button = () => {
    return <button>test</button>
}

const ColoredButton = withColor(Button)



// -->

function App() {
    return (
        <ColoredButton />
    )
}
```



### Render props


```js
class Parent extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      /*...*/
    }
  }
  render() {
    return <div>{this.props.children}</div>
  }
}

const Children1 = () => {}
const Children2 = () => {}
const App = () => (
  <Parent>
    <Children1 />
    <Children2 />
  </Parent>
) 

```

To be able to share the state, need to use a render prop component, and instead of passing componentss as children of the parent component, you pass a function which you then execute in {this.props.children()}

like: ` render() {
    return <div>{this.props.children(this.state.name)}</div>
  }`



没太明白,等看例子吧


### Hooks

Hooks allow function components to have state and to repond to lifecycle events too.

seems like a new feature, that has done same thing like normal react class..

### Code Splitting

code split will improve:

* the performance of your app
* the impact on memory, and so battery usage
* downloaded file size

use:
React.lazy and Suspend form the perfect way to lazily load a dependency and only load it when needed

```jsx
import React from 'react';

const TodoList = React.lazy(() => import('./TodoList'));

export default () => {
    return (
        <TodoList />
    )
}

```
webpack will creat a separate bundle for it, and will take care of loading it when necessary.


Suspense is a Componnet that you can use to wrap any lazil loaded component;

``` jsx
<React.Suspense>
        <TodoList />
      </React.Suspense>
```

no idea..

```jsx
<React.Suspense fallback={<p>Please wait</p>}>
        <TodoList />
      </React.Suspense>
```

```jsx

// lazy load with react router

import React from 'react'
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom'
const TodoList = React.lazy(() => import('./routes/TodoList'))
const NewTodo = React.lazy(() => import('./routes/NewTodo'))
const App = () => (
  <Router>
    <React.Suspense fallback={<p>Please wait</p>}>
      <Switch>
        <Route exact path="/" component={TodoList} />
        <Route path="/new" component={NewTodo} />
      </Switch>
    </React.Suspense>
  </Router>
)

```

## Example

building a counter..


example 用的是hooks 有点问题啊

## Section6: tooling

### Babel

Babel is a compiler

it take code written in one standard, and trnspile it to the code written into another standard.

略过???


### Webpack

prodecessor of webpack, and still widly used tools: 
* grunt
* broccoli
* Gulp

略过..


#### watching changes

```json

"scripts": {
    "watch":"webpack --watch" 
}

```

npm run watch

and all...


## Section 7, Testing

### Jest

in package.json file:

```json
{
    "scripts": {
        "test": "jest"
    }
}

```

#### Matchers

```
toBe compares strict equality, using ===
toEqual compares the values of two variables. If it’s an object or array, it checks the equality of all the properties or elements
toBeNull is true when passing a null value
toBeDefined is true when passing a defined value (opposite to the above)
toBeUndefined is true when passing an undefined value
toBeCloseTo is used to compare floating values, avoiding rounding errors
toBeTruthy true if the value is considered true (like an if does)
toBeFalsy true if the value is considered false (like an if does)
toBeGreaterThan true if the result of expect() is higher than the argument
toBeGreaterThanOrEqual true if the result of expect() is equal to the argument, or higher than the argument
toBeLessThan true if the result of expect() is lower than the argument
toBeLessThanOrEqual true if the result of expect() is equal to the argument, or lower than the argument
toMatch is used to compare strings with regular expression pattern matching
toContain is used in arrays, true if the expected array contains the argument in its elements set
toHaveLength(number): checks the length of an array
toHaveProperty(key, value): checks if an object has a property, and optionally checks its value
toThrow checks if a function you pass throws an exception (in general) or a specific exception
toBeInstanceOf(): checks if an object is an instance of a class

```

for promiese:

```js
expect(Promise.resolve('lemon')).resolves.toBe('lemon');

expect(Promise.reject(new Error('octopus'))).rejects.toThrow('octopus')

```
#### Setup

```js
beforeAll(() => {
    // do something
})
```
before each test runs

```js
beforeEach(() => {
    // do something
})

```

teardown

```js

afterEach(()=> {
    // dosomehting
});


afterAll(() => {
    // do something
})
```

#### Groups tests using describe()

```js
describe('first set', () => {
    beforeEach(() => {

    });

    afterAll(() => {
        //
    })

    test(..)
    test(..)
});


```


#### Testing asynchronous code

callbacks, promises, and async/await

```js
function uppercase(str, callback) {
    callback(str.toUppserCase());
}

module.exports = uppercase;

// uppercase.test.js

const uppercase = require('./src/uppercase')

test(`uppercase 'test' to equal 'TEST'`, (done) => {
    uppercase('test', (str) => {
        expect(str).toBe('TEST');
        done();
    }
    )
})
```
#### Promises


```js

const uppercase = str => {
    return new Promise((resolve, reject) => {
        if(!str) {
            reject('empty string');
            return
        }
        resolve(str.toUpperCase())
    })
}
module.exports = uppercase


// uppercase.test.js

const uppercase = require('./uppercase');
test(`uppercase 'test' to equal 'TEST'`, () => {
    return uppercase('test').then(str => {
        expect(str).toBe('TEST');
    })
})

const uppercase = require('./uppercase')
test(`uppercase 'test' to equal 'TEST'`, () => {
  return uppercase('').catch(e => {
    expect(e).toMatch('Empty string')
  })
})


```

一样的..


#### Async/await

```js
const uppercase = require('./uppercase');
test(`uppercase 'test' to equal 'TEST'`, async () => {
    const str = await uppercase('test');
    expect(str).toBe("TEST");
})


```


### Mocking

略过..

## Section 8 React ecosystem

### React router

1. the browser should change the URL when you navigate to a different screen
2. Deep linking should work: if you point the browser to a URL, the application should reconstruct the same view that was presented whe nthe URL was generated
3. The browser back button should work like expected.


.. 略过 头疼



## Redux

这里好好学习一下

### immutable state tree


In Redux, the whole state of the application is represented by one JS object, called State, or State tree.

We call it Immutable State Tree, because it is read only, and can't be changed 

It can only be changed by dispathing an Action.

### Actions

An action is a JS object, that describes a change in a minimal way

```js
{
    type: 'selected_user',
    userId: 344

}
```

the only requirement of an action object is having a `type` property, whose value is usually a string.

#### action types should be constant
to separate actions in their own files:

#### action creators

```js
function addItem(t) {
    return {
        type: ADD_ITEM,
        title: 'x'
    }
}
```

usually run action creators in combination with triggering the dispacher

```js

dispatch(addItem('Milk'))
```

#### Reducers

when an action is fired, something must happen, the state of the application must change,

This is the job of reducers.

A reducer is a pure function that calculates the next State tree based on the previous state tree, the action is dispatched.

(currentState, action) => newState

A pure function take an input and returns an output without changing the input of anything else. Thus, a reducer returns a completely new state tree object that substitutes the previous one.

#### What a reducer should not do?

should:

* never mutate its arguments
* never mutate the state, but instead create a ne wone with Object.assign({}, ...)
* never generate side-effect (no API call changin anything)
* never call non-pure functions (eg: Date.now(), Math.random())

#### Multiple reducers

Since the state of a complex app could be really wide, there is not a single reducer, but many reducers for any kind of action.

#### A simulation of a reducer

```js

{
    list: [
        {title:'a'},
        {title:'b'}
    ]
}
```

```js
// a list of actions

{type: 'ADD_ITEM', title: 'third item'}
{type: 'REMOVE_ITEM', index: 1}
{type: 'CHANGE_LIST_TITLE', title: 'road trip list'}
```

a reducer for every part of the state

```js
const title = (state = '', action) => {
    if(action.type === 'CHANGE_LIST_TITLE') {
        return action.title
    } else {
        return state
    }
}

const list = (state=[], action) => {
    switch(action.type) {
        case 'ADD_ITEM':
            return state.concat([{title: action.title}]);
        case 'REMOVE_ITEM':
            return state.map((item, index) => {
                action.index === index?{title: item.title}:item;
            })
        default:
            return state;
    }
}

```
A reducer for the whole state

```js
const listManager = (state={}, action) => {
    return {
        title: title(state.title, action),
        list: list(state.list, action)
    }
}
```

#### The Store


Store is an object that:

* holds the state of the app
* exposes the state via getState()
* allows us to updat the state via dispatch()
* allows us to (un)regiter a state change listener subscribe()


A store is unique in the app.

```js
import { createStore } from 'redux';
import listManger from './reducers';
let store = createStore(listManager)

```


#### Data Flow

is always unidirectional

The store updates the state, and alerts all the listeners


