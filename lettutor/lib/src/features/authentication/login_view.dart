import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/datatype.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/models/user/token.dart';
import 'package:lettutor/src/models/user/user.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:lettutor/src/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String chosenLanguage = Language.english;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isAuthenticating = false;
  bool _isAuthenticated = false;

  void _handleLogin(AuthProvider authProvider) async {
    try {
      await AuthService.loginWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
        authProvider: authProvider,
        callback: callback,
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Login: ${e.toString()}')),
      );
    }
  }

  callback(User user, Token token, AuthProvider authProvider) async {
    final prefs = await SharedPreferences.getInstance();
    authProvider.logIn(user, token);
    await prefs.setString('refresh_token', authProvider.token!.refresh!.token!);

    setState(() {
      _isAuthenticating = false;
      _isAuthenticated = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushNamedAndRemoveUntil(context, Routes.main, (route) => false);
    });
  }

  void authenticate(AuthProvider authProvider) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh_token') ?? '';
      await AuthService.authenticate(
          refreshToken: refreshToken,
          authProvider: authProvider,
          callback: callback);
    } catch (e) {
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isAuthenticating) {
      authenticate(authProvider);
    }

    return Scaffold(
      body: _isAuthenticating
          ? const CircularProgressIndicator()
          : _isAuthenticated
              ? const SizedBox.shrink()
              : SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                      16, MediaQuery.of(context).padding.top, 16, 16),
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
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          hintText: 'abc@example.com',
                          prefixIcon: const Icon(Icons.mail, size: 26),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'PASSWORD',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          hintText: '******',
                          prefixIcon: const Icon(Icons.lock, size: 26),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: () {
                          _handleLogin(authProvider);
                        },
                        style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'LOG IN',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.forgotPassword);
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Or continue with',
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Image.asset(
                                'assets/logo/facebook.png',
                                width: 40,
                                height: 40,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Image.asset(
                                'assets/logo/google.png',
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Not a member yet?',
                            style: TextStyle(fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.register);
                            },
                            child: const Text(
                              'Register',
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
