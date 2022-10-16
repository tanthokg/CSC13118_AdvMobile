import 'package:flutter/material.dart';

enum Language { english, vietnamese }

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo.png'),
        title: const Text('LetTutor'),
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.translate),
              itemBuilder: (context) => const [
                    PopupMenuItem<Language>(
                      value: Language.english,
                      child: Text('English'),
                    ),
                    PopupMenuItem<Language>(
                      value: Language.vietnamese,
                      child: Text('Vietnamese'),
                    ),
                  ])
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/login-banner.png'),
            const Text('Say hello to your English tutors'),
            const Text(
                'Become fluent faster through one on one video chat lessons tailored to your goals.'),
            const Text('EMAIL'),
            const TextField(),
            const Text('PASSWORD'),
            const TextField(),
            TextButton(
              onPressed: () {},
              child: const Text('Forgot Password?'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('LOG IN'),
            ),
            const Text('Or continue with'),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.facebook)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.g_mobiledata)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.phone_android)),
              ],
            ),
            Row(
              children: [
                const Text('Not a member yet?'),
                TextButton(
                  onPressed: () {},
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
