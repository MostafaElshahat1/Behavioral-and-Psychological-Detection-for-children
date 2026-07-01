class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return RegExp(
            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
        .hasMatch(password);
  }

    static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(phoneNumber);
  }

  static bool hasLowerCase(String password) {
    return RegExp(r'^(?=.*[a-z])').hasMatch(password);
  }

  static bool hasUpperCase(String password) {
    return RegExp(r'^(?=.*[A-Z])').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'^(?=.*?[0-9])').hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return RegExp(r'^(?=.{8,})').hasMatch(password);
  }
}



















/*class Tvalidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is requiard';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is requerd';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 charcters long';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must has at least one uppercase letter. ';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must has at least one numper';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*()":{}|<>]'))) {
      return 'password must has at least one special caracter';
    }
    return null;
  }

  static String? validatephonrnumper(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phonenmper is requred';
    }
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invaled phone numper formate (10 digites required)';
    }
    return null;
  }
}*/
