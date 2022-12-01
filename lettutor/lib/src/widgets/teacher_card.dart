import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/dummy/teacher.dart';

class TeacherCard extends StatelessWidget {
  const TeacherCard({
    Key? key,
    required this.teacher,
    required this.isFavorite,
    required this.onFavoriteClicked,
  }) : super(key: key);

  final Teacher teacher;
  final bool isFavorite;
  final Function() onFavoriteClicked;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(context, Routes.teacherDetail),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(teacher.avatarUrl),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, Routes.teacherDetail),
                          child: Text(teacher.name,
                              style: Theme.of(context).textTheme.headline3),
                        ),
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
                  onPressed: onFavoriteClicked,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.blue,
                  ),
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
                onPressed: () => Navigator.pushNamed(context, Routes.teacherDetail),
                icon: const Icon(Icons.edit_calendar),
                label: const Text('Book'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
