import 'package:flutter/material.dart';
import 'package:lettutor/constants/datatype.dart';
import 'package:lettutor/constants/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String chosenLanguage = Language.english;

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
                    'assets/logo.png',
                    width: 80,
                    height: 80,
                  ),
                  Text(
                    ' LetTutor ',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text('EMAIL', style: TextStyle(fontSize: 16, color: Colors.grey)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  hintText: "abc@example.com",
                  prefixIcon: const Icon(Icons.alternate_email),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('PASSWORD', style: TextStyle(fontSize: 16, color: Colors.grey)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: TextField(
                obscureText: true,
                autocorrect: false,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  hintText: "******",
                  prefixIcon: const Icon(Icons.key),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.forgotPassword);
              },
              child: const Text('Forgot Password?'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.main,
                  (route) => false,
                );
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              child: const Text(
                'LOG IN',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                'Or continue with',
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.facebook, size: 40),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.g_mobiledata, size: 40),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.phone_android, size: 40),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Not a member yet?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.register);
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
