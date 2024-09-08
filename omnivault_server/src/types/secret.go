package types

type Secret struct {
	ID        string `json:"id"`
	UserID    string `json:"user_id"`
	Title     string `json:"title"`
	JsonPairs string `json:"json_pairs"`
	CreatedAt string `json:"created_at"`
	UpdatedAt string `json:"updated_at"`
}