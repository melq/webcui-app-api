package main

import (
	"fmt"
	"github.com/melq/webcui-api"
	"log"
	"net/http"
)

type Params struct {
	Str  string `webcui:"str"`
	Mode string `webcui:"mode"`
}

func handleRoot(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Access-Control-Allow-Headers", "*")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
	w.Header().Set("Content-Type", "text/plain; charset=UTF-8")

	p := Params{}
	err := webcui.MapPosts(&p, r)
	if err != nil {
		log.Fatalln(err)
	}

	var mode string
	if p.Mode == "number2kanji" {
		mode = "-k"
	} else {
		mode = "-n"
	}

	cmd := fmt.Sprintf("./n2k -s %s %s", p.Str, mode)

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
