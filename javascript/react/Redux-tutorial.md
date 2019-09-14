https://cn.redux.js.org/docs/basics/DataFlow.html



## Redux


Redux 应用中数据的声明周期遵循一下四个步骤

1. 调用 store.dispatch(action)
```
// Action 就是描述发生了什么的普通对象那个
```

可以把action理解成新闻的摘要.


2. Redux store 调用传入的reducer函数

store会把两个参数传入reducer, 当前的state跟action

举例:

```js
let previousState = {
  visibleTodoFilter: 'SHOW_ALL',
  todos: [
    {
      text: 'read the docs',
      complete: false
    }
  ]
  
let action = {
  type: 'ADD_TODO',
  text: 'understand the flow'
}  
```

// reducer 处理后的应用状态

let nextState = todoApp(previousState, actioin);

3. 根reducer应该把多个子reducer输出合并成一个单一的state树

根reducer应该由自己决定. Redux提供原生的combineReducers() 辅助函数,
来把根reducer拆分成多个函数,用于分别处理state树的一个分支

没懂 mother fucker


## Reducer

## Store

Store 有以下的职责:

* 维持应用的state
* 提供getState() 方法获取state()
* 提供dispatch(action) 方法更新state
* 通过subscribe(listener) 注册监听
* 通过subscribe(listener) 返回的函数注销监听器

Redux只有单一的一个store
当需要拆分逻辑的时候,应该使用reducer组合,而不是创建多个store


```js
import { createStore } from 'redux';
import todoApp from './reducers';

let store = createStore(todoApp);
```
createStore()的第二个参数是可选的,用于设值state的初始状态.


### 发起actions

```js
import { addTodo, toggleTodo, setVisibilityFilter, VisivilityFilters } from './actions';

console.log(store.getState());


// 每次state更新时,都会打印日志
const unsubscribe = store.subscribe(() => console.log(store.getState()))

store.dispatch(addTodo('Learn about actions'))
store.dispatch(addTodo('Learn about reducers'))
store.dispatch(addTodo('Learn about store'))

store.dispatch(toggleTodo(0))
store.dispatch(toggleTodo(1))

store.dispatch(setVisibilityFilter(VilibilityFilter.SHOW_COMPLETE));

unsubscribe();

// index.js
import { createStore } from 'redux';
import todoApp from './reducers';

let store = createStore(todoApp);

```

## 数据流

严格的单项数据流是redux架构的设计核心

Redux应用中数据的声明周期应该遵循下面4个步骤

1. 调用store.dispatch(action)

Action 就是描述发生了什么的普通对象

2. Redux store 滴啊用传入的reduce 函数
```js
// 当前应用的 state（todos 列表和选中的过滤器）
let previousState = {
  visibleTodoFilter: 'SHOW_ALL',
  todos: [
    {
      text: 'Read the docs.',
      complete: false
    }
  ]
}

// 将要执行的 action（添加一个 todo）
let action = {
  type: 'ADD_TODO',
  text: 'Understand the flow.'
}

// reducer 返回处理后的应用状态
let nextState = todoApp(previousState, action)
```
3. 根reducer应该把多个子reducer输出合并成一个单一的state树

```js
function todos(state = [], action) {
  // 省略处理逻辑...
  return nextState
}

function visibleTodoFilter(state = 'SHOW_ALL', action) {
  // 省略处理逻辑...
  return nextState
}

// 使用combineReducers,合并成一个单一的state树
let todoApp = combineReducers({
  todos,
  visibleTodoFilter
})

```

combineReducer会返回todoApp会负责调用两个reducer:

```js

let nextTodos= todos(state.todos, action);
let nextVisibleTodoFilter = vibsibleTodoFilter(state.visibleTodoFilter, action);


// => 
return {
todos: nextTodos,
visibleTodoFilter: nextVisibleTodoFilter

```


4. Redux store保存了根reducer返回的完整的state树



现在可以用新的state来更新UI,如果你使用了react redux 绑定库, 那么应该调用component.setState(newState)来更新


## 搭配React


## redux的store 




............


阮一峰

1. 中间件的用法

中间件就是一个函数, 对store.dispatch进行了重新定义,发送Action前后添加了打印功能. 这就是中间件的雏形

需要注意两点

1. createStore() 方法可以接收应用的初始状态作为参数

``` jsx
const store = createStore(
  reducer,
  initial_state,
  applyMiddleware(logger)
)

```

2. 中间件的次序有讲究

``` jsx
const store = createStore(
  reducer,
  applyMidleware(thunk, promise, logger)
)

```

3. applyMiddlwares()

将所有的中间件,组成一个数组,依次执行.


4. 异步操作的基本思路


同步操作: 只发出一种action即可,异步操作的差别是发出三种action

* 操作发起时的action
* 操作成功时的action
* 操作失败时的action


5. redux-thunk 中间件

改造 store.dispatch, 使得他可以接收函数作为参数 ?

6. redux-promise 中间件

既然action creator可以返回函数,那么当然也可以返回其他值

另一种异步操作的解决方案,是action creator返回一个promise 对象

``` js

import { createStore, applyMiddleware } from 'redux';
import promiseMiddleware from 'redux-promise';
import reducer from './reducers';

const store = creatStore(
  reducer,
  applyMiddleware(promiseMiddleware)
)


使用时:

const fetchpost = (dispatch, postTitle) => new Promise(function(resolve, reject) {
  dispatch(requestPost(postTitle));
  return fetch(`some/api/${postTitle}.json`)
          .then(response => {
            type: 'FETCH_POSTS',
            payload: response.json()
          });
});

```
..........


## react-redux 教程

### 1. UI组件

UI 组件特点

* 只负责呈现ＵＩ，没有任何逻辑
* 没有状态，　不使用this.state
* 所有数据都由 参数提供　this.props
* 不使用任何 redux 的api

UI组件的例子

```js
const Title = value => <h1>{value}</h1> 
```

它就跟纯函数一样

### 2. 容器组件

容器组件的特征

* 负责管理数据和业务逻辑,不负责UI的呈现
* 带有内部的状态
* 使用Redux的API

react-redux规定,所有的UI组件都由用户提供,容器组件则是由react-redux自动生成,也就是说,用户负责视觉层,状态管理全部交给它

### 3. connect() 

react-redux 提供的connect 方法,用于从UI组件生成容器组件

connect的意思是,将两种组件链接起来

```js

import { connect } from 'react-redux'
const VisibleTodoList = connect()(TodoList);

```

因为没有定义业务逻辑,这个容器组件毫无意义.只是一个UI组价的单纯包装,为了定义业务逻辑,需要给出下面两个方面的信息.





store有以下职责：
* getState()
* dispatch(action)
* subscribe(listener) 注册监听器
* subscribe(listener) 注销监听器


### connect() 函数

使用connect之前，需要 mapStateToProps() 函数指定如何把当前的Rdxus store state映射到组件的props中。 eg: VisibleTodoList, 需要计算传到TodoList的todos， 

```js
const mapStateToProps = state => {
  return {
    todos: getVisibleTodos(state.todos, state.visiblityFilter)
  }

}

// return the props that is needed into this component

```

除了读取state，容器组件还可以分发action

类似的方式，可以定义

mapDispatchToProps()方法接收dispatch()

```
const mapDispatchToProps = dispatch => {
  return {
    onTodoClick: id => {
      dispatch(toggleTodo(id))
    }
  }
}

```

// this onTodoClick will be bundled to some functions in the component, 

使用connect() 创建VisibleTodoList
传入两个函数

```
import { connect } from 'react-redux';

const VisibleTooList = connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);

export default VisibleTodoList;
```

如果你担心mapStateToProps 创建对象太过于频繁，可以学习如何使用 reselect来计算衍生数据

```

import { connect } from 'react-redux;
import { toggleTodo } from '../actions';
import TodoList from '../components/TodoList';

const getVisibleTodos = (todos, filter) => {
  switch(filter) {
    case 'SHOW_ALL':
      return todos;
    case 'SHOW_COMPLETED':
      return todos.filter(t => t.completed); 
  }
}

const mapStateToProps = state => {
  return {
    todos: getVisibleTodos(state.todos, state.visibilityFilter)
  }
}

const mapDispatchToProps = dispatch => {
  return {
    onTodoClick: id => {
      dispatch(toggleTodo(id));
    }
  }
}


const VisileTodoList = connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);

export default VisibleTodoList;



```

### 传入 Store

所有容器组件都可以访问redux store, 所以可以手动监听它。但是如果把它用props的形式传入的话，太麻烦了， 必须要用store把展示组件包裹一层，仅仅是因为恰好在组件树中渲染了一个组件。

建议使用Provider 组件(感觉跟context有点像)
来魔法般的让所有的容器组件都能够访问store.


```
import React from 'react';
import { render } from 'react-dom';
import { Provider } from 'react-redux';
import { createStore } from 'redux';
import todoApp from './reducers';
import App from './components/App';

let store = createStore(todoApp);

render(
  <Provider store={store}>
    <App/>
  </Provider>
, document.getElementById('root'));

```


## 异步action

异步调用的时候，最少有三种action

1. 一种通知reducer请求开始的action
2. 一种通知reducer请求成功的action
3. 一种通知reducer请求失败的action

对于多种action
使用多个action type 能够降低犯错误的几率

```
{ type: 'FETCH_POSTS_REQUEST' }
{ type: 'FETCH_POSTS_FAILURE', error: 'Oops' }
{ type: 'FETCH_POSTS_SUCCESS', response: { ... } }

```

但是如果你使用像redux-actions这类型的辅助库来生成action创建函数和reducer的话，这就完全不是问题了


例子： 请求reddit 的action：  request_posts, select_subreddit, invalidate_subreddit 分开很重要。

虽然他们的发生有先后顺序，但是随着应用变得复杂，有些用户操作(预先加载最流行的subreddit,或者一段时间后自动刷新过期数据，)后需要马上请求数据。

路由变化也要根据请求数据，所以一开始如果再请求数据和特定的UI时间耦合到一起，是不明智的

最后，当我们接收到请求的响应的时候，
dispatch receive_post action

```js

export const receve_post = '...';

export function receivePosts(subresddit, json) {
  return {
    type: receive_post,
    subreddit,
    post: json.data.children.map(child => child.data),
    receivedAt: Date.now()
  }
}

```



### 设计State 结构


这部分通常会让初学者感到迷惑。因为选择哪些信息才能更清晰的描述异步应用的state并不直观，还有怎么用一个树来把这些信息组织起来。

eg: 最通用的案例来打头：

web应用疆场需要展示一些内容的列表。比如，帖子的列表。朋友的列表。

首先要明确显示哪些列表，然后分开存储在state中。这样才能对他们分别做缓存并且在需要的时候再次请求更新数据

* 分开存储subreddit信息，是为了缓存所有的subreddit。当用户来回切换subreddit的时候，可以立即更新，同时在不需要的时候可以不请求数据。
* 每个帖子的列表都需要使用isFetching来先显示进度条。didInvalidate来标记数据是否过期。lastUpdated来存放数据最后的更新时间。还有items存放数据信息本身。

* 在实际应用当中，还需要fetchedPageCount, nextPageUrl这样的分页相关的state.



#### 嵌套内容须知

在本教程中，我们不会对内容进行范式化，但是在一个复杂的应用中，你可能需要使用


#### 处理action

在讲解dispatch action与网络请求结合使用细节前，我们为上面的定义的action开发一些reducer


* 使用ES6 计算属性语法 Object.assign()来简洁的高校更新state[action.subreddit]

```
return Object.assign({}, state, {
  [action.subreddit]: posts(state[action.subreddit], action)
})

```

reducer只是一个函数，所以尽情使用函数组合和高阶函数这些特性




reference: https://cn.redux.js.org/docs/introduction/ThreePrinciples.html


https://medium.com/swinginc/react-redux-typescript-into-the-better-frontend-tutorial-d32f46e97995

https://github.com/piotrwitek/react-redux-typescript-guide

https://www.sitepoint.com/crud-app-react-redux-feathersjs/
