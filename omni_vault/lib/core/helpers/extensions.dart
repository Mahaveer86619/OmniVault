extension ExtString on String {
  bool get isValidEmail {
    // ? Checks if the string is a valid email address.
    //
    // ? Uses a regular expression to validate the email format, including:
    // ? Presence of an "@" symbol.
    // ? Username containing letters, numbers, periods, and some special characters.
    // ? Domain name with letters and a top-level domain (e.g., .com, .org).
    final emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    return emailRegExp.hasMatch(this);
  }

  // ? Checks if the string is a strong password.
  //
  // ? Uses a regular expression to enforce password complexity, including:
  // ? Minimum length of 8 characters.
  // ? At least one lowercase letter.
  // ? At least one uppercase letter.
  // ? At least one number.
  // ? At least one special character (@, $, !, %, *, &, etc.).
  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    return passwordRegExp.hasMatch(this);
  }

  // ? Checks if the string is a valid username with the following properties:
  //
  // ? Length between 8 and 20 characters
  // ? Allowed characters: letters, numbers, underscore, and period
  // ? Cannot start or end with underscore or period
  // ? Cannot contain two consecutive underscores or periods
  bool get isValidUsername {
    final usernameRegExp =
        RegExp(r'^(?=[a-zA-Z0-9._]{6,20}$)(?!.*[_.]{2})[^_.].*[^_.]$');

    return usernameRegExp.hasMatch(this);
  }
}
