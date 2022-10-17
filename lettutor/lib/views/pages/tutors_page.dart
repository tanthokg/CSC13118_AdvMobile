import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy_data.dart';
import 'package:lettutor/widgets/select_date.dart';

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
          SelectDate(setDate: (date) {
            setState(() {});
          }),
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
            padding: const EdgeInsets.only(top: 16),
            child: Text('Specialties', style: Theme.of(context).textTheme.headline4),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    chosenFilter = 0;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text('Reset Filters', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () {},
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Search',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
