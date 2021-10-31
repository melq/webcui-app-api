package main

import (
	"fmt"
	"github.com/gorilla/mux"
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

	str := string(res)
	strSlice := strings.Split(str, "\n")

	/*iostr := strings.NewReader(string(res)) //Windowsでは日本語にShiftJISが使用されているため、変換する
	rio := transform.NewReader(iostr, japanese.ShiftJIS.NewDecoder())
	str, err := ioutil.ReadAll(rio)
	if err != nil {
		log.Fatalln(err)
	}*/

	for _, str := range strSlice {
		str = str + "\n"
		_, err := fmt.Fprintf(w, str)
		if err != nil {
			log.Fatalln(err)
		}
	}
}

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/", handleRoot)

	fmt.Println("Listen..")
	log.Fatal(http.ListenAndServe(":8080", r))
}