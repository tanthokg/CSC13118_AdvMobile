import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/course_levels.dart';
import 'package:lettutor/src/dummy/dummy_data.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/features/courses/courses/widgets/topic_card.dart';
import 'package:lettutor/src/models/course/course.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:lettutor/src/services/course_service.dart';
import 'package:provider/provider.dart';

class CourseDetailView extends StatefulWidget {
  const CourseDetailView({
    Key? key,
  }) : super(key: key);

  @override
  State<CourseDetailView> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetailView> {
  late final String courseId;
  late final Course courseDetail;

  bool _isLoading = true;

  Future<void> _fetchCourseDetail(String token) async {
    final result = await CourseService.getCourseDetailById(
      token: token,
      courseId: courseId,
    );

    setState(() {
      courseDetail = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      courseId = ModalRoute.of(context)!.settings.arguments as String;
      final String accessToken = authProvider.token?.access?.token as String;
      _fetchCourseDetail(accessToken);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          'Course Detail',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: courseDetail.imageUrl ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Icon(
                      Icons.image_rounded,
                      size: 48,
                      color: Colors.grey,
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error_outline_rounded,
                      size: 32,
                      color: Colors.redAccent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      courseDetail.name ?? 'null course name',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      courseDetail.description ?? 'null description',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16),
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     style: TextButton.styleFrom(
                  //       minimumSize: const Size.fromHeight(44),
                  //       backgroundColor: Colors.blue,
                  //     ),
                  //     child: const Text(
                  //       'Discover',
                  //       style: TextStyle(fontSize: 18, color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Overview',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.help_outline, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          'Why Take This Course?',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48, right: 16),
                    child: Text(
                        courseDetail.reason ?? 'null. There is no reason to study this course'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.help_outline, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          'What will you be able to do?',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48, right: 16),
                    child: Text(courseDetail.purpose ?? 'null. This course is useless apparently'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Text(
                      'Experience Level',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.group_add_outlined, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          courseLevels[courseDetail.level ?? '0'] ?? 'null. Possibly for gods only',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Text(
                      'Course Length',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.book_outlined, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          '${courseDetail.topics!.length} Topics',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Text(
                      'List Of Topics',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  ...List<Widget>.generate(
                    courseDetail.topics?.length ?? 0,
                    (index) => TopicCard(
                      index: index,
                      topic: courseDetail.topics![index],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  //   child: Text(
                  //     'Suggested Tutors',
                  //     style: Theme.of(context).textTheme.headline3,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 32),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Keegan',
                  //         style: Theme.of(context).textTheme.headline4,
                  //       ),
                  //       const SizedBox(width: 16),
                  //       TextButton(
                  //           onPressed: () {
                  //             Navigator.pushNamed(context, Routes.teacherDetail);
                  //           },
                  //           child: const Text('More Info'))
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
    );
  }
}
