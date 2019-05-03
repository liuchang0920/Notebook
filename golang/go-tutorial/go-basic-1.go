package main

import (
	"fmt"
	"math"
	"math/rand"
)

// x, y both int type
func add(x, y int) int {
	return x + y

}

// return multiple value
func swap(x, y string) (string, string) {
	return y, x
}

// 没有参数的return, 返回已命名的返回值,跟ruby一样蛋疼
func split(sum int) (x, y int) {
	x = sum * 4 / 9
	y = sum - x
	return
}

// var可以出现在包或者函数级别
var c, python, java bool

func main() {
	fmt.Println("number", rand.Intn(10))
	fmt.Printf("number %g \n", math.Sqrt(7))
	fmt.Println("pi: ", math.Pi)
	fmt.Println(add(1, 3))

	a, b := swap("hello", "world")
	fmt.Println(a, b)
	fmt.Println(split(17))

	var i int
	fmt.Println(i, c, python, java)
	// 如果初始化之已经存在,那么可以省略类型
	var c, pyhton, java = true, false, "no"
	fmt.Println(c, pyhton, java)

	// 端变量声明, 可以再类型明确的地方,代替var声明
	k := 3
	fmt.Println(k)

	// 基本类型的0值
	var inti int
	var f float64
	var boolb bool
	var s string
	fmt.Printf("%v %v %v %q \n", inti, f, boolb, s)

	// 类型转换
	var z uint = uint(5)
	var floatf float64 = math.Sqrt(float64(5 + 7))
	fmt.Println(z, floatf)

	// 类型推倒, 可能再看吧

	// 常量, 不能使用:= 进行赋值
	const World = "世界"
	fmt.Println("hello ", World)

}
