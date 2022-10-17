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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Find a tutor', style: Theme.of(context).textTheme.headline3),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                hintStyle: TextStyle(color: Colors.grey[400]),
                hintText: "enter tutor name",
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                hintStyle: TextStyle(color: Colors.grey[400]),
                hintText: "select nationality",
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Select available tutoring time:',
                style: Theme.of(context).textTheme.headline4),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: 160,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  hintText: "select a day",
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      hintText: "start time",
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 120,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      hintText: "end time",
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
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
              child: const Text('Reset Filters', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
