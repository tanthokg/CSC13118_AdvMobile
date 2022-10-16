import 'package:flutter/material.dart';
import 'package:lettutor/entities/teacher.dart';

class TeacherCard extends StatelessWidget {
  const TeacherCard({Key? key, required this.teacher}) : super(key: key);

  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                child: Image.asset(teacher.avatarUrl),
              ),
              Column(
                children: [
                  Text(teacher.name),
                  Text(teacher.nationality),
                  Text(teacher.reviewScore.toString()),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              )
            ],
          ),
          Wrap(
            children: List<Widget>.generate(
              teacher.specialties.length,
              (index) => Chip(
                label: Text(teacher.specialties[index]),
              ),
            ),
          ),
          Text(teacher.description),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.calendar_month),
            label: const Text('Book'),
          )
        ],
      ),
    );
  }
}
