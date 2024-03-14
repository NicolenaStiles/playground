package main

import (
  "fmt"
  "html/template"
  "log"
  "net/http"
  "strconv"
)

// METHOD: ANY
// PATTERN: "/"
// HANDLER: home 
// ACTION: Display the home page 
func home(w http.ResponseWriter, r *http.Request) {
  if r.URL.Path != "/" {
    http.NotFound(w,r)
    return
  }

  // init a slice containing paths to templating files
  files := []string{
    "./ui/html/home.page.tmpl",
    "./ui/html/base.layout.tmpl",
    "./ui/html/footer.partial.tmpl",
  }

  // Read the template files into a template set.
  // if theres an error, log it internally and send a generic 500 error to user
  ts, err := template.ParseFiles(files...)
  if err != nil {
    log.Println(err.Error())
    http.Error(w, "Internal Server Error", 500)
    return
  }

  // write template content as the response body
  err = ts.Execute(w, nil)
  if err != nil {
    log.Println(err.Error())
    http.Error(w, "Internal Server Error", 500)
  }
}

// METHOD: ANY
// PATTERN: "/snippet?id=1"
// HANDLER: showSnippet 
// ACTION: Display a specific snippet
func showSnippet(w http.ResponseWriter, r *http.Request) {
  id, err := strconv.Atoi(r.URL.Query().Get("id"))
  if err != nil || id < 1 {
    http.NotFound(w,r)
    return
  }

  fmt.Fprintf(w, "Display a specific snippet with ID %d...", id)
}

// METHOD: POST 
// PATTERN: "/snippet/create"
// HANDLER: createSnippet 
// ACTION: Create a new snippet
func createSnippet(w http.ResponseWriter, r *http.Request) {
  if r.Method != http.MethodPost {
    w.Header().Set("Allow", http.MethodPost)
    http.Error(w, "Method not Allowed", 405)
    return
  }

  w.Write([]byte ("Create a new snippet..."))
}
