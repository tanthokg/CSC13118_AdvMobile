import 'package:flutter/material.dart';
import 'package:lettutor/src/dummy/dummy_data.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/models/tutor/tutor_feedback.dart';
import 'package:lettutor/src/widgets/feedback_card.dart';

class TutorFeedbackView extends StatefulWidget {
  const TutorFeedbackView({Key? key}) : super(key: key);

  @override
  State<TutorFeedbackView> createState() => _TutorFeedbackViewState();
}

class _TutorFeedbackViewState extends State<TutorFeedbackView> {
  @override
  Widget build(BuildContext context) {
    final feedbacks = ModalRoute.of(context)?.settings.arguments as List<TutorFeedback>;

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
        child: ListView.builder(
          itemCount: feedbacks.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => FeedbackCard(feedback: feedbacks[feedbacks.length - index - 1]),
        ),
      ),
    );
  }
}

// Center(
//   child: TextButton(
//     style: TextButton.styleFrom(padding: const EdgeInsets.all(12)),
//     onPressed: () {
//       Navigator.pushNamed(context, Routes.writeReview);
//     },
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: const [
//         Icon(Icons.edit, size: 24),
//         SizedBox(width: 8),
//         Text(
//           'Write Review',
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 18),
//         ),
//       ],
//     ),
//   ),
// ),