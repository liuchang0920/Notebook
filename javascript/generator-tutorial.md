
tutorial


# Basics

http://www.ruanyifeng.com/blog/2015/04/generator.html


### 1. 什么是异步

任务分成两段，先执行第一段，然后转到其他的任务，等做好准备，再回头执行第二段



### 2. 回调函数的概念

javascript对于异步编程的实现就是回调函数。 就是把任务的第二段单独写在一个函数里面，等到重新执行这个任务的会后，直接调用这个函数。 所以他叫callback


```
fs.readFile("/etc/passwd", function(err, data) {
  if(err) throw err;
  console.log(data);
}
```
为什么Node 约定回调函数的第一个参数是err对象呢？

答：
因为程序分成两段，这两段之间报错，程序没有办法捕捉，只能当做第二个的参数

### 3. Promise

回调函数的问题： callback hell

```
fs.readFile(fileA, function(err, data) {
  fs.readFile(fileB, function(err, data)) {
  ///..
  }
})

```

Promise不是新的语法功能，而是一种新的写法。允许将回调函数的横向加载，改成纵向加载。采用Promise 可以连续读多个文件

```
let readFile = require('...');

readFile(fileA)

.then(data => {
  consle.log(data.toString())
})

.then(() => {
 return readFile(fileB)
})

.then(data => {
  console.log(data.toString)
})

.catch(err => {
  console.log(err)
})
```

### 4. 协程

corountine

多个线程互相协作，完成异步任务。

协程遇到yield命令就暂停，等到执行权返回，再从暂停的部分继续往后执行。它的最大优点是，像极了同步操作。如果去去除yield命令，简直一模一样


### 5. generator 函数的概念

最大的特点是可以交出函数的执行权 (暂停执行)


```
function* gen(x) {
  let y = yield x + 2;
  return y;
}

let g = gen(1)
g.next()
g.next()
```


调用generator函数，会返回一个内部的指针（遍历器）
generator函数不用于其他函数的地方： 他不会返回结果，返回的是指针对象。

会移动内部的指针，会移动内部指针指向第一个yield的语句


### 6. generator 的
### 6. generator函数函数的
### 6. generator函数
