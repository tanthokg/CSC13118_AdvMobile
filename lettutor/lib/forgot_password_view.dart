import 'package:flutter/material.dart';

import 'constants/datatype.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
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
                padding: const EdgeInsets.only(top: 60),
                child: Text(
                  'Reset Password',
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  'Please enter your email address to search for your account.',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text('Email', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextField(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                  child: const Text('SEND RESET LINK',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('Back to Log In'))
            ],
          ),
        ),
      ),
    );  }
}
