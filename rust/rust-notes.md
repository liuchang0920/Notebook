


* Rust async/await
  * YT的视频，整体听下来应该可以总结以下几点，以后如果有机会用到的话再补充
    * tokio framework会提供一个自己的runtime, 然后会有自己的executor service去run async的code，tokio::spawn的是一个假的thread. 并不一定是跟Linux上的spawn的thread一样 (determined by the type of executor service)。所以虽然code可能看上去不会死锁，但是由于可能只有一个thread等等的情况，会导致deadlock。 另外异步的result tracking也有点tricky, 可以用类似tracing等库，用来追捕异步的log。
    * 整体上，async/await也是一个syntax sugar。他们会转化成一个state machine， 用来在tokio的framework里好做各种的yield操作。
    * 注意rust的哲学是在compile time尽量能够catch所有的bug。当定义的一个函数的参数size不确定的时候，是一定会有问题的。比如说参数是一个实现了某些trait的parameter。 接下来需要学习一个Pin跟Dyn 应该能够cover这部分的问题了。
    * 这老哥还有一个async/await更底层的视频，有空可以再看看。其实跟语言没啥关系了，都是一些设计理念的问题。 有空看就拓展下思路吧。
     


* spin Lock
  * https://matklad.github.io/2020/01/02/spinlocks-considered-harmful.html 
* Memory ordering
  * https://en.cppreference.com/w/cpp/atomic/memory_order  
  * Video: https://www.youtube.com/watch?v=ZQFzMfHIxng
