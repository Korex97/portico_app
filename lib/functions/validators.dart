class Validators {
  bool validateEmail(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return emailValid;
  }

  bool validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z]).{6,}$';
    RegExp regExp = RegExp(pattern);

    final bool validPassword = regExp.hasMatch(value);
    return validPassword;
  }

  bool validatePhone(String phone) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);

    final bool validPhone = regExp.hasMatch(phone);

    return validPhone;
  }

  bool checkUpperCase(String value) {
    String pattern = r'[A-Z]';
    RegExp regExp = RegExp(pattern);

    final bool validPhone = regExp.hasMatch(value);

    return validPhone;
  }

  bool checkLoweCase(String value) {
    String pattern = r'[a-z]';
    RegExp regExp = RegExp(pattern);

    final bool validPhone = regExp.hasMatch(value);

    return validPhone;
  }

  bool checknumbers(String value) {
    String pattern = r'[0-9]';
    RegExp regExp = RegExp(pattern);

    final bool validPhone = regExp.hasMatch(value);

    return validPhone;
  }

  bool checkOnlyNumbers(String value) {
    String pattern = r'^[0-9.]+$';
    RegExp regExp = RegExp(pattern);

    final bool onlyNumbers = regExp.hasMatch(value);

    return onlyNumbers;
  }

  bool specialCharacters(String value) {
    String pattern = r'[!@#$%^&*(),.?]';
    RegExp regExp = RegExp(pattern);

    final bool validPhone = regExp.hasMatch(value);

    return validPhone;
  }
}

Validators validator = Validators();
