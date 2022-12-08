import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/dummy/teacher.dart';
import 'package:lettutor/src/models/tutor/tutor.dart';

class TutorCard extends StatefulWidget {
  const TutorCard({
    Key? key,
    required this.tutor,
  }) : super(key: key);

  final Tutor tutor;

  @override
  State<TutorCard> createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  @override
  Widget build(BuildContext context) {
    final specialties = widget.tutor.specialties
            ?.split(',')
            .map((e) => e.replaceAll('-', ' '))
            .toList() ??
        ['no specs'];

    return Card(
      surfaceTintColor: Colors.white,
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(context, Routes.teacherDetail),
                  child: Container(
                    width: 72,
                    height: 72,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.tutor.avatar ?? 'null',
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error_outline_rounded, size: 32, color: Colors.redAccent,)
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.teacherDetail),
                          child: Text(widget.tutor.name ?? 'null',
                              style: Theme.of(context).textTheme.headline3),
                        ),
                        Text(widget.tutor.country ?? 'null',
                            style: const TextStyle(fontSize: 16)),
                        Row(
                          children: List<Widget>.generate(
                            widget.tutor.rating?.round() ?? 3,
                            (index) => const Icon(Icons.star, color: Colors.amber),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            Wrap(
              spacing: 8,
              runSpacing: -4,
              children: List<Widget>.generate(
                specialties.length,
                (index) => Chip(
                  backgroundColor: Colors.lightBlue[50],
                  label: Text(
                    specialties[index],
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ),
            ),
            Text(widget.tutor.bio ?? 'null'),
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
