import 'package:flutter/material.dart';
import 'package:lettutor/constants/datatype.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo.png'),
        title: Text(
          'LetTutor',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.translate, color: Colors.blue),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
                child: Image.asset('assets/login-banner.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Start learning with LetTutor',
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Become fluent faster through one on one video chat lessons '
                  'tailored to your goals.',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
              const Text('EMAIL', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextField(),
              ),
              const Text('PASSWORD', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextField(),
              ),
              TextButton(
                onPressed: () {},
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Or continue with', textAlign: TextAlign.center),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.facebook),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.g_mobiledata),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.phone_android),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Log In'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
