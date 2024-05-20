import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool? isLoading;
  const CustomButton(
      {super.key, required this.onPressed, required this.text, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (isLoading == false || isLoading == null) {
          onPressed();
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.sizeOf(context).width * 0.90, 50),
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
    );
  }
}
