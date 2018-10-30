package main

import "testing"

func TestGetAllArticles(t *testing.T) {
	alist := getAllArticles()

	if len(alist) != len(articleList) {
		t.Fail()
	}

	// check member is identical 无所谓吧
	for i, v := alist {
		if v.Content != articleList[i].Content ||
		v.Title != articleList[i].Title {
			t.Fail()
			break
		}
	}
}