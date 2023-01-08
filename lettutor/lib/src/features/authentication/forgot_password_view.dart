import 'package:flutter/material.dart';
import 'package:lettutor/src/models/language/lang_en.dart';
import 'package:lettutor/src/models/language/lang_vi.dart';
import 'package:lettutor/src/models/language/language.dart';
import 'package:lettutor/src/providers/app_provider.dart';
import 'package:lettutor/src/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  String chosenLanguage = 'English';

  final _emailController = TextEditingController();

  String _emailErrorText = '';
  bool _isValidToSend = false;

  void _handleValidation(Language language) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    if (_emailController.text.isEmpty) {
      _emailErrorText = language.emptyEmail;
      _isValidToSend = false;
    } else if (!emailRegExp.hasMatch(_emailController.text)) {
      _emailErrorText = language.invalidEmail;
      _isValidToSend = false;
    } else {
      _emailErrorText = '';
      _isValidToSend = true;
    }
    setState(() {});
  }

  void _handleForgotPassword(Language language) async {
    try {
      await AuthService.forgotPassword(_emailController.text);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(language.sendRecoveryEmailSuccess)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Reset Password: ${e.toString()}')),
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
            const SizedBox(height: 24),
            Text(
              lang.enterEmailToResetPassword,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              lang.email,
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
            const SizedBox(height: 24),
            TextButton(
              onPressed: _isValidToSend
                  ? () {
                      _handleForgotPassword(lang);
                    }
                  : null,
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                backgroundColor: _isValidToSend ? Colors.blue : Colors.grey[400],
              ),
              child: Text(
                lang.sendRecoveryEmail,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                lang.backToLogin,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
