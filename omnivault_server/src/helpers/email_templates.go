package helpers

import "fmt"

func forgotPasswordHTML(code string) string {
	return fmt.Sprintf(`
<!DOCTYPE html>
<html>
<head>
  <title>OmniVault: Your Password Forgottery</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f5f5f5;
    }

    .container {
      max-width: 600px;
      margin: 0 auto;
      padding: 20px;
    }

    .card {
      background-color: #fff;
      border: 1px solid #ccc;
      border-radius: 5px;
      padding: 20px;
    }

    h2 {
      text-align: center;
    }

    p {
      text-align: center;
    }

    .code {
      font-family: monospace;
      font-size: 18px;
      white-space: pre-wrap;
      margin: 20px 0;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="card">
      <h2>OmniVault: Your Password Forgottery</h2>
      <p>Well, well, well. Looks like someone's memory is as fuzzy as a cat's furball. Or maybe you're just too busy saving the world to remember your password. Either way, we've got you covered.</p>

      <p>Here's your secret code, straight from the vault of forgotten passwords: 
        <div class="code">
          123456
        </div>
      </p>

      <p>Just kidding! That's a placeholder. Your actual code is a secret so exclusive, even your goldfish couldn't guess it. But seriously, here's your real code:</p>
      <div class="code">
        Your actual verification code is: %s
      </div>

      <p>Now go forth and reset your password, and remember to write it down on a piece of paper that you'll definitely not lose.</p>
    </div>
  </div>
</body>
</html>
	`, code)
}
