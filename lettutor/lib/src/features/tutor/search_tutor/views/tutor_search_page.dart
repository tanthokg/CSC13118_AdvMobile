import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/country_list.dart';
import 'package:lettutor/src/dummy/dummy_data.dart';
import 'package:lettutor/src/models/tutor/tutor.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:lettutor/src/services/tutor_service.dart';
import 'package:provider/provider.dart';

import 'tutor_search_result.dart';


class TutorSearchPage extends StatefulWidget {
  const TutorSearchPage({Key? key}) : super(key: key);

  @override
  State<TutorSearchPage> createState() => _TutorSearchPageState();
}

class _TutorSearchPageState extends State<TutorSearchPage> {
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();

  int _chosenSpecialty = 0;
  List<Tutor> _tutors = [];

  Future<void> _searchTutors(AuthProvider authProvider) async {
    final name = _nameController.text;
    final accessToken = authProvider.token?.access?.token as String;
    final List<String> filterSpecialties = [];
    if (_chosenSpecialty != 0) {
      filterSpecialties.add(specialties[_chosenSpecialty].toLowerCase().replaceAll(' ', '-'));
    }

    final result = await TutorService.searchTutor(
      token: accessToken,
      search: name,
      page: 1,
      perPage: 10,
      specialties: filterSpecialties,
    );

    if (_countryController.text.isEmpty) {
      _tutors = result;
    } else {
      _tutors.clear();
      for (var tutor in result) {
        if (countryList[tutor.country] != null) {
          if (countryList[tutor.country]!.toLowerCase().contains(_countryController.text)) {
            _tutors.add(tutor);
          }
        }
      }
    }
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
              // contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              hintStyle: TextStyle(color: Colors.grey[500]),
              hintText: "search by name",
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _countryController,
            decoration: InputDecoration(
              // contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              hintStyle: TextStyle(color: Colors.grey[500]),
              hintText: "search by country",
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          // DropdownButtonFormField(
          //   decoration: InputDecoration(
          //     contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          //     hintText: 'select nationality',
          //     hintStyle: TextStyle(color: Colors.grey[400]),
          //     border: const OutlineInputBorder(
          //       borderSide: BorderSide(color: Colors.grey, width: 2),
          //       borderRadius: BorderRadius.all(Radius.circular(10)),
          //     ),
          //   ),
          //   items: nationalities
          //       .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          //       .toList(),
          //   onChanged: (value) {},
          // ),
          const SizedBox(height: 16),
          Text('Specialties', style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: -4,
            children: List<Widget>.generate(
              specialties.length,
              (index) => ChoiceChip(
                label: Text(
                  specialties[index],
                  style: TextStyle(
                    fontSize: 14,
                    color: _chosenSpecialty == index ? Colors.blue[700] : Colors.black54,
                  ),
                ),
                backgroundColor: Colors.grey[100],
                selectedColor: Colors.lightBlue[100],
                selected: _chosenSpecialty == index,
                onSelected: (bool selected) {
                  setState(() {
                    _chosenSpecialty = index;
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
                    _chosenSpecialty = 0;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text('Reset Filters', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () async {
                  await _searchTutors(authProvider);
                  if (mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TutorSearchResult(tutors: _tutors)),
                    );
                  }
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