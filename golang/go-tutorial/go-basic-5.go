package main

import (
	"fmt"
	"sync"
	"time"
)

func main() {
	// go routine
	go say("world!")
	say("hello")

	// 信道 channel ch <- v
	// 与 map, slice一样在使用前,也需要使用make创建 ch := make(chan int)

	s := []int{1, 3, 5, 5645, 62, 3}
	c := make(chan int)

	go sum(s[:len(s)/2], c)

	go sum(s[len(s)/2:], c)

	x, y := <-c, <-c // 接收顺序就是channel完成的先后顺序

	fmt.Println(x, y, x+y)

	// 带缓冲的信道
	ch := make(chan int, 2)
	ch <- 1
	ch <- 2

	fmt.Println(<-ch)
	fmt.Println(<-ch)

	// range 和 close
	// 通过close可以关闭一个信道,可以通过接收表达式分配的第二个参数,测试信道是否关闭
	// v, ok <- ch

	c2 := make(chan int, 10)
	go fibona(cap(c2), c2)
	for i := range c2 {
		fmt.Println(i)
	}

	// select 语句
	// select 会阻塞到某个分支,继续执行为止,这是就会执行该分之.多个分之都准备好的时候,会随机选择一个执行
	c3 := make(chan int)
	quit := make(chan int)

	go func() {
		for i := 0; i < 10; i++ {
			fmt.Println(<-c3)
		}
		// 都打印执行完全部的fibona
		quit <- 0
	}()

	fibona2(c3, quit)

	// 默认选择, 当select其他分支都没有准备好的时候,default分支就会执行
	// 为了在尝试发送或者接收时不发生阻塞,可以使用default 分支

	// tick := time.Tick(100 * time.Millisecond)
	// boom := time.After(500 * time.Millisecond)

	// for {
	// 	select {
	// 	case <-tick:
	// 		fmt.Println("tick.")
	// 	case <-boom:
	// 		fmt.Println("boom")
	// 		return // 要结束程序
	// 	default:
	// 		fmt.Println("    .")
	// 		time.Sleep(50 * time.Millisecond)
	// 	}
	// }

	// Mutex 使用互斥锁
	c4 := SafeCounter{v: make(map[string]int)}
	for i := 0; i < 1000; i++ {
		go c4.Inc("someKey")
	}

	time.Sleep(time.Second)
	fmt.Print(c4.Value("someKey"))
}

func say(s string) {
	for i := 0; i < 5; i++ {
		time.Sleep(100 * time.Millisecond)
		fmt.Println(s)
	}
}

func sum(s []int, c chan int) {
	sum := 0
	for _, v := range s {
		sum += v
	}
	c <- sum // sum 送入 c
}

func fibona(n int, c chan int) {
	x, y := 0, 1
	for i := 0; i < n; i++ {
		c <- x
		x, y = y, x+y
	}
	// channel的buffer填满了
	close(c)
}

func fibona2(c, quit chan int) {
	x, y := 0, 1
	for {
		select {
		case c <- x:
			x, y = y, x+y
		case <-quit:
			fmt.Println("quit")
			return
		}
	}
}

type SafeCounter struct {
	v   map[string]int
	mux sync.Mutex
}

func (c *SafeCounter) Inc(key string) {
	c.mux.Lock()
	c.v[key]++
	c.mux.Unlock()
}

func (c *SafeCounter) Value(key string) int {
	c.mux.Lock()
	defer c.mux.Unlock() // 这里一定要用defer,因为return之后的语句执行不到了
	return c.v[key]
}
