import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/dj/injection.dart';
import '../../../../core/utility/theme/theme.dart';
import '../../../notification/presentation/screen/notification.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_state.dart';
import '../widget/recent_activity_card.dart';

class AgentDashBoard extends StatefulWidget {
  const AgentDashBoard({super.key});

  @override
  State<AgentDashBoard> createState() => _AgentDashBoardState();
}

class _AgentDashBoardState extends State<AgentDashBoard> {
  // List<Widget> recentActivities = [
  //   RecentActivityCard(isCompleted: true),
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardCubit>()..getDashboard(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          title: Row(
            children: [
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(Icons.menu),
              // ),
              const SizedBox(width: 20),
              const CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage('assets/images/meron.jpg'),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    'Meron',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const NotificationPage();
                    }));
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: AppColors.secondaryColor,
                    size: 33,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(top: 7),
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffc32c37),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Center(
                        child: Text(
                          1.toString(),
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: BlocConsumer<DashboardCubit, DashboardState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DashboardLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReportCard(
                            boxDecoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                            icon: 'assets/icons/coins.svg',
                            title: 'Redeemable Points',
                            value: state.statistics['point'] ?? "0",
                          ),
                          ReportCard(
                            boxDecoration: BoxDecoration(
                                color: AppColors.secondaryColor,
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            icon: 'assets/icons/carbon.svg',
                            title: 'CO2 Reduced',
                            value: "${state.statistics['carbon']} KG" ?? "0KG",
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReportCard(
                            boxDecoration: BoxDecoration(
                                color: AppColors.secondaryColor,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                            icon: 'assets/icons/weight.svg',
                            title: 'Weight Collected',
                            value: '${state.statistics['weight']} KG' ?? "0KG",
                          ),
                          ReportCard(
                            boxDecoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            icon: 'assets/icons/recycle.svg',
                            title: 'Recycled Plastics',
                            value: "${state.statistics['recycled']} KG" ?? "0 KG",
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Recent Activities',
                        style: TextStyle(
                            color: AppColors.secondaryColor, fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      Column(
                        children:
                            state.recentActivity.map((recentActivityCard) {
                          return RecentActivityCard(
                            date: recentActivityCard['date'] ?? "",
                            title: recentActivityCard['title'] ?? "",
                            time: recentActivityCard['time'] ?? "",
                            isCompleted:
                                recentActivityCard['status'] == 'success',
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReportCard(
                          boxDecoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          icon: 'assets/icons/coins.svg',
                          title: 'Redeemable Points',
                          value: '200',
                        ),
                        ReportCard(
                          boxDecoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          icon: 'assets/icons/carbon.svg',
                          title: 'CO2 Reduced',
                          value: '1.2KG',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReportCard(
                          boxDecoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          icon: 'assets/icons/weight.svg',
                          title: 'Weight Collected',
                          value: '2000KG',
                        ),
                        ReportCard(
                          boxDecoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          icon: 'assets/icons/recycle.svg',
                          title: 'Recycled Plastics',
                          value: '10000',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Recent Activities',
                      style: TextStyle(
                          color: AppColors.secondaryColor, fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    // Column(
                    //   children: recentActivities.map((recentActivityCard) {
                    //     return recentActivityCard;
                    //   }).toList(),
                    // ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final BoxDecoration boxDecoration;
  final String icon;
  final String title;
  final String value;
  const ReportCard({
    super.key,
    required this.boxDecoration,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration,
      height: 160,
      width: MediaQuery.sizeOf(context).width * .42,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: SvgPicture.asset(
                height: 25,
                width: 25,
                color: AppColors.primaryColor,
                icon,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
