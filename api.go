package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	"os/exec"
	"regexp"
	"strings"
)

func handleRoot(w http.ResponseWriter, r *http.Request) {
	log.Println("handleCallCUI called")
	w.Header().Set("Access-Control-Allow-Headers", "*")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
	w.Header().Set("Content-Type", "text/plain; charset=UTF-8")

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

	arg := fmt.Sprintf(" -u %s", user)

	switch option {
	case "register": arg += " -r"
	case "start": arg += " -s"
	case "make":
		stime := fmt.Sprintf("%s%s00", shour, sminute)
		etime := fmt.Sprintf("%s%s00", ehour, eminute)
		arg += fmt.Sprintf(" -m --name %s --url %s --stime %s --etime %s", name, url, stime, etime)
		if weekly == "true" {
			arg += fmt.Sprintf(" --weekly --day %s", day)
		} else {
			arg += fmt.Sprintf(" --date %s%s", year, date)
		}
	case "list": arg += " -l"
	case "edit":
		stime := fmt.Sprintf("%s%s00", shour, sminute)
		etime := fmt.Sprintf("%s%s00", ehour, eminute)
		arg += fmt.Sprintf(" -e --name %s --url %s --stime %s --etime %s", name, url, stime, etime)
		if weekly == "true" {
			arg += fmt.Sprintf(" --weekly --day %s", day)
		} else {
			arg += fmt.Sprintf(" --date %s%s", year, date)
		}
	case "delete": arg += fmt.Sprintf(" -d --name %s", name)
	}

	argSlice := strings.Split(arg, " ")
	res, err := exec.Command("./start-zoom-cui", argSlice...).Output()
	if err != nil {
		log.Fatalln(err)
	}

	str := string(res)
	strSlice := strings.Split(str, "\n")

	reg := regexp.MustCompile(`https?://[\w/:%#$&?()~.=+\-]+$`)
	for _, str := range strSlice {
		if reg.Match([]byte(str)) {
			str = fmt.Sprintf("<a href=\"%s\">%s</a>", str, str)
		}
		str += "<br>"
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
	log.Fatal("ListenAndServe", http.ListenAndServe(":8080", r))
}