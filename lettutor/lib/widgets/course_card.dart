import 'package:flutter/material.dart';
import 'package:lettutor/entities/course.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.course,
  }) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(course.imageUrl),
          Text(course.name),
          Text(course.description),
          Row(
            children: [
              Expanded(child: Text(course.level)),
              Text('${course.numberOfLessons} lessons')
            ],
          )
        ],
      ),
    );
  }
}
