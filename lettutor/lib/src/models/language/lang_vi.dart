import 'package:lettutor/src/models/language/language.dart';

class Vietnamese extends Language {
  Vietnamese() {
    id = 'VI';
  }
  // Login Text
  @override
  String get email => 'Email';

  @override
  String get password => 'Mật khẩu';

  @override
  String get registerQuestion => 'Chưa có tài khoản?';

  @override
  String get register => 'Đăng ký';

  @override
  String get login => 'Đăng nhập';

  @override
  String get forgotPassword => 'Quên mật khẩu';

  @override
  String get loginWith => 'Hoặc đăng nhập bằng';

  @override
  String get invalidEmail => 'Email phải có dạng abc@example.com';

  @override
  String get emptyEmail => 'Vui lòng nhập Email';

  @override
  String get passwordTooShort => 'Mật khẩu phải có ít nhất 6 ký tự';

  @override
  String get emptyPassword => 'Vui lòng nhập mật khẩu';

  @override
  String get registerSuccess => 'Tạo tài khoản thành công';

  // Register Text
  @override
  String get alreadyHaveAccount => 'Đã có tài khoản?';

  @override
  String get confirmPassword => 'Nhập lại mật khẩu';

  @override
  String get confirmPasswordEmpty => 'Vui lòng nhập lại mật khẩu';

  @override
  String get confirmPasswordNotMatch => 'Mật khẩu không khớp';

  // Forgot Password Text
  @override
  String get enterEmailToResetPassword =>
      'Vui lòng nhập địa chỉ email của bạn để nhận email đặt lại mật khẩu';

  @override
  String get sendRecoveryEmail => 'Gửi Email';

  @override
  String get sendRecoveryEmailSuccess => 'Gửi Email đặt lại mật khẩu thành công';

  @override
  String get backToLogin => 'Quay về đăng nhập';
}
