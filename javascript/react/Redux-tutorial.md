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



