{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 18,
   "metadata": {},
   "outputs": [],
   "source": [
    "\n",
    "\n",
    "func bigger(a int, b int) int {\n",
    "    if a>b {\n",
    "        return a\n",
    "    } \n",
    "    return b\n",
    "}\n",
    "\n",
    "func smaller(a int, b int) int {\n",
    "    if a<b {\n",
    "        return a\n",
    "    } \n",
    "    return b\n",
    "}\n",
    "\n",
    "// trap rain water\n",
    "func trap(height []int) int {\n",
    "    length:= len(height)\n",
    "    if length <=2 {\n",
    "        return 0\n",
    "    }\n",
    "    \n",
    "    left, right := make([]int,length), make([]int,length)\n",
    "    left[0], right[length-1] = height[0], height[length-1]\n",
    "    \n",
    "    for i:=1;i<length;i++ {\n",
    "        left[i] = bigger(left[i-1], height[i])\n",
    "        right[length-1-i] = bigger(right[length-i], height[length-i-1]) // reverse, combine left, right search in one loop\n",
    "    }\n",
    "    \n",
    "    total := 0\n",
    "    for i:=0;i<length;i++ {\n",
    "        total += smaller(left[i], right[i]) - height[i]\n",
    "    }\n",
    "    return total\n",
    "}"
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
