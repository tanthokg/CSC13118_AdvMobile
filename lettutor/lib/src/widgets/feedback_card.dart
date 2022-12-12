import 'package:flutter/material.dart';
import 'package:lettutor/src/dummy/review.dart';
import 'package:lettutor/src/models/tutor/tutor_feedback.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({
    Key? key,
    required this.feedback,
  }) : super(key: key);

  final TutorFeedback feedback;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      surfaceTintColor: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                feedback.firstInfo?.avatar ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.error_outline_rounded,
                  size: 32,
                  color: Colors.redAccent,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        feedback.firstInfo?.name ?? 'null name',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${DateTime.now().difference(DateTime.parse(feedback.createdAt!)).inDays} days ago',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ...List<Widget>.generate(
                        feedback.rating ?? 0,
                        (index) => const Icon(Icons.star, size: 20, color: Colors.amber),
                      ),
                      ...List<Widget>.generate(
                        5 - feedback.rating!.toInt(),
                        (index) => Icon(Icons.star, size: 20, color: Colors.grey[300]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(feedback.content ?? 'null content')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
