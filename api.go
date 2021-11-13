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

	_, err := fmt.Fprintf(w, "Welcome to start-zoom-cui!!")
	if err != nil {
		log.Fatalln(err)
	}
}

func handleCallCUI(w http.ResponseWriter, r *http.Request) {
	log.Println("handleCallCUI called")

	user := r.FormValue("user")
	option := r.FormValue("option")
	name := r.FormValue("name")
	url := r.FormValue("url")
	weekly := r.FormValue("weekly")
	day := r.FormValue("day")
	year := r.FormValue("year")
	date := r.FormValue("date")
	shour := r.FormValue("shour")
	sminute := r.FormValue("sminute")
	ehour := r.FormValue("ehour")
	eminute := r.FormValue("eminute")



	res, err := exec.Command("./start-zoom-cui", ).Output()
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
		str = str + "<br>"
		_, err := fmt.Fprintf(w, str)
		if err != nil {
			log.Fatalln(err)
		}
	}
}

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/", handleRoot)
	r.HandleFunc("/cui", handleCallCUI)

	fmt.Println("Listen..")
	log.Fatal("ListenAndServe", http.ListenAndServe(":8080", r))
}