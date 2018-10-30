package main

import (
	"github.com/gin-gonic/gin"
)

var router *gin.Engine

func main() {
	// default router
	router = gin.Default()

	// load templates
	router.LoadHTMLGlob("templates/*")

	//
	// router.GET("/", func(c *gin.Context) {
	// 	c.HTML(
	// 		http.StatusOK,
	// 		"index.html",
	// 		// H is short for a map, which should be a sessionScope in Java
	// 		gin.H{
	// 			"title": "Home Page",
	// 		},
	// 	)
	// })

	// Initialize the routes
	initializeRoutes()

	// run server
	router.Run()
}
