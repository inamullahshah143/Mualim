class Helper {
  static validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'enter a valid email address';
    } else {
      return null;
    }
  }

  static validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'please enter your password';
    }  else {
        return null;
      }
  }
}
