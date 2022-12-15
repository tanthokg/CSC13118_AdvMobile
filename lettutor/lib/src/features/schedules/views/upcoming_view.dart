import 'package:flutter/material.dart';
import 'package:lettutor/src/features/schedules/widgets/upcoming_card.dart';
import 'package:lettutor/src/models/schedule/booking_info.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:lettutor/src/services/user_service.dart';
import 'package:provider/provider.dart';

class UpcomingView extends StatefulWidget {
  const UpcomingView({Key? key}) : super(key: key);

  @override
  State<UpcomingView> createState() => _UpcomingClassViewState();
}

class _UpcomingClassViewState extends State<UpcomingView> {
  late final List<BookingInfo> upcoming;

  bool _isLoading = true;

  Future<void> _fetchUpcomingClasses(String token) async {
    final result = await UserService.getUpcomingClasses(
      token: token,
      page: 1,
      perPage: 10,
    );

    setState(() {
      upcoming = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final String accessToken = authProvider.token?.access?.token as String;
      _fetchUpcomingClasses(accessToken);
    }

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : upcoming.isEmpty
            ? const Center(
                child: Text(
                  'You have no upcoming class',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
              itemCount: upcoming.length,
              itemBuilder: (context, index) => UpcomingClassCard(
                bookingInfo: upcoming[index],
              ),
            );
  }
}
