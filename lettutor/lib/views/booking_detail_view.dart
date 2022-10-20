import 'package:flutter/material.dart';

class BookingDetailView extends StatelessWidget {
  const BookingDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          'Booking Details',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Center(
        child: Text('${data['selectedDate']} ${data['selectedHour']}'),
      ),
    );
  }
}
