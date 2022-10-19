import 'package:flutter/material.dart';

class BecomeTutorView extends StatefulWidget {
  const BecomeTutorView({Key? key}) : super(key: key);

  @override
  State<BecomeTutorView> createState() => _BecomeTutorViewState();
}

class _BecomeTutorViewState extends State<BecomeTutorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Become A Tutor'),
      ),
    );
  }
}
