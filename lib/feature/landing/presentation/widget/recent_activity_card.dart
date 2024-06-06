import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

class RecentActivityCard extends StatelessWidget {
  final String status;
  final String title;
  final String date;
  final String time;
  Function? onPressed;
  RecentActivityCard(
      {super.key,
      this.onPressed,
      required this.status,
      required this.title,
      required this.time,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) onPressed!();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 4),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: status == "success" ? AppColors.secondaryColor :status == 'pending'? Colors.orange: Colors.red,
        ),
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.97,
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 1)]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/icons/trash.svg'),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.64,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date: $date',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Time: $time',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
