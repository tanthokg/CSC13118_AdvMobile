import 'package:flutter/material.dart';
import 'package:lettutor/entities/review.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key, required this.review}) : super(key: key);

  final Review review;

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
                    review.username,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ...List<Widget>.generate(
                  review.rating,
                  (index) => const Icon(Icons.star, color: Colors.amber),

                ),
                ...List<Widget>.generate(
                  5 - review.rating,
                      (index) => const Icon(Icons.star, color: Colors.grey),

                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(review.content)
          ],
        ),
      ),
    );
  }
}
