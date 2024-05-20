import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

import '../../../landing/presentation/widget/recent_activity_card.dart';
import '../bloc/request_bloc.dart';
import '../bloc/request_state.dart';

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
        date: '2024-12-12',
        time: '12:00 AM',
        title: "Plastic Collected",
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
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DetailNote(
                      text1: 'Date and Time: ',
                      child: Text(' April 10 , 2024, 10:43 AM',
                          style: TextStyle(fontSize: 18)),
                    ),
                    const DetailNote(
                      text1: 'Agent Name: ',
                      child: Text(' John Doe', style: TextStyle(fontSize: 18)),
                    ),
                    const DetailNote(
                      text1: 'Reedamble Points: ',
                      child: Text(' +10', style: TextStyle(fontSize: 18)),
                    ),
                    DetailNote(
                      text1: 'Status: ',
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('Completed',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const DetailNote(
                      text1: 'Environmental Impact: ',
                      child: Column(
                        children: [
                          Text('Plastic Collection: 10kg',
                              style: TextStyle(fontSize: 18)),
                          SizedBox(height: 24),
                          Text('CO2 Emissions Reduced: 5kg',
                              style: TextStyle(fontSize: 18)),
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
      // RecentActivityCard(isCompleted: false),
      RecentActivityCard(
        isCompleted: true,
        date: '2024-12-12',
        time: '12:00 AM',
        title: "Plastic Collected",
      ),
      RecentActivityCard(
        isCompleted: true,
        date: '2024-12-12',
        time: '12:00 AM',
        title: "Plastic Collected",
      ),
      RecentActivityCard(
        isCompleted: true,
        date: '2024-12-12',
        time: '12:00 AM',
        title: "Plastic Collected",
      ),
    ];
    return BlocConsumer<RequestCubit, RequestState>(
      listener: (context, state) {
        if (state is RequestError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is RequestLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RequestLoaded) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Text(
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
        return Container();
      },
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
      margin: const EdgeInsets.symmetric(vertical: 10),
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
