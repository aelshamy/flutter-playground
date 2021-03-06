class Passwords {
  String? password;
  String? confirmPassword;
  late int length;

  Passwords() {
    password = "";
    confirmPassword = "";
    length = 8;
  }

  bool nonEmpty() {
    return password != null &&
        password!.length > 0 &&
        confirmPassword != null &&
        confirmPassword!.length > 0;
  }

  bool match() {
    return password == confirmPassword;
  }

  bool valid() {
    return password!.length >= length;
  }
}
