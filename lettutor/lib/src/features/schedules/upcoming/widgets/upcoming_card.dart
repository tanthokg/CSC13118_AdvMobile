import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/features/video_call/video_call_view.dart';
import 'package:lettutor/src/models/schedule/booking_info.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:lettutor/src/services/booking_service.dart';
import 'package:provider/provider.dart';

class UpcomingClassCard extends StatelessWidget {
  const UpcomingClassCard({Key? key, required this.bookingInfo, required this.onCancel}) : super(key: key);

  final BookingInfo bookingInfo;
  final Function(bool cancelResult) onCancel;

  String _convertClassTime() {
    String result = '';
    result += DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
        bookingInfo.scheduleDetailInfo!.startPeriodTimestamp ?? 0));
    result += ' - ';
    result += DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
        bookingInfo.scheduleDetailInfo!.endPeriodTimestamp ?? 0));
    return result;
  }

  Future<String> _handleCancelClass(String token) async {
    final result = await BookingService.cancelBookedClass(
      scheduleDetailIds: [bookingInfo.id ?? ''],
      token: token,
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String accessToken = authProvider.token?.access?.token as String;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      surfaceTintColor: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
        child: Column(
          children: [
            Row(
              children: [
                // const CircleAvatar(
                //   backgroundImage: AssetImage('assets/tutor/keegan-avatar.png'),
                //   radius: 32,
                // ),
                Container(
                  width: 72,
                  height: 72,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: bookingInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.avatar ?? '',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error_outline_rounded,
                      size: 32,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookingInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.name ??
                            'null name',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(
                            bookingInfo.scheduleDetailInfo!.startPeriodTimestamp ?? 0)),
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _convertClassTime(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final dialogResult = await showEditRequestDialog(context);
                  },
                  icon: Icon(
                    Icons.edit_note_outlined,
                    size: 32,
                    color: Colors.blue[700],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    onPressed: () async {
                      final dialogResult = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Cancel class'),
                          content: const Text('Are you sure to cancel this class?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('NO'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('YES'),
                            ),
                          ],
                        ),
                      );
                      if (dialogResult) {
                        final result = await _handleCancelClass(accessToken);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text(result),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if (result == "Class Cancelled Successfully") {
                                    onCancel(true);
                                  }
                                  Navigator.pop(context, false);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            final start = bookingInfo.scheduleDetailInfo!.startPeriodTimestamp!;
                            return VideoCallView(startTimestamp: start);
                          },
                        ),
                      );
                    },
                    child: const Text(
                      'Go to meeting',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<bool> showEditRequestDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Requests For Lesson'),
        content: TextField(
          minLines: 2,
          maxLines: 4,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10))),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
