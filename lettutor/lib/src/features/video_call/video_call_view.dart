import 'package:flutter/material.dart';

class VideoCallView extends StatelessWidget {
  const VideoCallView({Key? key, required this.startTimestamp}) : super(key: key);

  final int startTimestamp;

  String _countWaitingTime() {


    return '${DateTime.fromMillisecondsSinceEpoch(startTimestamp).difference(DateTime.now()).inMinutes} minute(s)';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Lesson is starting in\n${_countWaitingTime()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.white60),
                ),
              ),
            ),
            Row(
              children: const [
                Expanded(child: Icon(Icons.mic_rounded, color: Colors.white60,)),
                Expanded(child: Icon(Icons.video_call, color: Colors.white60,)),
                Expanded(child: Icon(Icons.comment, color: Colors.white60,)),
                Expanded(child: Icon(Icons.mobile_screen_share, color: Colors.white60,)),
                Expanded(child: Icon(Icons.front_hand, color: Colors.white60,)),
                Expanded(child: Icon(Icons.fullscreen_outlined, color: Colors.white60,)),
                Expanded(child: Icon(Icons.phone, color: Colors.red,)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
