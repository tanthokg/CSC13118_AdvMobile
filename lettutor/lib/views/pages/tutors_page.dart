import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy_data.dart';

class TutorsPage extends StatefulWidget {
  const TutorsPage({Key? key}) : super(key: key);

  @override
  State<TutorsPage> createState() => _TutorsPageState();
}

class _TutorsPageState extends State<TutorsPage> {
  int chosenFilter = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
            child: Text('Find a tutor', style: Theme.of(context).textTheme.headline3),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Row(
              children: const [
                SizedBox(width: 170, child: TextField()),
                SizedBox(width: 20),
                SizedBox(width: 170, child: TextField()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
            child: Text('Select available tutoring time:',
                style: Theme.of(context).textTheme.headline4),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Row(
              children: const [
                SizedBox(width: 140, child: TextField()),
                SizedBox(width: 20),
                SizedBox(width: 200, child: TextField()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Wrap(
              spacing: 4,
              runSpacing: -6,
              children: List<Widget>.generate(
                filters.length,
                    (index) => ChoiceChip(
                  label: Text(
                    filters[index],
                    style: TextStyle(
                      fontSize: 14,
                      color: chosenFilter == index ? Colors.blue : Colors.black54,
                    ),
                  ),
                  selectedColor: Colors.lightBlue[50],
                  selected: chosenFilter == index,
                  onSelected: (bool selected) {
                    setState(() {
                      chosenFilter = index;
                    });
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  chosenFilter = 0;
                });
              },
              child: const Text('Reset Filters'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
