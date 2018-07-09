# 代理

proxy对象可以拦截某些操作，并实现自定义的行为。

```js

let handler = {
    get: function(target, name) {
        return name in target? target[name]: 42;
    }
}

let p = new Proxy({}, handler);
p.a = 1;

console.log(p.a, p.b);
// 1, 42 ???

```

这里，代理的对象在获取未定义的属性时不会返回undefined，而是返回 42


## 术语

* handler: 包含陷阱的占位符对象
* traps: 提供属性访问的方法。
* target: 代理虚拟化的对象
* invariants: 实现自定义操作保持不变的语义称为不变来那个。如果违反处理程序的不变量，则会抛出一个typeError.

## 撤销 Proxy ??

## 反射 ??


