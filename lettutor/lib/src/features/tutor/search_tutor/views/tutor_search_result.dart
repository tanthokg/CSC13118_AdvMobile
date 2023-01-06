import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/items_per_page.dart';
import 'package:lettutor/src/models/tutor/tutor.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:lettutor/src/services/tutor_service.dart';
import 'package:provider/provider.dart';

import '../widgets/tutor_search_card.dart';

class TutorSearchResult extends StatefulWidget {
  const TutorSearchResult({Key? key}) : super(key: key);

  @override
  State<TutorSearchResult> createState() => _TutorSearchResultState();
}

class _TutorSearchResultState extends State<TutorSearchResult> {
  int _page = 1;
  int _perPage = itemsPerPage.first;
  bool _isLoading = true;
  List<Tutor> _tutors = [];
  int _count = 0;

  Future<void> _searchTutors(
    String accessToken,
    String name,
    bool isVietnamese,
    List<String> specialties,
  ) async {
    final result = await TutorService.searchTutor(
      token: accessToken,
      search: name,
      page: _page,
      perPage: _perPage,
      nationality: {'isVietNamese': isVietnamese},
      specialties: specialties,
    );

    setState(() {
      _count = result['count'];
      _tutors = result['tutors'];
      _isLoading = false;
    });

    // if (_countryController.text.isEmpty) {
    //   _tutors = result;
    // } else {
    //   _tutors.clear();
    //   for (var tutor in result) {
    //     if (countryList[tutor.country] != null) {
    //       if (countryList[tutor.country]!.toLowerCase().contains(_countryController.text)) {
    //         _tutors.add(tutor);
    //       }
    //     }
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final data = ModalRoute.of(context)?.settings.arguments as Map;

    if (_isLoading) {
      _searchTutors(
        data['token'],
        data['search'],
        data['nationality'],
        data['specialties'],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _tutors.isEmpty ? 'No Matches Found' : 'Found $_count result(s)',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  _count > 0
                      ? Row(
                          children: [
                            const Expanded(
                              flex: 20,
                              child: Text(
                                'Tutors per page',
                                textAlign: TextAlign.right,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 7,
                              child: DropdownButtonFormField<int>(
                                value: _perPage,
                                items: itemsPerPage
                                    .map((itemPerPage) => DropdownMenuItem<int>(
                                        value: itemPerPage, child: Text('$itemPerPage')))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _perPage = value!;
                                    _page = 1;
                                    _isLoading = true;
                                  });
                                },
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.blue,
                                ),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(Radius.circular(24)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(Radius.circular(24)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 8),
                  ...List<Widget>.generate(
                    _tutors.length,
                    (index) => TutorSearchCard(tutor: _tutors[index]),
                  ),
                  _count > 0
                      ? Row(
                          children: [
                            const SizedBox(width: 16),
                            IconButton(
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: _page == 1 ? Colors.grey : Colors.blue[300],
                              ),
                              onPressed: _page == 1
                                  ? null
                                  : () {
                                      setState(() {
                                        _isLoading = true;
                                        _page--;
                                      });
                                    },
                              icon: const Icon(
                                Icons.navigate_before_rounded,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Page $_page/${(_count / _perPage).ceil()}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            IconButton(
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: _page == _count ? Colors.grey : Colors.blue[300],
                              ),
                              onPressed: _page == (_count / _perPage).ceil()
                                  ? null
                                  : () {
                                      setState(() {
                                        _isLoading = true;
                                        _page++;
                                      });
                                    },
                              icon: const Icon(
                                Icons.navigate_next_rounded,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
    );
  }
}
