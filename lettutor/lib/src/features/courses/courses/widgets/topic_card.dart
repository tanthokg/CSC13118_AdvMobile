import 'package:flutter/material.dart';
import 'package:lettutor/src/features/courses/courses/views/topic_view.dart';
import 'package:lettutor/src/models/course/course_topic.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({
    Key? key,
    required this.index,
    required this.topic,
  }) : super(key: key);

  final int index;
  final CourseTopic topic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Card(
        elevation: 1.5,
        surfaceTintColor: Colors.white,
        child: ListTile(
          title: Text('${index + 1}. ${topic.name}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TopicView(
                  title: topic.name ?? 'null name',
                  url: topic.nameFile ?? 'null file',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
