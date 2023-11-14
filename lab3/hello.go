package main

import (
  "fmt"
  "log"
  "net/http"
  "os"
)

func helloWorldHandler(w http.ResponseWriter, r *http.Request) {
  fmt.Printf("Receive request path: %s\n", r.URL.Path)
  if r.URL.Path == "/" {
    files, err := ioutil.ReadDir("/tmp/resources/")
    if err != nil {
      http.Error(w, "Internal Server Error", http.StatusInternalServerError)
      return
    }
    _, _ = fmt.Fprintf(w, "<h1>Hi, there!</h1><br>")
    for _, file := range files {
      fileName := file.Name()
      link := fmt.Sprintf("<a href='/%s'>%s</a><br>", fileName, fileName)
      _, _ = fmt.Fprintf(w, link)
    }
  } else {
    filePath := "/tmp/resources/" + r.URL.Path[1:] + ".html"
    if _, err := os.Stat(filePath); err == nil {
      http.ServeFile(w, r, filePath)
    } else {
      http.Redirect(w, r, "/error", http.StatusFound)
    }
  }
}

func main() {
  fmt.Printf("Server started")
  http.HandleFunc("/", helloWorldHandler)
  http.HandleFunc("/error", func(w http.ResponseWriter, r *http.Request) {
    _, _ = fmt.Fprintf(w, "<h1>Error: File not found</h1>")
  })
  log.Fatal(http.ListenAndServe(":8080", nil))
}
