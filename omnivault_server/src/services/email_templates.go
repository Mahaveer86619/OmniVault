package Services

import "fmt"

func GenerateWelcomeHTML(recipientEmail string) string {
    return fmt.Sprintf(`
    <!DOCTYPE html>
    <html>
    <head>
        <title>Welcome to OmniVault, %s</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
            }

            .card {
                width: 500px;
                margin: 20px auto;
                padding: 20px;
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 5px;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            }

            .card-header {
                text-align: center;
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .card-body {
                padding: 10px;
            }

            .card-text {
                font-size: 14px;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <div class="card">
            <div class="card-header">Welcome to Omni Vault</div>
            <div class="card-body">
                <p class="card-text">Hello,</p>
                <p class="card-text">Welcome to Omni Vault! We're excited to have you join our community.</p>
                <p class="card-text">You can now access your account and start using our services.</p>
            </div>
        </div>
    </body>
    </html>
    `, recipientEmail)
}

func GeneratePasswordResetHTML(code string, recipientEmail string) string {
	return fmt.Sprintf(`
    <!DOCTYPE html>
    <html>
    <head>
        <title>Password Reset</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
            }

            .card {
                width: 500px;
                margin: 20px auto;
                padding: 20px;
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 5px;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            }

            .card-header {
                text-align: center;
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .card-body {
                padding: 10px;
            }

            .card-text {
                font-size: 14px;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <div class="card">
            <div class="card-header">Password Reset</div>
            <div class="card-body">
                <p class="card-text">Hello from OmniVault, </p>
                <p class="card-text">Your requested password reset code is: <strong>%s</strong></p>
                <p class="card-text">If you did not request this code, please ignore this email.</p>
            </div>
        </div>
    </body>
    </html>
    `, code)
}
