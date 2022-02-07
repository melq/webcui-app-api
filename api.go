package main

import (
	"fmt"
	"github.com/melq/webcui-api"
	"log"
	"net/http"
)

type Params struct {
	User    string `webcui:"user"`
	Option  string `webcui:"option"`
	Name    string `webcui:"name"`
	Url     string `webcui:"url"`
	Weekly  string `webcui:"weekly"`
	Day     string `webcui:"day"`
	Year    string `webcui:"year"`
	Date    string `webcui:"date"`
	Shour   string `webcui:"shour"`
	Sminute string `webcui:"sminute"`
	Ehour   string `webcui:"ehour"`
	Eminute string `webcui:"eminute"`
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

	cmd := fmt.Sprintf("./start-zoom-cui -u %s", p.User)

	switch p.Option {
	case "register":
		cmd += " -r"
	case "start":
		cmd += " -s"
	case "make":
		stime := fmt.Sprintf("%s%s00", p.Shour, p.Sminute)
		etime := fmt.Sprintf("%s%s00", p.Ehour, p.Eminute)
		cmd += fmt.Sprintf(" -m --name %s --url %s --stime %s --etime %s", p.Name, p.Url, stime, etime)
		if p.Weekly == "true" {
			cmd += fmt.Sprintf(" --weekly --day %s", p.Day)
		} else {
			cmd += fmt.Sprintf(" --date %s%s", p.Year, p.Date)
		}
	case "list":
		cmd += " -l"
	case "edit":
		stime := fmt.Sprintf("%s%s00", p.Shour, p.Sminute)
		etime := fmt.Sprintf("%s%s00", p.Ehour, p.Eminute)
		cmd += fmt.Sprintf(" -e --name %s --url %s --stime %s --etime %s", p.Name, p.Url, stime, etime)
		if p.Weekly == "true" {
			cmd += fmt.Sprintf(" --weekly --day %s", p.Day)
		} else {
			cmd += fmt.Sprintf(" --date %s%s", p.Year, p.Date)
		}
	case "delete":
		cmd += fmt.Sprintf(" -d --name %s", p.Name)
	}

	res, err := webcui.ExecCommand(cmd)
	if err != nil {
		log.Println(err)
	}

	webcui.FmtAndWrite(res, w)
}

func main() {
	http.HandleFunc("/", handleRoot)

	fmt.Println("Listen..")
	log.Fatal("ListenAndServe", http.ListenAndServe(":8080", nil)
}
