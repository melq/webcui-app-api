package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"github.com/melq/webcui-api"
	"log"
	"net/http"
	"os/exec"
	"regexp"
	"strings"
)

type Params struct {
	User 	string `webcui:"user"`
	Option 	string `webcui:"option"`
	Name 	string `webcui:"name"`
	Url 	string `webcui:"url"`
	Weekly 	string `webcui:"weekly"`
	Day 	string `webcui:"day"`
	Year 	string `webcui:"year"`
	Date 	string `webcui:"date"`
	Shour 	string `webcui:"shour"`
	Sminute	string `webcui:"sminute"`
	Ehour 	string `webcui:"ehour"`
	Eminute	string `webcui:"eminute"`
}

func handleRoot(w http.ResponseWriter, r *http.Request) {
	log.Println("handleRoot called")
	w.Header().Set("Access-Control-Allow-Headers", "*")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
	w.Header().Set("Content-Type", "text/plain; charset=UTF-8")

	p := webcui.MapPosts(Params{}, r).(Params)

	arg := fmt.Sprintf(" -u %s", p.User)
	fmt.Println(arg)

	switch p.Option {
	case "register": arg += " -r"
	case "start": arg += " -s"
	case "make":
		stime := fmt.Sprintf("%s%s00", p.Shour, p.Sminute)
		etime := fmt.Sprintf("%s%s00", p.Ehour, p.Eminute)
		arg += fmt.Sprintf(" -m --name %s --url %s --stime %s --etime %s", p.Name, p.Url, stime, etime)
		if p.Weekly == "true" {
			arg += fmt.Sprintf(" --weekly --day %s", p.Day)
		} else {
			arg += fmt.Sprintf(" --date %s%s", p.Year, p.Date)
		}
	case "list": arg += " -l"
	case "edit":
		stime := fmt.Sprintf("%s%s00", p.Shour, p.Sminute)
		etime := fmt.Sprintf("%s%s00", p.Ehour, p.Eminute)
		arg += fmt.Sprintf(" -e --name %s --url %s --stime %s --etime %s", p.Name, p.Url, stime, etime)
		if p.Weekly == "true" {
			arg += fmt.Sprintf(" --weekly --day %s", p.Day)
		} else {
			arg += fmt.Sprintf(" --date %s%s", p.Year, p.Date)
		}
	case "delete": arg += fmt.Sprintf(" -d --name %s", p.Name)
	}

	argSlice := strings.Split(arg, " ")
	res, err := exec.Command("./start-zoom-cui", argSlice...).Output()
	if err != nil {
		log.Println(err)
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
			log.Println(err)
		}
	}
}

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/", handleRoot)

	fmt.Println("Listen..")
	log.Fatal("ListenAndServe", http.ListenAndServe(":8080", r))
}