import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/items_per_page.dart';
import 'package:lettutor/src/models/course/course.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:lettutor/src/services/course_service.dart';
import 'package:provider/provider.dart';

import '../widgets/course_card.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({Key? key}) : super(key: key);

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  final _searchController = TextEditingController();
  List<Course> courses = [];

  int _page = 1;
  int _perPage = itemsPerPage.first;
  int _count = 0;
  bool _isLoading = true;

  Future<void> _fetchCourses(String token, String search) async {
    final result = await CourseService.getListCourseWithPagination(
      page: _page,
      size: _perPage,
      token: token,
      search: search,
    );

    setState(() {
      courses = result['courses'];
      _count = result['count'];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final String accessToken = authProvider.token?.access?.token as String;
      _fetchCourses(accessToken, _searchController.text);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onSubmitted: (value) {
              setState(() {
                _isLoading = true;
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(right: 24),
              hintStyle: TextStyle(color: Colors.grey[400]),
              hintText: 'search',
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : courses.isEmpty
                    ? _searchController.text.isEmpty
                        ? const Center(
                            child: Text(
                              'There is no course available',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : const Center(
                            child: Text(
                              'No result(s) matches your search',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  flex: 20,
                                  child: Text(
                                    'Items per page',
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                const SizedBox.shrink(),
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
                                      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
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
                            ),
                            ...List<Widget>.generate(
                              courses.length,
                              (index) => CourseCard(course: courses[index]),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
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
                              ],
                            )
                          ],
                        ),
                      ),
          )
        ],
      ),
    );
  }
}
