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





