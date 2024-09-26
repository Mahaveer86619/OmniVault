package types

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