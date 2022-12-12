import 'package:flutter/material.dart';
import 'package:lettutor/src/dummy/review.dart';
import 'package:lettutor/src/models/tutor/tutor_feedback.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({Key? key, required this.feedback, }) : super(key: key);

  final TutorFeedback feedback;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      surfaceTintColor: Colors.white,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    feedback.firstInfo?.name ?? 'null name',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ...List<Widget>.generate(
                  feedback.rating ?? 0,
                  (index) => const Icon(Icons.star, color: Colors.amber),

                ),
                ...List<Widget>.generate(
                  5 - feedback.rating!.toInt(),
                      (index) => const Icon(Icons.star, color: Colors.grey),

                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(feedback.content ?? 'null content')
          ],
        ),
      ),
    );
  }
}
