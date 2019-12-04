

react + rxjs + hooks

https://blog.crimx.com/2019/09/22/%E7%9C%9F%C2%B7%E5%A4%8D%E7%94%A8%E7%BB%84%E4%BB%B6-react-hooks-%E7%BB%93%E5%90%88-rxjs-%E5%B0%81%E8%A3%85%E5%BC%82%E6%AD%A5%E9%80%BB%E8%BE%91/



尝试only react + rxjs


https://blog.soshace.com/react-hooks-rxjs-or-how-react-is-meant-to-be/




## Redux observable

概括的讲，就是将异步的部分提炼到Epic里面去，然后在异步执行完毕以后，再调用dispatch(action)的操作


简单概括

```
//不需要使用epic的情况
Action => Reducer => Store => Re-render

// 需要使用epic的情况
Action(@@XXX/GET) => API call => Action(@@XXX/SET) => Reducer => Store => Re-render 

```

