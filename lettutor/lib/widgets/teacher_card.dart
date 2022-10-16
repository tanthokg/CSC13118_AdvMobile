import 'package:flutter/material.dart';
import 'package:lettutor/entities/teacher.dart';

class TeacherCard extends StatelessWidget {
  const TeacherCard({Key? key, required this.teacher}) : super(key: key);

  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage(teacher.avatarUrl),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(teacher.name,
                            style: Theme.of(context).textTheme.headline3),
                        Text(teacher.nationality, style: const TextStyle(fontSize: 16)),
                        Row(
                          children: List<Widget>.generate(
                            teacher.reviewScore,
                            (index) => const Icon(Icons.star, color: Colors.amber),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                )
              ],
            ),
            Wrap(
              spacing: 4,
              runSpacing: -6,
              children: List<Widget>.generate(
                teacher.specialties.length,
                (index) => Chip(
                  backgroundColor: Colors.lightBlue[50],
                  label: Text(
                    teacher.specialties[index],
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ),
            ),
            Text(teacher.description),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.calendar_month),
                label: const Text('Book'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
