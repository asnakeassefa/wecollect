import 'package:flutter/material.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

import '../../../landing/presentation/widget/recent_activity_card.dart';
import '../../../track/presentation/screen/track.dart';

class PickUpHistory extends StatefulWidget {
  const PickUpHistory({super.key});

  @override
  State<PickUpHistory> createState() => _PickUpHistoryState();
}

class _PickUpHistoryState extends State<PickUpHistory> {
  @override
  Widget build(BuildContext context) {
    List<Widget> recentActivities = [
      RecentActivityCard(
        isCompleted: true,
        onPressed: () {
          // Show the bottom sheet
          showModalBottomSheet(
            showDragHandle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            isScrollControlled: true,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailNote(
                      text1: 'Date and Time: ',
                      child: Text(' April 10 , 2024, 10:43 AM',
                          style: const TextStyle(fontSize: 18)),
                    ),
                    DetailNote(
                      text1: 'Agent Name: ',
                      child: Text(' John Doe',
                          style: const TextStyle(fontSize: 18)),
                    ),
                    DetailNote(
                      text1: 'Reedamble Points: ',
                      child: Text(' +10', style: const TextStyle(fontSize: 18)),
                    ),
                    DetailNote(
                      text1: 'Status: ',
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Text('Completed',
                            style: const TextStyle(fontSize: 18)),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const DetailNote(
                      text1: 'Environmental Impact: ',
                      child: Column(
                        children: [
                          Text('Plastic Collection: 10kg',
                              style: const TextStyle(fontSize: 18)),
                          SizedBox(height: 24),
                          Text('CO2 Emissions Reduced: 5kg',
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                    DetailNote(
                      text1: 'Feedback and Rating: ',
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [1, 2, 3, 4, 5]
                                .map((e) => Icon(Icons.star,
                                    color: e < 4 ? Colors.amber : Colors.grey))
                                .toList(),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            child: const Text(
                              '"Efficient service, prompt pickup, and friendly agent! Highly recommend this app for hassle-free plastic waste collection. Keep up the excellent work!"',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      RecentActivityCard(isCompleted: false),
      RecentActivityCard(isCompleted: true),
      RecentActivityCard(isCompleted: false),
      RecentActivityCard(isCompleted: true),
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              'Pick Up History',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Column(
              children: recentActivities.map((recentActivityCard) {
                return recentActivityCard;
              }).toList(),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}

class DetailNote extends StatelessWidget {
  final String text1;
  final Widget child;
  const DetailNote({
    super.key,
    required this.text1,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        children: [
          Text(
            text1,
            style: TextStyle(color: AppColors.secondaryColor, fontSize: 18),
          ),
          child,
        ],
      ),
    );
  }
}
