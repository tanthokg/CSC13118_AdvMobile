import 'package:flutter/material.dart';

class WriteReviewView extends StatefulWidget {
  const WriteReviewView({Key? key}) : super(key: key);

  @override
  State<WriteReviewView> createState() => _WriteReviewViewState();
}

class _WriteReviewViewState extends State<WriteReviewView> {
  int rate = 5;

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
          'Write Review',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate This Tutor',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(
                  5,
                  (index) => InkWell(
                    onTap: () {
                      setState(() {
                        rate = index + 1;
                      });
                    },
                    child: Icon(
                      Icons.star,
                      color: index < rate ? Colors.amber : Colors.grey,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Write Your Review',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 8),
            TextField(
              minLines: 5,
              maxLines: 10,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    backgroundColor: Colors.blue),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'Send',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.send, color: Colors.white, size: 24),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
