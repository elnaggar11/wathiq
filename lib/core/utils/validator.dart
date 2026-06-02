class AppValidator {
  AppValidator._internal();
  static final AppValidator _instance = AppValidator._internal();
  factory AppValidator() => _instance;

  static bool validateEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  static bool validateName(String name) {
    final RegExp nameRegex =
        RegExp(r"^[a-zA-Z]+(([',\.\-\s][a-zA-Z ])[a-zA-Z]*)*$");
    return nameRegex.hasMatch(name);
  }

  static bool validatePassword(String password) {
    final RegExp passwordRegex =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  static bool validateMobile(String phone) {
    final RegExp phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');
    return phoneRegex.hasMatch(phone);
  }
}
