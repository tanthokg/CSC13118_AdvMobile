abstract class Language {
  late final String id;
  // Login Text
  String get email;
  String get password;
  String get registerQuestion;
  String get login;
  String get register;
  String get forgotPassword;
  String get loginWith;
  String get invalidEmail;
  String get emptyEmail;
  String get passwordTooShort;
  String get emptyPassword;

  // Register Text
  String get alreadyHaveAccount;
  String get confirmPassword;
  String get confirmPasswordEmpty;
  String get confirmPasswordNotMatch;
  String get registerSuccess;

  // Forgot Password Text
  String get enterEmailToResetPassword;
  String get sendRecoveryEmail;
  String get sendRecoveryEmailSuccess;
  String get backToLogin;
}