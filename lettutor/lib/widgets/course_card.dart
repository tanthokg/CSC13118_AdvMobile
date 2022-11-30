import 'package:flutter/material.dart';
import 'package:lettutor/dummy/course.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.course,
    this.onTap,
  }) : super(key: key);

  final Course course;
  final Function(String value)? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!(course.name);
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        surfaceTintColor: Colors.white,
        child: Column(
          children: [
            Image.asset(course.imageUrl),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    course.description,
                    style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        course.level,
                        style: const TextStyle(fontSize: 18),
                      )),
                      Text(
                        '${course.numberOfLessons} lessons',
                        style: const TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
