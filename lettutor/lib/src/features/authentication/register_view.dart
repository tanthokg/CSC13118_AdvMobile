import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/datatype.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/services/auth_service.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String chosenLanguage = Language.english;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _emailErrorText = '';
  String _passwordErrorText = '';
  String _confirmErrorText = '';
  bool _isValidToRegister = false;

  void _handleValidation() {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    if (_emailController.text.isEmpty) {
      _emailErrorText = 'Email cannot be empty';
      _isValidToRegister = false;
    } else if (!emailRegExp.hasMatch(_emailController.text)) {
      _emailErrorText = 'Email format must be abc@example.com';
      _isValidToRegister = false;
    } else {
      _emailErrorText = '';
      _isValidToRegister = true;
    }

    if (_passwordController.text.isEmpty) {
      _passwordErrorText = 'Email cannot be empty';
      _isValidToRegister = false;
    } else if (_passwordController.text.length < 6) {
      _passwordErrorText = 'Password must be at least 6 characters';
      _isValidToRegister = false;
    } else {
      _passwordErrorText = '';
      _isValidToRegister = true;
    }

    if (_confirmPasswordController.text.isEmpty) {
      _confirmErrorText = 'Password cannot be empty';
      _isValidToRegister = false;
    } else if (_confirmPasswordController.text.length < 6) {
      _confirmErrorText = 'Password must be at least 6 characters';
      _isValidToRegister = false;
    } else if (_confirmPasswordController.text != _passwordController.text) {
      _confirmErrorText = 'Re-typed password does not match';
      _isValidToRegister = false;
    } else {
      _confirmErrorText = '';
      _isValidToRegister = true;
    }
    setState(() {});
  }

  void _handleRegister() async {
    try {
      await AuthService.registerWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account Created Successfully')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Register: ${e.toString()}')),
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
                    // print(chosenLanguage);
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
            const SizedBox(height: 16),
            const Text(
              'PASSWORD',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: true,
              autocorrect: false,
              onChanged: (value) {
                _handleValidation();
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
            const Text(
              'CONFIRM PASSWORD',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              autocorrect: false,
              onChanged: (value) {
                _handleValidation();
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
                      _handleRegister();
                    }
                  : null,
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                backgroundColor: _isValidToRegister ? Colors.blue : Colors.grey[400],
              ),
              child: const Text(
                'REGISTER',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(fontSize: 16),
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
