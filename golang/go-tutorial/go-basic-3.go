package main

import (
	"fmt"
	"strings"
)

func main() {
	// 指针
	/*
		*T, 指向T类型值的指针,零值为nil,
		&操作符会产生一个指向其操作数的指针..
		*操作符,表示指针指向的底层值...
	*/

	i, j := 42, 2017
	p := &i
	fmt.Println(*p)
	*p = 21
	fmt.Println(i)

	p = &j
	*p = *p / 37
	fmt.Println(j)
	// fmt.Print(2017 / 37)

	// 结构体, 使用点号访问字段
	v := Vertex{1, 2}
	fmt.Println(v)
	v.X = 5
	fmt.Println(v.X)

	// 结构体指针,
	/*
		如果有一个指向结构体的指针p, 那么可以通过(*p).X访问字段,不过这么写啰嗦,所以语言允许使用隐式调用p.X就可以
	*/
	p2 := &v
	p2.X = 20
	fmt.Println(v)

	fmt.Println(v1, p, v2, v3)

	// 数组,这个讲述顺序怎么乱糟糟的...
	var a [2]string // 数组表示的形式: 元素个数 + 数组类型
	a[0] = "Hello"
	a[1] = "works.s.."
	fmt.Println(a)
	fmt.Println(a[0], a[1])

	primes := [6]int{2, 3, 5, 7, 11, 13}
	fmt.Println(primes)

	// 切片
	var s []int = primes[1:4]
	fmt.Println(s)
	// 切片就像是数组的的引用

	// 切片文法,类似于没有长度的数组文法
	q := []bool{true, true, false, false}
	fmt.Println(q)

	// 匿名声明的切片
	s2 := []struct {
		i int
		b bool
	}{
		{2, true},
		{3, false},
		{7, true},
		{11, true},
	}

	fmt.Println("s2: ", s2)

	// 切片 默认的下界是0, 上界是切片的长度,可以省略, 跟python有点像
	s3 := []int{1, 2, 3, 4, 5, 6, 7}
	fmt.Println(s3[1:4])
	fmt.Println(s3[:2])
	fmt.Println(s3[1:])

	// 切片长度和容量, 容量是,从他的第一个元素开始数,到其底层数组元素末尾的个数
	s = s[:0]
	printSlice(s)
	s = s[:4]
	printSlice(s)
	s = s[2:]
	printSlice(s)
	s = s[2:]
	printSlice(s)

	// nil 切片
	// 切片的零值是nil. 长度和容量为0, 没有底层数组
	var s4 []int
	printSlice(s4)

	// make创建切片
	a5 := make([]int, 5)
	printSlice(a5)

	b5 := make([]int, 0, 5) // length = 0, cap; 5
	printSlice(b5)

	c5 := b5[:2]
	printSlice(c5)

	d5 := c5[2:5]
	printSlice(d5)

	// 切片的切片
	board := [][]string{
		[]string{"_", "_", "_"},
		[]string{"_", "_", "_"},
		[]string{"_", "_", "_"},
	}

	// player take turns
	board[0][0] = "X"
	board[2][2] = "O"

	for i = 0; i < len(board); i++ {
		fmt.Printf("%s\n", strings.Join(board[i], " "))
	}

	// 切片追加元素

	var s6 []int
	printSlice(s6)

	s6 = append(s6, 0)
	printSlice(s6)

	s6 = append(s6, 1) // 直接追加的元素, 并不是长度
	printSlice(s6)

	s6 = append(s6, 2, 3, 4)
	printSlice(s6)

	// append(s []T, vs ...T) []T

	// range
	// for循环的range形式可以遍历切片
	pow2 := []int{1, 2, 4, 8, 16}
	for i, v := range pow2 {
		fmt.Printf("2**%d = %d\n", i, v)
	}
	for _, value := range pow2 {
		fmt.Println(value)
	}

	// map
	// map的零值是nil, nil映射没有键, 也不能添加键
	// 要用make来初始化map
	var m map[string]Vertex
	// 没有初始化会报panic
	m = make(map[string]Vertex)
	m["1"] = Vertex{1, 2}
	fmt.Println(m["1"])

	// 修改map元素
	m6 := make(map[string]int)
	m6["answer"] = 6
	fmt.Println("value: ", m6["answer"])

	m6["answer"] = 48
	fmt.Println("value: ", m6["answer"])

	delete(m6, "answer")
	fmt.Println("value: ", m6["answer"])

	v6, ok6 := m6["answer"]
	fmt.Println("value: ", v6, " present?", ok6)

	// 函数闭包
	// 闭包是一个函数值, 它引用了函数体之外的变量, 函数可以访问并富裕引用的变量的值.换句话说,函数被绑定了在这些变量上

	// eg: 每个闭包都被绑定到各自的sum 变量上
	pos, neg := adder(), adder()
	for i := 0; i < 10; i++ {
		fmt.Println(
			pos(i),
			neg(-2*i),
		)
	}
}

// Vertex ..
type Vertex struct {
	X int
	Y int
}

var (
	v1 = Vertex{1, 2}
	v2 = Vertex{X: 1}
	v3 = Vertex{}
	p  = &Vertex{1, 2}
)

func printSlice(s []int) {
	fmt.Printf("len=%d cap=%d, %v \n", len(s), cap(s), s)
}

// 返回一个函数
func adder() func(int) int {
	sum := 0
	return func(x int) int {
		sum += x
		return sum
	}
}
