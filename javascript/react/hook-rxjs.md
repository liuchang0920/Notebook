
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


