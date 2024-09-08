package Services

import (
	"net/smtp"
	"os"
)

// BasicEmailRequestBody is the request body for sending normal string emails
type BasicEmailRequestBody struct {
	To      string `json:"to"`
	Subject string `json:"subject"`
	Body    string `json:"body"`
}

// TemplateEmailRequestBody is the request body for sending HTML emails
type TemplateEmailRequestBody struct {
	To       string            `json:"to"`
	Subject  string            `json:"subject"`
	Template string            `json:"template"`
	Vars     map[string]string `json:"vars"`
}

func SendBasicEmail(to []string, subject string, body string) error {
	auth := smtp.PlainAuth(
		"",
		os.Getenv("FROM_EMAIL"),
		os.Getenv("FROM_EMAIL_PASSWORD"),
		os.Getenv("FROM_EMAIL_SMTP"),
	)

	message := "Subject: " + subject + "\n" + body

	err := smtp.SendMail(
		os.Getenv("SMTP_ADDR"),
		auth,
		os.Getenv("FROM_EMAIL"),
		to,
		[]byte(message),
	)

	return err
}

func SendBasicHTMLEmail(to []string, subject string, htmlBody string) error {
	auth := smtp.PlainAuth(
		"",
		os.Getenv("FROM_EMAIL"),
		os.Getenv("FROM_EMAIL_PASSWORD"),
		os.Getenv("FROM_EMAIL_SMTP"),
	)

	headers := "MIME-Version: 1.0;\nContent-Type: text/html; charset=\"UTF-8\";"

	message := "Subject: " + subject + "\n" + headers + "\n\n" + htmlBody

	err := smtp.SendMail(
		os.Getenv("SMTP_ADDR"),
		auth,
		os.Getenv("FROM_EMAIL"),
		to,
		[]byte(message),
	)

	return err
}
