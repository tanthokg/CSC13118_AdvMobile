import 'package:flutter/material.dart';
import 'package:lettutor/src/services/tutor_service.dart';

class TutorReportDialog extends StatefulWidget {
  const TutorReportDialog({
    Key? key,
    required this.token,
    required this.userId,
  }) : super(key: key);

  final String token;
  final String userId;

  @override
  State<TutorReportDialog> createState() => _TutorReportDialogState();
}

class _TutorReportDialogState extends State<TutorReportDialog> {
  final _controller = TextEditingController();
  final List<bool> _choices = [false, false, false];
  final List<String> _contents = [
    'Inappropriate profile photo\n',
    'This profile is pretending be someone or is fake\n',
    'This tutor is annoying me\n',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Report Tutor'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Help us understand what's happening",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ...List<Widget>.generate(_choices.length, (index) {
            return Row(
              children: [
                Checkbox(
                  value: _choices[index],
                  onChanged: (value) {
                    setState(() {
                      _choices[index] = value!;
                    });
                  },
                ),
                Expanded(child: Text(_contents[index])),
              ],
            );
          }),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            minLines: 4,
            maxLines: 5,
            onChanged: (value) {
              setState(() {});
            },
            decoration: const InputDecoration(
              hintText: 'Please let us know details about your problems',
              hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
            ),
          ),
        ],
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
          onPressed: _choices.contains(true) || _controller.text.isNotEmpty
              ? () async {
                  String content = '';
                  for (int i = 0; i < _choices.length; ++i) {
                    if (_choices[i]) content += _contents[i];
                  }

                  await TutorService.reportTutor(
                    token: widget.token,
                    userId: widget.userId,
                    content: content,
                  );
                  if (mounted) {
                    Navigator.pop(context, true);
                  }
                }
              : null,
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
