import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wecollect/core/utility/theme/theme.dart';
import 'package:wecollect/feature/notification/presentation/screen/notification.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Widget> recentActivities = [
    // RecentActivityCard(isCompleted: true),
    // RecentActivityCard(isCompleted: false),
    // RecentActivityCard(isCompleted: true),
    // RecentActivityCard(isCompleted: false),
    // RecentActivityCard(isCompleted: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.sizeOf(context).height * 0.16,
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      height: MediaQuery.sizeOf(context).height * 0.16,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/dashboard.png'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.45,
                          child: const Text(
                            'Total redeemable points',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '240',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // map
              const Text('Your location'),
              const SizedBox(height: 16),

              Container(
                height: MediaQuery.sizeOf(context).height * 0.3,
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[100],
                ),
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(51.5, -0.09),
                        zoom: 11.0,
                      ),
                      markers: {
                        const Marker(
                            markerId: MarkerId('sourceLocation'),
                            icon: BitmapDescriptor.defaultMarker,
                            position: LatLng(51.5, -0.09))
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Recent Activities',
                style: TextStyle(color: AppColors.secondaryColor, fontSize: 16),
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
      ),
    );
  }
}
