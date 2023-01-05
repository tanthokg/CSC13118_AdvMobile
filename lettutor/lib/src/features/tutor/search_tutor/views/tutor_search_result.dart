import 'package:flutter/material.dart';
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
  int _currentPage = 1;
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
      page: _currentPage,
      perPage: 10,
      nationality: {'isVietNamese': isVietnamese},
      specialties: specialties,
    );

    print(result);
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
      _searchTutors(data['token'], data['search'], data['nationality'], data['specialties']);
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
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Text(
                      _tutors.isEmpty ? 'No Matches Found' : 'Found $_count result(s)',
                      style: Theme.of(context).textTheme.headline4,
                    ),
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
                                backgroundColor: _currentPage == 1 ? Colors.grey : Colors.blue[300],
                              ),
                              onPressed: _currentPage == 1
                                  ? null
                                  : () {
                                      setState(() {
                                        _isLoading = true;
                                        _currentPage--;
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
                                'Page $_currentPage/${(_count / 10).ceil()}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            IconButton(
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor:
                                    _currentPage == _count ? Colors.grey : Colors.blue[300],
                              ),
                              onPressed: _currentPage == (_count / 10).ceil()
                                  ? null
                                  : () {
                                      setState(() {
                                        _isLoading = true;
                                        _currentPage++;
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
                                backgroundColor: _currentPage == 1 ? Colors.grey : Colors.blue[300],
                              ),
                              onPressed: _currentPage == 1
                                  ? null
                                  : () {
                                      setState(() {
                                        _isLoading = true;
                                        _currentPage--;
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
                                'Page $_currentPage/${(_count / 10).ceil()}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            IconButton(
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor:
                                    _currentPage == _count ? Colors.grey : Colors.blue[300],
                              ),
                              onPressed: _currentPage == (_count / 10).ceil()
                                  ? null
                                  : () {
                                      setState(() {
                                        _isLoading = true;
                                        _currentPage++;
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
