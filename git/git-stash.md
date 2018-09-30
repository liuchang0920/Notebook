使用stash来暂存没有commit的内容，这部分文件可能不想提交，暂存在一个栈里，然后可以随时取出来

场景：

并不是你不想提交，而是工作只进行到一半，还没法提交，预计完成还需1天时间。但是，必须在两个小时内修复该bug，怎么办？

幸好，Git还提供了一个stash功能，可以把当前工作现场“储藏”起来，等以后恢复现场后继续工作：

```sh
# store files, that are not commited yet
git stash
git checkout master

# fix bug
git add readme.txt
git commit -m "fix bug 101"

# merge bug fix branch 
git checkout master
git merge --no-ff -m "merged bug fix 101" issue-101

# continue working on dev branch, and restore the added files from stack
git checkout dev
git status # workspace clean, use: git stash list to checkout
# stash@{0}: WIP on dev: f52c633 add merge
# use git stash apply, then git stash drop / git stash pop
git stash pop
git stash list # empty

```


总结
当手头工作没有完成时，先把现场的工作git stash，然后修复bug，修复以后，
再git stash pop，回到工作现场。

https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/00137602359178794d966923e5c4134bc8bf98dfb03aea3000
