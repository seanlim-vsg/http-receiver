package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"regexp"

	"github.com/tdewolff/minify/v2"
	"github.com/tdewolff/minify/v2/json"
)

func main() {
	m := minify.New()
	m.AddFuncRegexp(regexp.MustCompile("[/+]json$"), json.Minify)

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case "POST":
			contentType := r.Header.Get("Content-type")
			reqBody, err := ioutil.ReadAll(r.Body)
			reqBody, err = m.Bytes(contentType, reqBody)
			if err != nil {
				panic(err)
			}
			fmt.Printf("%s\n", reqBody)
		default:
			fmt.Fprintf(w, "healthy")
		}
	})

	httpPort := os.Getenv("HTTP_PORT")
	if httpPort == "" {
		httpPort = "8080"
	}
	if err := http.ListenAndServe(":"+httpPort, nil); err != nil {
		panic(err)
	}
}
