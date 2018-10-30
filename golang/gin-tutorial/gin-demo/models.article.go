package main

// Article ..
type Article struct {
	ID      int    `json:"id"`
	Title   string `json:"title"`
	Content string `json:"content"`
}

// fake data
var articleList = []Article{
	Article{ID: 1, Title: "title1", Content: "content1"},
	Article{ID: 2, Title: "title2", Content: "content2"},
}

func getAllArticles() []Article {
	return articleList
}
