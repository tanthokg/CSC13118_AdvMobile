import 'package:flutter/material.dart';
import 'package:lettutor/src/dummy/dummy_data.dart';
import 'package:lettutor/src/models/tutor/tutor.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:lettutor/src/services/tutor_service.dart';
import 'package:provider/provider.dart';

class TutorsPage extends StatefulWidget {
  const TutorsPage({Key? key}) : super(key: key);

  @override
  State<TutorsPage> createState() => _TutorsPageState();
}

class _TutorsPageState extends State<TutorsPage> {
  final _nameController = TextEditingController();

  int chosenFilter = 0;
  List<Tutor> _tutors = [];

  void _searchTutors(AuthProvider authProvider) async {
    final name = _nameController.text;
    final accessToken = authProvider.token?.access?.token as String;

    _tutors = await TutorService.searchTutor(
      page: 1,
      perPage: 20,
      token: accessToken,
      search: name,
    );

    print(_tutors.length);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Find a tutor', style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              hintStyle: TextStyle(color: Colors.grey[400]),
              hintText: "enter tutor name",
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              hintText: 'select nationality',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            items: nationalities
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          Text('Specialties', style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: -4,
            children: List<Widget>.generate(
              filters.length,
              (index) => ChoiceChip(
                label: Text(
                  filters[index],
                  style: TextStyle(
                    fontSize: 14,
                    color: chosenFilter == index ? Colors.blue[700] : Colors.black54,
                  ),
                ),
                backgroundColor: Colors.grey[100],
                selectedColor: Colors.lightBlue[100],
                selected: chosenFilter == index,
                onSelected: (bool selected) {
                  setState(() {
                    chosenFilter = index;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
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
                onPressed: () {
                  _searchTutors(authProvider);
                },
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
