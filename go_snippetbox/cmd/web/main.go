package main 

import (
  "log"
  "net/http"
)

func main() {
  mux := http.NewServeMux()
  mux.HandleFunc("/", home)
  mux.HandleFunc("/snippet", showSnippet)
  mux.HandleFunc("/snippet/create", createSnippet)

  // METHOD: ANY 
  // PATTERN: "/static/"
  // HANDLER: http.FileServer
  // ACTION: Serve a specific static file
  //
  // create a file server which serves files out of the "./ui/static" 
  // directory. note that filepath is relative!
  fileServer := http.FileServer(http.Dir("./ui/static/"))

  // use mux.Handle() to regester the file server as the handler for 
  // all URL paths that start with "/static/"
  mux.Handle("/static/", http.StripPrefix("/static", fileServer))

  log.Println("Starting server on :4000...")
  err := http.ListenAndServe(":4000", mux)
  log.Fatal(err)
}
