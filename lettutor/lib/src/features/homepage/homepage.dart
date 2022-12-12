import 'package:flutter/material.dart';
import 'package:lettutor/src/dummy/dummy_data.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/features/homepage/homepage_banner.dart';
import 'package:lettutor/src/models/tutor/tutor.dart';
import 'package:lettutor/src/models/tutor/tutor_info.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:lettutor/src/services/tutor_service.dart';
import 'package:lettutor/src/widgets/tutor_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tutor> _tutors = [];
  List<TutorInfo> _infos = [];
  bool _isLoading = true;

  Future<void> _fetchRecommendedTutors(String token) async {
    _tutors = await TutorService.getListTutorWithPagination(
      page: 1,
      perPage: 3,
      token: token,
    );

    for (var tutor in _tutors) {
      final info = await TutorService.getTutorInfoById(token: token, userId: tutor.userId!);
      _infos.add(info);
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final String accessToken = authProvider.token?.access?.token as String;
      _fetchRecommendedTutors(accessToken);
    }

    return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomepageBanner(),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Recommended Tutors',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                _isLoading ? const Center(child: CircularProgressIndicator()) :
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _tutors.length,
                  itemBuilder: (context, index) {
                    return TutorCard(tutor: _tutors[index]);
                  },
                )
              ],
            ),
          );
  }
}
