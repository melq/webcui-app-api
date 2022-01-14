package main

import (
	"fmt"
	"github.com/melq/webcui-api"
	"log"
	"net/http"
)

type Params struct {
	Sample string `webcui:"sample"` // 使用するパラメータに合わせてフィールドを変更する
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

	cmd := fmt.Sprintf("./sample %s", p.Sample) // 実行したいコマンドの形になるように変更する
	// 複数パターンのコマンドがある場合は、分岐等で文字列を適宜変更する

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
