import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/country_list.dart';
import 'package:lettutor/src/dummy/dummy_data.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/features/tutor/tutor_detail/tutor_report_dialog.dart';
import 'package:lettutor/src/models/tutor/tutor_feedback.dart';
import 'package:lettutor/src/models/tutor/tutor_info.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:lettutor/src/services/tutor_service.dart';
import 'package:provider/provider.dart';

class TutorDetailView extends StatefulWidget {
  const TutorDetailView({Key? key}) : super(key: key);

  @override
  State<TutorDetailView> createState() => _TutorDetailViewState();
}

class _TutorDetailViewState extends State<TutorDetailView> {
  late TutorInfo _tutorInfo;
  late final List<String> specialties;
  late final List<TutorFeedback> feedbacks;
  late String userId;

  bool _isLoading = true;

  Future<void> _fetchTutorInfo(String token) async {
    final result = await TutorService.getTutorInfoById(
      token: token,
      userId: userId,
    );
    if (_isLoading) {
      specialties = result.specialties?.split(',') ?? ['null'];
    }

    if (mounted) {
      setState(() {
        _tutorInfo = result;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final data = ModalRoute.of(context)?.settings.arguments as Map;
      userId = data['userId'];
      feedbacks = data['tutor'].feedbacks;

      final String accessToken = authProvider.token?.access?.token as String;
      _fetchTutorInfo(accessToken);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          'Teacher Details',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: _tutorInfo.user?.avatar ?? '',
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error_outline_rounded,
                            size: 32,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _tutorInfo.user?.name ?? 'null name',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              countryList[_tutorInfo.user?.country] ?? 'null country',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Row(children: [
                              ...List<Widget>.generate(
                                _tutorInfo.rating?.round() ?? 0,
                                (index) => const Icon(Icons.star, color: Colors.amber),
                              ),
                              const SizedBox(width: 8),
                              Text('(${_tutorInfo.totalFeedback})',
                                  style: const TextStyle(fontSize: 18))
                            ])
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      _tutorInfo.bio ?? 'null bio',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            if (authProvider.token != null) {
                              final String accessToken =
                                  authProvider.token?.access?.token as String;
                              await TutorService.addTutorToFavorite(
                                token: accessToken,
                                userId: userId,
                              );
                              _fetchTutorInfo(accessToken);
                            }
                            // print('IS FAVORITE (DETAIL): ${_tutorInfo.isFavorite}');
                          },
                          child: Column(
                            children: [
                              _tutorInfo.isFavorite!
                                  ? const Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_rounded,
                                      color: Colors.blue,
                                    ),
                              Text(
                                'Favorite',
                                style: TextStyle(
                                  color: _tutorInfo.isFavorite! ? Colors.red : Colors.blue,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              Routes.review,
                              arguments: feedbacks,
                            );
                          },
                          child: Column(
                            children: const [
                              Icon(Icons.reviews_outlined, color: Colors.blue),
                              Text('Reviews', style: TextStyle(color: Colors.blue))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            // await _showReportDialog(context);
                            final result = await showDialog(
                              context: context,
                              builder: (context) => TutorReportDialog(
                                token: authProvider.token?.access?.token ?? '',
                                userId: userId,
                              ),
                            );
                            if (result) {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Report Success'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK')),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Column(
                            children: const [
                              Icon(Icons.report_outlined, color: Colors.blue),
                              Text('Report', style: TextStyle(color: Colors.blue))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    height: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'Introduction Video Goes Here',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Languages', style: Theme.of(context).textTheme.headline3),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Wrap(children: [
                      Chip(
                        label: const Text(
                          'English',
                          style: TextStyle(color: Colors.blue),
                        ),
                        backgroundColor: Colors.blue[50],
                      ),
                    ]),
                  ),
                  const SizedBox(height: 8),
                  Text('Specialties', style: Theme.of(context).textTheme.headline3),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: -4,
                      children: List<Widget>.generate(
                        specialties.length,
                        (index) => Chip(
                          label: Text(
                            specialties[index],
                            style: const TextStyle(color: Colors.blue),
                          ),
                          backgroundColor: Colors.blue[50],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Suggested Courses', style: Theme.of(context).textTheme.headline3),
                  ...courses.map((course) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Text(
                              course.name,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            const SizedBox(width: 16),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.courseDetail);
                                },
                                child: const Text('View'))
                          ],
                        ),
                      )),
                  const SizedBox(height: 12),
                  Text('Interests', style: Theme.of(context).textTheme.headline3),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 8),
                    child: Text(_tutorInfo.interests ?? 'null interests'),
                  ),
                  const SizedBox(height: 12),
                  Text('Teaching Experiences', style: Theme.of(context).textTheme.headline3),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 8),
                    child: Text(_tutorInfo.experience ?? 'null teaching experiences'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 12),
                    child: OutlinedButton(
                      style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(0),
                          padding: const EdgeInsets.all(8),
                          side: const BorderSide(color: Colors.blue, width: 1.5)),
                      onPressed: () async {
                        final selectedDate = await _bookLearningDate(context);
                        if (mounted) {
                          await _bookLearningHour(context, selectedDate!);
                        }
                        // Navigator.pushNamed(context, Routes.booking);
                      },
                      child: const Text(
                        'Book This Tutor',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

Future<DateTime?> _bookLearningDate(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2050),
  );
  return selectedDate ?? DateTime.now();
}

Future<void> _bookLearningHour(BuildContext context, DateTime selectedDate) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    elevation: 5,
    clipBehavior: Clip.hardEdge,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    builder: (context) {
      return SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Choose Your Time',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(24),
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 32,
                  childAspectRatio: 3,
                  children: List<Widget>.generate(
                    courseHours.length,
                    (index) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () async {
                        final dialogResult = await _showBookingConfirmDialog(context);
                        if (dialogResult) {
                          Navigator.of(context).pushNamed(
                            Routes.bookingDetail,
                            arguments: {
                              'selectedDate': selectedDate,
                              'selectedHour': courseHours[index],
                              'weekday': selectedDate.weekday
                            },
                          );
                        }
                      },
                      child: Text(
                        courseHours[index],
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<bool> _showBookingConfirmDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Book Tutor'),
        content: const Text('Are you sure to book this tutor at this time?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('CANCEL')),
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('YES')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
