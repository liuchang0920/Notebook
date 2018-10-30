package main

import (
	"io/ioutil"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
)

func TestShowIndexPageUnautheticated(t *testing.T) {
	r := getRouter(true)
	r.GET("/", showIndexPage)

	testHttpResponse(t, r, req, func(w *httptest.ResponseRecorder) bool {
		statusOK := w.Code == http.StatusOK

		p, err := ioutil.ReadAll(w.Body)
		pageOk := err == null && strings.Index(string(p), "<title>Home Page</title>") > 0
		return statusOK && pageOk
	})
}
