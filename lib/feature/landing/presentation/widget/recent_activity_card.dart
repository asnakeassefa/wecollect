import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

class RecentActivityCard extends StatelessWidget {
  final bool isCompleted;
  const RecentActivityCard({super.key, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(left: 4),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isCompleted ? AppColors.secondaryColor : Colors.red,
        ),
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.97,
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/icons/trash.svg'),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Garbage Collected",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.64,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date: 02/03/2023",
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          'Time: 12:00 PM',
                          style: TextStyle(fontSize: 13),
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