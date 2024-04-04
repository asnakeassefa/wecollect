import 'package:flutter/material.dart';

class PickUpHistory extends StatefulWidget {
  const PickUpHistory({super.key});

  @override
  State<PickUpHistory> createState() => _PickUpHistoryState();
}

class _PickUpHistoryState extends State<PickUpHistory> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              'Pick Up History',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'No Pick Up History',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
