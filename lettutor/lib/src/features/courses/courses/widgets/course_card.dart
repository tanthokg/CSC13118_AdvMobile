import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/course_levels.dart';
import 'package:lettutor/src/dummy/course.dart';
import 'package:lettutor/src/models/course/course.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.course,
  }) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: course.imageUrl ?? '',
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(
              Icons.error_outline_rounded,
              size: 32,
              color: Colors.redAccent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.name ?? 'null course name',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  course.description ?? 'null course description',
                  style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      courseLevels[course.level!] ?? 'null course level',
                      style: const TextStyle(fontSize: 18),
                    )),
                    Text(
                      '${course.topics!.length} lessons',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
