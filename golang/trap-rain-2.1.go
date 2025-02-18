{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 11,
   "metadata": {},
   "outputs": [],
   "source": [
    "import (\n",
    "    \"container/heap\"\n",
    ")\n",
    "\n",
    "func trapRainWater(hs[][]int) int {\n",
    "    if len(hs) <3 || len(hs[0]) < 3 {\n",
    "        return 0\n",
    "    }\n",
    "    \n",
    "    m, n:= len(hs), len(hs[0])\n",
    "    pq := make(PriorityQueue, 0, m*2 + n * 2)\n",
    "    \n",
    "    isVisited := make([][]bool, m)\n",
    "    for i:= range(isVisited) {\n",
    "        isVisited[i] = make([]bool, n)\n",
    "    }\n",
    "    \n",
    "    for i:=0;i<m;i++ {\n",
    "        isVisited[i][0] = true\n",
    "        isVisited[i][n-1] = true\n",
    "        pq = append(pq, cell{row: i, col: 0, height: hs[i][0]})\n",
    "        pq = append(pq, cell{row: i, col: 0, height: hs[i][n-1]})\n",
    "    }\n",
    "    \n",
    "    \n",
    "    for i:=0;i<n;i++ {\n",
    "        isVisited[0][i] = true\n",
    "        isVisited[m-1][i] = true\n",
    "        pq = append(pq, cell{row: i, col: 0, height: hs[0][i]})\n",
    "        pq = append(pq, cell{row: i, col: 0, height: hs[m-1][i]})\n",
    "    }\n",
    "    // why init here\n",
    "    heap.Init(&pq)\n",
    "    \n",
    "    dirs := [][]int{{-1, 0}, {1, 0}, {0, 1}, {0, -1}}\n",
    "    vol := 0\n",
    "    \n",
    "    for len(pq) >0 {\n",
    "        c := heap.Pop(&pq).(cell) // remember the way to receive struct\n",
    "        for _, d := range dirs {\n",
    "            i := c.row + d[0]\n",
    "            j := c.col + d[1]\n",
    "            \n",
    "            if 0<=i && i<m && 0<=j && j<n && !isVisited[i][j] {\n",
    "                isVisited[i][j] = true\n",
    "                vol += max(0, c.height - hs[i][j])\n",
    "                heap.Push(&pq, cell{row: i, col: j, height: max(hs[i][j], c.height)}) // might be higher than the entry's height\n",
    "            } \n",
    "        }\n",
    "    }\n",
    "    \n",
    "    return vol\n",
    "}\n",
    "// need to implement Priority queue\n",
    "type cell struct {\n",
    "    row, col, height int\n",
    "}\n",
    "\n",
    "type PriorityQueue []cell // [] need come first\n",
    "\n",
    "// 为什么这些函数不加* 号，implementation？？\n",
    "func (pq PriorityQueue) Len() int {\n",
    "    return len(pq)\n",
    "}\n",
    "\n",
    "func (pq PriorityQueue) Swap(i, j int) {\n",
    "    pq[i], pq[j] = pq[j], pq[i]\n",
    "}\n",
    "\n",
    "// 最小堆\n",
    "func (pq PriorityQueue) Less(i, j int) bool {\n",
    "    return pq[i].height < pq[j].height\n",
    "}\n",
    "\n",
    "func (pq *PriorityQueue) Push(x interface{}) {\n",
    "    item :=x.(cell)\n",
    "    *pq = append(*pq, item)\n",
    "}\n",
    "\n",
    "func (pq *PriorityQueue) Pop() interface{} {\n",
    "    old := *pq\n",
    "    n := len(old)\n",
    "    item := old[n-1]\n",
    "    *pq = old[0:n-1]\n",
    "    return item\n",
    "}\n",
    "\n",
    "func max(a, b int) int {\n",
    "    if a>b {\n",
    "        return a\n",
    "    }\n",
    "    return b\n",
    "}\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Go (lgo)",
   "language": "go",
   "name": "lgo"
  },
  "language_info": {
   "file_extension": "",
   "mimetype": "",
   "name": "go",
   "version": ""
  }
 },
 "nbformat": 4,
 "nbformat_minor": 2
}
