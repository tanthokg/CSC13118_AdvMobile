import 'package:flutter/material.dart';
import 'package:lettutor/src/dummy/dummy_data.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/features/courses/courses/widgets/course_card.dart';
import 'package:lettutor/src/widgets/ebook_card.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.school_outlined,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'All Courses',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.book_online_outlined,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'E-Books',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
            ]),
            Expanded(
              child: TabBarView(children: [
                // Here goes the first tab
                Padding(
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
                      // Expanded(
                      //   child: ListView.separated(
                      //     itemCount: courses.length,
                      //     itemBuilder: (context, index) => CourseCard(
                      //       course: courses[index],
                      //       onTap: ((value) => Navigator.pushNamed(
                      //             context,
                      //             Routes.courseDetail,
                      //           )),
                      //     ),
                      //     separatorBuilder: (BuildContext context, int index) =>
                      //         const SizedBox(height: 8),
                      //   ),
                      // )
                    ],
                  ),
                ),
                // Here goes the second tab
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(right: 24),
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          hintText: 'search e-books',
                          prefixIcon: const Icon(Icons.search),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      // Expanded(
                      //   child: ListView.separated(
                      //     itemCount: ebooks.length,
                      //     itemBuilder: (context, index) => EbookCard(
                      //       ebook: ebooks[index],
                      //     ),
                      //     separatorBuilder: (BuildContext context, int index) =>
                      //     const SizedBox(height: 8),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ]),
            )
          ],
        ));
  }
}
