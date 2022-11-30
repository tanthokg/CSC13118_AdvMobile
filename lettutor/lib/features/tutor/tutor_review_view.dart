import 'package:flutter/material.dart';
import 'package:lettutor/dummy/dummy_data.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/widgets/review_card.dart';

class TutorReviewView extends StatefulWidget {
  const TutorReviewView({Key? key}) : super(key: key);

  @override
  State<TutorReviewView> createState() => _TutorReviewViewState();
}

class _TutorReviewViewState extends State<TutorReviewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          'Reviews',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: TextButton(
                style: TextButton.styleFrom(padding: const EdgeInsets.all(12)),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.writeReview);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.edit, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Write Review',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) => ReviewCard(review: reviews[index]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
