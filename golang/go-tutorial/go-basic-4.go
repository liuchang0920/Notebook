package main

import (
	"fmt"
	"math"
)

type Vertex struct {
	X, Y float64
}

// Abs 后面的括号是必须的,表明是一个绑定在Vertex类型上的一个函数
func (v Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

// 如果改成值 接受者,那么scale方法会对原始Vertex的值的副本进行操作.
func (v *Vertex) Scale(f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}
func main() {
	v := Vertex{3, 4}
	fmt.Println(v.Abs())

	// 指针接受者
	v.Scale(10)
	fmt.Println(v.Abs())

}
