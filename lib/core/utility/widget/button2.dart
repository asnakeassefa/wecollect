import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomButton2 extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double? width;
  final bool? isDisabled;
  final bool? isLoading;
  const CustomButton2({super.key, required this.onPressed, required this.text, this.width, this.isDisabled, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if(isDisabled != null && isDisabled!) return;
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        
        minimumSize:width != null ? Size(width!, 50) : Size(MediaQuery.sizeOf(context).width * 0.90, 50),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: isDisabled != null && isDisabled! ? Colors.grey : AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: isLoading == true? const Center(child:CircularProgressIndicator()) :Text(
        text,
        style: TextStyle(color: isDisabled != null && isDisabled! ? Colors.grey : AppColors.bodyTextColor),
      ),
    );
  }
}
