import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomButton2 extends StatelessWidget {
  final Function onPressed;
  final String text;
  const CustomButton2({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.sizeOf(context).width * 0.90, 50),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: AppColors.bodyTextColor),
      ),
    );
  }
}
