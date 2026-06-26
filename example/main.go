package main

import "net/http"

func main() {
	http.HandleFunc("/hello", func(w http.ResponseWriter, r *http.Request) {
		_, _ = w.Write([]byte("hello gomodd!"))
	})

	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		return
	}
}
