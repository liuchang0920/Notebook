package main

import (
	"fmt"
	"image"
	"io"
	"math"
	"strings"
	"time"
)

type Vertex struct {
	X, Y float64
}

// Abs 后面的括号是必须的,表明是一个绑定在Vertex类型上的一个函数
// func (v Vertex) Abs() float64 {
// 	return math.Sqrt(v.X*v.X + v.Y*v.Y)
// }

// 如果改成值 接受者,那么scale方法会对原始Vertex的值的副本进行操作.
func (v *Vertex) Scale(f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}
func main() {
	// v := Vertex{3, 4}
	// fmt.Println(v.Abs())

	// 指针接受者
	// v.Scale(10)
	// fmt.Println(v.Abs())

	// 使用值或者指针
	/*

		使用指针
		1. 能够修改接受者指向的值
		2. 避免在每次调用的时候,赋值该值. 若值为大型的结构体时,会更加高效

	*/

	// interface 接口
	var a Abser

	f := MyFloat(-math.Sqrt2)
	v := Vertex{3, 4}

	a = f
	a = &v

	// error message:  Vertex does not implement Abser (Abs method has pointer receiver)
	// a = v

	fmt.Println(a.Abs())

	// 接口与隐式实现, 隐式接口从接口的实现中解耦了定义,这样接口的实现可以出现在任何包中,无需提前准备
	var i I
	i = &T{"hello"}
	describe(i)
	i.M()

	i = F(math.Pi)
	describe(i)
	i.M()

	// nil 接口既不保存值,也不保存具体类型, 因为接口元祖找不到具体调用的方法

	// 使用零个方法的接口值,称为"空接口" interface{}
	var i2 interface{}
	describe(i2)

	i2 = 42
	describe(i2)

	i2 = "hello"
	describe(i2)

	// 接口 类型断言
	var i3 interface{} = "Hello"

	s := i3.(string)
	fmt.Println(s)

	s, ok := i3.(string) // 该语句 断言接口值i 是否保存了具体类型 T
	fmt.Println(s, ok)

	f3, ok3 := i3.(float64)
	fmt.Println(f3, ok3)

	// f4 := i.(float64)
	// fmt.Println(f4) // panic !! float64 does not implement I (missing M method)

	a5 := Person{"A", 10}
	b5 := Person{"B", 20}
	fmt.Println(a5, b5)

	// 错误
	/*
		type error interface {
			Error() string
		}
	*/
	// error为nil时表示成功,非空的时候表示失败
	if err := run(); err != nil {
		fmt.Println(err)
	}

	// Reader, 一个io 接口
	r := strings.NewReader("hello, reader")
	b := make([]byte, 8)
	for {
		n, err := r.Read(b)
		fmt.Printf("n = %v, err = %v b = %v\n", n, err, b)
		fmt.Printf("b[:n] = %q\n", b[:n])
		if err == io.EOF {
			break
		}
	}
	//  图像 接口
	m := image.NewRGBA(image.Rect(0, 0, 100, 100))
	fmt.Println(m.Bounds())
	fmt.Println(m.At(0, 0).RGBA())
}

type Abser interface {
	Abs() float64
}

type MyFloat float64

func (f MyFloat) Abs() float64 {
	if f < 0 {
		return float64(-f)
	}
	return float64(f)
}

// type Vertex {
// 	X, Y float64
// }

func (v *Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

type I interface {
	M()
}

type T struct {
	S string
}

func (t *T) M() {
	fmt.Println(t.S)
}

type F float64

func (f F) M() {
	fmt.Println(f)
}

// func describe(i I) {
// 	fmt.Printf("(%v, %T)\n", i, i)
// }

func describe(i interface{}) {
	fmt.Printf("(%v, %T)\n", i, i)
}

type Person struct {
	Name string
	Age  int
}

func (p Person) string() string {
	return fmt.Sprintf("%v (%v years)", p.Name, p.Age)
}

type MyError struct {
	When time.Time
	what string
}

func (e *MyError) Error() string {
	return fmt.Sprintf("at %v, %s", e.When, e.what)
}

func run() error {
	return &MyError{
		time.Now(),
		"It didnt work",
	}
}
