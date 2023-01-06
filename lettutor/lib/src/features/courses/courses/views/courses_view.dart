import 'package:flutter/material.dart';
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

  bool _isLoading = true;

  Future<void> _fetchCourses(String token, String search) async {
    final result = await CourseService.getListCourseWithPagination(
      page: 1,
      size: 20,
      token: token,
      search: search,
    );

    setState(() {
      courses = result;
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
          const SizedBox(height: 8),
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
                    : ListView.builder(
                        itemCount: courses.length,
                        itemBuilder: (context, index) => CourseCard(
                          course: courses[index],
                        ),
                      ),
          )
        ],
      ),
    );
  }
}
