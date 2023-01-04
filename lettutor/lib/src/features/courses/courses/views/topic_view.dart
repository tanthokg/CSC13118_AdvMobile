import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TopicView extends StatelessWidget {
  const TopicView({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: SfPdfViewer.network(url),
    );
  }
}
