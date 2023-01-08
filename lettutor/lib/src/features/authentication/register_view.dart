import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/models/language/lang_en.dart';
import 'package:lettutor/src/models/language/lang_vi.dart';
import 'package:lettutor/src/models/language/language.dart';
import 'package:lettutor/src/providers/app_provider.dart';
import 'package:lettutor/src/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String chosenLanguage = 'English';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _emailErrorText = '';
  String _passwordErrorText = '';
  String _confirmErrorText = '';
  bool _isValidToRegister = false;

  void _handleValidation(Language language) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    if (_emailController.text.isEmpty) {
      _emailErrorText = language.emptyEmail;
      _isValidToRegister = false;
    } else if (!emailRegExp.hasMatch(_emailController.text)) {
      _emailErrorText = language.invalidEmail;
      _isValidToRegister = false;
    } else {
      _emailErrorText = '';
      _isValidToRegister = true;
    }

    if (_passwordController.text.isEmpty) {
      _passwordErrorText = language.emptyPassword;
      _isValidToRegister = false;
    } else if (_passwordController.text.length < 6) {
      _passwordErrorText = language.passwordTooShort;
      _isValidToRegister = false;
    } else {
      _passwordErrorText = '';
      _isValidToRegister = true;
    }

    if (_confirmPasswordController.text.isEmpty) {
      _confirmErrorText = language.confirmPasswordEmpty;
      _isValidToRegister = false;
    } else if (_confirmPasswordController.text.length < 6) {
      _confirmErrorText = language.passwordTooShort;
      _isValidToRegister = false;
    } else if (_confirmPasswordController.text != _passwordController.text) {
      _confirmErrorText = language.confirmPasswordNotMatch;
      _isValidToRegister = false;
    } else {
      _confirmErrorText = '';
      _isValidToRegister = true;
    }
    setState(() {});
  }

  void _handleRegister(Language language) async {
    try {
      await AuthService.registerWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(language.registerSuccess)),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Register: ${e.toString()}')),
      );
    }
  }

  void _loadLanguage(AppProvider appProvider) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('language') ?? 'EN';
    if (lang == 'EN') {
      chosenLanguage = 'English';
      appProvider.setLanguage(English());
    } else {
      chosenLanguage = 'Tiếng Việt';
      appProvider.setLanguage(Vietnamese());
    }
  }

  void _updateLanguage(AppProvider appProvider, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value == 'English') {
      appProvider.language = English();
      await prefs.setString('language', 'EN');
    } else {
      appProvider.language = Vietnamese();
      await prefs.setString('language', 'VI');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final lang = appProvider.language;
    _loadLanguage(appProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: DropdownButton<String>(
                value: chosenLanguage,
                items: const [
                  DropdownMenuItem<String>(
                    value: 'English',
                    child: Text('English'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Tiếng Việt',
                    child: Text('Tiếng Việt'),
                  ),
                ],
                onChanged: (String? language) {
                  if (language != null) {
                    _updateLanguage(appProvider, language);
                  }
                  setState(() {
                    chosenLanguage = language!;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/lettutor.png',
                    width: 100,
                    height: 100,
                  ),
                  Text(
                    ' LetTutor ',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              lang.password,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              onChanged: (value) {
                _handleValidation(lang);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[400]),
                hintText: "abc@example.com",
                prefixIcon: Icon(
                  Icons.mail,
                  color: _emailErrorText.isEmpty ? Colors.blue : Colors.red[700],
                ),
                errorText: _emailErrorText.isEmpty ? null : _emailErrorText,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              lang.password,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: true,
              autocorrect: false,
              onChanged: (value) {
                _handleValidation(lang);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[400]),
                hintText: "******",
                prefixIcon: Icon(
                  Icons.lock,
                  color: _passwordErrorText.isEmpty ? Colors.blue : Colors.red[700],
                ),
                errorText: _passwordErrorText.isEmpty ? null : _passwordErrorText,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              lang.confirmPassword,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              autocorrect: false,
              onChanged: (value) {
                _handleValidation(lang);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[400]),
                hintText: "******",
                prefixIcon: Icon(
                  Icons.lock,
                  color: _confirmErrorText.isEmpty ? Colors.blue : Colors.red[700],
                ),
                errorText: _confirmErrorText.isEmpty ? null : _confirmErrorText,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: _isValidToRegister
                  ? () {
                      _handleRegister(lang);
                    }
                  : null,
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                backgroundColor: _isValidToRegister ? Colors.blue : Colors.grey[400],
              ),
              child: Text(
                lang.register,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lang.alreadyHaveAccount,
                  style: const TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    lang.login,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
