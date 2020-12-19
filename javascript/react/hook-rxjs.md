
## Rxjs 

* https://yoyoyohamapi.gitbooks.io/-rxjs-react-sql/content/
* https://blog.soshace.com/react-hooks-rxjs-or-how-react-is-meant-to-be/


## hooks:

* https://wattenberger.com/blog/react-hooks
* https://overreacted.io/zh-hans/a-complete-guide-to-useeffect/
* https://www.robinwieruch.de/react-hooks-fetch-data


### hooks reducer总结。。

In conclusion, the Reducer Hook makes sure that this portion of the state management is encapsulated with its own logic. By providing action types and optional payloads, you will always end up with a predicatbale state change. In addition, you will never run into invalid states.


For instance, previously it would have been possible to accidentally set the isLoading and isError states to true. What should be displyaed in the UI for this case?? Now, eact state transition defined by the reducer function leads to  a valid state object.



相比于直接在effect里面读取状态，它dispatch了一个action来描述发生了什么。这使得我们的effect和step状态解耦。我们的effect不再关心怎么更新状态，它只负责告诉我们发生了什么。更新的逻辑全都交由reducer去统一处理:



#### 另外如何养成写effect 的好习惯？

等到业务逻辑变得复杂以后，很有可能会丢掉依赖，所以需要养成良好的习惯

有一个简单的解决方法： 如果某些函数仅仅在effect中，调用，那么可以把他们定义道effect当中去

如果我们后面修改getFetchUrl 去使用query的状态，我们可能会意识到我们正在effect里面编辑它，因此，我们需要把query添加到effect的依赖里面。


```
function SearchResutls() {
  const [query, setQuery] = useState('react');
  
  
  useEffect(() => {
      
    function getFetchUrl() {
      return 'xxxx' + query;
    }
    
    async function fetchData() {
      const result = await axios(getFetchUrl());
      setData(result.data);
    }
    
    fetchData();
    
  }, [query]); // deps are OK

}
```

添加这个依赖是对的，我们不仅仅是在“取悦react”， 在query变更之后，重新请求新的数据是合理的。。 useEffect的设计意图就是要强迫你关注数据流的变化，然后决定我们effects该如何和她同步。 - 而不是忽略它，知道我们的用户遇到了bug..

#### 但是我们不能够把这个函数放到effect里面去。。

有的时候，你不想把函数放到effect里面去 。比如，组件有几个effect使用了相同的函数，你不想在每个effect里复制一遍这个逻辑，也许这个函数是一个props

应该再次强调： effects不应该对他的依赖撒谎。通常我们还有更好的解决办法。一个常见的误解是，'函数从来不会改变'。实际上，在组件内定义的函数，每次渲染都在改变。

...

有一个极端的例子： 更新太频繁。。

```
function SearchResults() {
  // 🔴 Re-triggers all effects on every render
  function getFetchUrl(query) {
    return 'https://hn.algolia.com/api/v1/search?query=' + query;
  }

  useEffect(() => {
    const url = getFetchUrl('react');
    // ... Fetch data and do something ...
  }, [getFetchUrl]); // 🚧 Deps are correct but they change too often

  useEffect(() => {
    const url = getFetchUrl('redux');
    // ... Fetch data and do something ...
  }, [getFetchUrl]); // 🚧 Deps are correct but they change too often

  // ...
}
```


相反的，有两个简单的解决方法

1. 如果一个函数没有使用组件内的任何值，那么应该提到组件的外部定义(api util ?), 然后可以自由的在effects中使用。

你不需要为他设置依赖，因为他们不在渲染的范围之内，因此不会受数据流的影响，它不可能突然的意外地依赖于props或者state...

2. 或者包装成useCallback hook..


.. use callback 不是很懂，不要紧


useMemo 可以让我们对复杂对象做类似的事情。。


```
function ColorPicker() {
  const [color, setColor] = useState('pink');
  const stype = useMemo(() => ({color}), [color]);
}
```


#### race condition 问题

比如说第一次的api call 返回的比第二次的api 还要晚，因为有diff, 所以会替换掉最新的那次请求。。。 哈啊哈。。。。。


#### 提高水准

在class组件的生命周期的思维模型中，副作用的行为和渲染输出都是不同的。UI渲染是被props和state驱动的。并且能够步调一致。但副作用并不是这样。这是一类厂家你的问题来源。。


而在useEffect的思维模型当中，默认都是同步的。副作用变成了react数据流的一部分。。对于每个useEffect的调用，一旦你处理正确，你的组件就能够更好的处理边缘情况。

然而，用好useEffect的前期学习成本更高。这可能让人气恼。用同步的代码去处理边缘情况天然就比出发一次不用和渲染结果步调一致的副作用更难。


目前为止，useEffect主要用于请求数据，但是数据请求准确来说不是一个同步问题。因为哦我们的依赖，经常是[] 所以这一点尤其明显。



