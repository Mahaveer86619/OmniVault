package helpers

import (
	"fmt"
	"math/rand"
	"time"
)

func Gen6DigitCode() string {
	return fmt.Sprint(rand.Intn(999999-100000) + 100000)
}

func GetCurrentDateTimeAsString() string {
	now := time.Now()
	return now.Format("2006-01-02 15:04:05")
}
