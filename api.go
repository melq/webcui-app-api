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

	base := "./lcii/API"
	var option string
	if p.IsUntyped == "true" {
		option := "-u"
	} else {
		option := ""
	}

	cmd := fmt.Sprintf("%s", base)

	switch p.Mode {
	case "init":
		cmd += fmt.Sprintf(" init %s %s %s %s", option, p.Xi, p.Ga, p.Term)
	case "red":
		cmd += fmt.Sprintf(" red %s %s %s %s %s", option, p.Xi, p.Ga, p.NewTerm, p.Num)
	case "check":
		cmd += fmt.Sprintf(" check %s %s %s", p.Xi, p.Ga, p.Term)
	}

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
