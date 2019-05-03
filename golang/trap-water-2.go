{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 3,
   "metadata": {},
   "outputs": [],
   "source": [
    "import (\n",
    "    \"container/heap\"\n",
    ")\n",
    "\n",
    "func trapRainWater(hs[][]int) int {\n",
    "    if(len(hs) <3 || len(hs[0] < 3)) {\n",
    "        return 0\n",
    "    }\n",
    "    \n",
    "    m, n:= len(hs), len(hs[0])\n",
    "    pq = make(PriorityQueuetyQueuetyQueuerityQueuerityQueue)\n",
    "}\n",
    "// need to implement Priority queue\n",
    "type cell struct {\n",
    "    rol, col, height int\n",
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
