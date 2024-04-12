package services

import (
	"fmt"
	"time"
)

type Log interface {
	Handle(log string, time time.Time)
}

func NewLog() Log {
	return &LogPrint{}
}

type LogPrint struct{}

func (lp *LogPrint) Handle(log string, time time.Time) {
	iso8601Format := "2006-01-02T15:04:05-07:00"
	iso8601String := time.Format(iso8601Format)
	linelog := fmt.Sprintf("%s:%s", iso8601String, log)
	println(linelog)
}
