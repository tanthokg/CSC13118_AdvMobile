import 'package:flutter/material.dart';

class TeacherDetailView extends StatefulWidget {
  const TeacherDetailView({Key? key}) : super(key: key);

  @override
  State<TeacherDetailView> createState() => _TeacherDetailViewState();
}

class _TeacherDetailViewState extends State<TeacherDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          'Teacher Details',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
