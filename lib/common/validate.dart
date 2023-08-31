validateEmail(String email) {
  String exp = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  return RegExp(exp).hasMatch(email);
}

validatePassword(String password) {
  return password.isEmpty;
}
