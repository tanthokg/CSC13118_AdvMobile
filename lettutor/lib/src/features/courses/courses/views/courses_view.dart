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
  late final List<Course> courses;

  bool _isLoading = true;

  Future<void> _fetchAllCourses(String token) async {
    final result = await CourseService.getListCourseWithPagination(
      page: 1,
      size: 20,
      token: token,
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
      _fetchAllCourses(accessToken);
    }

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : courses.isEmpty
            ? const Center(
                child: Text(
                  'You have no upcoming class',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(right: 24),
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        hintText: 'search courses',
                        prefixIcon: const Icon(Icons.search),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: courses.length,
                        itemBuilder: (context, index) => CourseCard(course: courses[index]),
                      ),
                    )
                  ],
                ),
              );
  }
}
