import 'package:flutter/material.dart';
import 'package:lettutor/src/models/tutor/tutor.dart';

import '../widgets/tutor_search_card.dart';

class TutorSearchResult extends StatefulWidget {
  const TutorSearchResult({Key? key, required this.tutors}) : super(key: key);

  final List<Tutor> tutors;

  @override
  State<TutorSearchResult> createState() => _TutorSearchResultState();
}

class _TutorSearchResultState extends State<TutorSearchResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Text(
                widget.tutors.isEmpty ? 'No Matches Found' : 'Found ${widget.tutors.length} result(s)',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ...List<Widget>.generate(
              widget.tutors.length,
              (index) => TutorSearchCard(tutor: widget.tutors[index]),
            )
          ],
        ),
      ),
    );
  }
}
