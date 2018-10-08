package main

import (
	"fmt"
	"math"
	"runtime"
	"time"
)

func main() {
	// for loop
	sum := 1
	for sum < 1000 {
		sum += sum
	}
	fmt.Println(sum)

	// while loop , 因为c的while 在go中叫for
	sum = 1
	for sum < 1000 {
		sum += sum
	}
	fmt.Println(sum)

	// if
	fmt.Println(sqrt(2), sqrt(-4))

	// if可以在条件表达式之前执行一个简单的语句
	fmt.Println(
		pow(3, 2, 10),
		pow(3, 3, 10),
	)

	// switch
	fmt.Println("go runs on")
	switch os := runtime.GOOS; os {
	case "darwin": // 注意冒号的位置..
		fmt.Println("osx")
	case "linux":
		fmt.Println("linux")
	default:
		fmt.Printf("%s \n", os)
	}

	// switch求值顺序,跟java不一样,如果匹匹配成功,那么后续的case block不会执行
	fmt.Println("when is saturday?")
	today := time.Now().Weekday()
	switch time.Saturday {
	case today + 0:
		fmt.Println("Today")
	case today + 1:
		fmt.Println("tomorrow")
	case today + 2:
		fmt.Println("in two days")
	default:
		fmt.Println("too far away")
	}

	// 没有条件的switch同switch true 一样, 这种形式能够将if-then-else写的更加清晰
	t := time.Now()
	switch {
	case t.Hour() < 12:
		fmt.Println("good morning!")
	case t.Hour() < 17:
		fmt.Println("good afternoon!")
	default:
		fmt.Println("good morning")
	}

	// defer, 会将函数推迟到外层函数返回之后进行
	defer fmt.Println("world")
	fmt.Print("hello, ")

	// defer栈, 推迟的函数会亚茹一个栈当中,先进后出的顺序调用
	fmt.Println("counting")
	for i := 0; i < 10; i++ {
		defer fmt.Println(i)
	}
	fmt.Println("done")
}

func pow(x, n, lim float64) float64 {
	if v := math.Pow(x, n); v < lim {
		return v
	} else {
		// else 语句也得有个block, 花括号包围一下 else must be followed by if or statement block
		return lim
	}
}

func sqrt(x float64) string {
	if x < 0 {
		return sqrt(-x) + "i"
	}
	return fmt.Sprint(math.Sqrt(x))
}
