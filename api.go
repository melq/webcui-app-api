package main

import (
	"fmt"
	"github.com/melq/webcui-api"
	"log"
	"net/http"
)

type Params struct {
	From   string `webcui:"from"`
	To     string `webcui:"to"`
	Hour   string `webcui:"hour"`
	Minute string `webcui:"minute"`
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

	cmd := fmt.Sprintf("./route %s %s %s%s", p.From, p.To, p.Hour, p.Minute)

	res, err := webcui.ExecCommand(cmd)
	if err != nil {
		log.Println(err)
	}

	webcui.FmtAndWrite(res, w)
}

func main() {
	http.HandleFunc("/", handleRoot)

	fmt.Println("Listen..")
	log.Fatal("ListenAndServe", http.ListenAndServe(":8080", nil))
}
