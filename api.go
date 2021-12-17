package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"github.com/melq/webcui-api"
	"log"
	"net/http"
)

type Params struct {
	Xi        string `webcui:"xi"`
	Ga        string `webcui:"ga"`
	Term      string `webcui:"term"`
	NewTerm   string `webcui:"newTerm"`
	IsUntyped string `webcui:"isUntyped"`
	Mode      string `webcui:"mode"`
	Num       string `webcui:"num"`
}

func handleRoot(w http.ResponseWriter, r *http.Request) {
	log.Println("handleRoot called")
	w.Header().Set("Access-Control-Allow-Headers", "*")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
	w.Header().Set("Content-Type", "text/plain; charset=UTF-8")

	p := Params{}
	err := webcui.MapPosts(&p, r)
	if err != nil {
		log.Fatalln(err)
	}

	//base := "./lcii/API"
	cmd := fmt.Sprintf("")

	res, err := webcui.ExecCommand(cmd)
	if err != nil {
		log.Println(err)
	}

	webcui.FmtAndWrite(res, w)
}

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/", handleRoot)

	fmt.Println("Listen..")
	log.Fatal("ListenAndServe", http.ListenAndServe(":8080", r))
}
