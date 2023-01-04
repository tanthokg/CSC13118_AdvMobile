import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/datatype.dart';
import 'package:lettutor/src/services/auth_service.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  String chosenLanguage = Language.english;

  final _emailController = TextEditingController();

  String _emailErrorText = '';
  bool _isValidToSend = false;

  void _handleValidation() {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    if (_emailController.text.isEmpty) {
      _emailErrorText = 'Email cannot be empty';
      _isValidToSend = false;
    } else if (!emailRegExp.hasMatch(_emailController.text)) {
      _emailErrorText = 'Email format must be abc@example.com';
      _isValidToSend = false;
    } else {
      _emailErrorText = '';
      _isValidToSend = true;
    }
    setState(() {

    });
  }

  void _handleForgotPassword() async {
    try {
      await AuthService.forgotPassword(_emailController.text);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recovery Email Sent Successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Reset Password: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    value: Language.english,
                    child: Text(Language.english),
                  ),
                  DropdownMenuItem<String>(
                    value: Language.vietnamese,
                    child: Text(Language.vietnamese),
                  ),
                ],
                onChanged: (String? language) {
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
              'Please enter your email address to search for your account.',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'EMAIL',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              onChanged: (value) {
                _handleValidation();
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
                      _handleForgotPassword();
                    }
                  : null,
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                backgroundColor: _isValidToSend ? Colors.blue : Colors.grey[400],
              ),
              child: const Text(
                'SEND RECOVERY EMAIL',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Go Back To Log In',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
