import 'package:flutter/material.dart';

class VideoCallView extends StatefulWidget {
  const VideoCallView({Key? key}) : super(key: key);

  @override
  State<VideoCallView> createState() => _VideoCallViewState();
}

class _VideoCallViewState extends State<VideoCallView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'Lesson is starting in\n00:15:44',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white60),
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
    );
  }
}
