import 'package:flutter/material.dart';

class CourseDetailView extends StatefulWidget {
  const CourseDetailView({
    Key? key,
  }) : super(key: key);

  @override
  State<CourseDetailView> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.blue,
        ),
        title: Text(
          'Course Details',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/course-01.png')
          ],
        ),
      ),
    );
  }
}
