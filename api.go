package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"golang.org/x/text/encoding/japanese"
	"golang.org/x/text/transform"
	"io/ioutil"
	"log"
	"net/http"
	"os/exec"
	"strings"
)

func handleRoot(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Access-Control-Allow-Headers", "*")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
	w.Header().Set("Content-Type", "text/plain; charset=UTF-8")

	log.Println("handleRoot called")

	res, err := exec.Command("./route", "高崎", "前橋").Output()
	if err != nil {
		log.Fatalln(err)
	}
	iostr := strings.NewReader(string(res))
	rio := transform.NewReader(iostr, japanese.ShiftJIS.NewDecoder())
	str, err := ioutil.ReadAll(rio)
	if err != nil {
		log.Fatalln(err)
	}

	if _, err := fmt.Fprintf(w, string(str)); err != nil {
		log.Fatalln(err)
	}
}

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/", handleRoot)

	fmt.Println("Listen..")
	log.Fatal(http.ListenAndServe(":8080", r))
}