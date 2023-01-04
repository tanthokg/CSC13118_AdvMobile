import 'package:flutter/material.dart';
import 'package:lettutor/src/models/schedule/booking_info.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:lettutor/src/services/user_service.dart';
import 'package:provider/provider.dart';

import '../widgets/history_card.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  late final List<BookingInfo> history;

  bool _isLoading = true;

  Future<void> _fetchHistory(String token) async {
    final result = await UserService.getHistory(
      token: token,
      page: 1,
      perPage: 20,
    );

    setState(() {
      history = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final String accessToken = authProvider.token?.access?.token as String;
      _fetchHistory(accessToken);
    }

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : history.isEmpty
            ? const Center(
                child: Text('You have not booked any class'),
              )
            : ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) => HistoryCard(
                  bookingInfo: history[index],
                ),
              );
  }
}
