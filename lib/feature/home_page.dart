import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

import 'Edu/presentation/screen/edu.dart';
import 'landing/presentation/screen/agent_dashboard.dart';
import 'pickup_request/presentation/screen/pickup_home.dart';
import 'profile/presentation/screen/profile.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key, this.title});

  final String? title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();

  final List<Widget> bottomBarPages = [
    const AgentDashBoard(),
    const PickUpHome(),
    const Education(),
    const ProfilePage(),
  ];

  int selected = 0;
  var heart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: StylishBottomBar(
        elevation: 15,
        // backgroundColor: const Color(0xff2195F3),
        option: AnimatedBarOptions(
          // iconSize: 32,
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.simple,
          // opacity: 0.3,
        ),
        items: [
          BottomBarItem(
            icon: BottomIcon(
              imageName: 'assets/icons/home.svg',
              color: AppColors.primaryColor,
              text: 'Home',
            ),
            selectedIcon: BottomIcon(
              color: AppColors.primaryColor,
              imageName: 'assets/icons/home_f.svg',
              text: 'Home',
            ),
            selectedColor: Colors.white,
            unSelectedColor: const Color(0xffd4d4d8),
            // backgroundColor: Colors.orange,
            title: const Text('Quize'),
          ),
          BottomBarItem(
              icon: BottomIcon(
                imageName: 'assets/icons/press.svg',
                color: AppColors.primaryColor,
                text: 'Job',
              ),
              selectedIcon: BottomIcon(
                color: AppColors.primaryColor,
                imageName: 'assets/icons/press_f.svg',
                text: 'Job',
              ),
              // backgroundColor: Colors.,
              selectedColor: Colors.white,
              unSelectedColor: const Color(0xffd4d4d8),
              title: const Text('Jobs')),
          BottomBarItem(
              icon: BottomIcon(
                imageName: 'assets/icons/document.svg',
                color: AppColors.primaryColor,
                text: 'Alert',
              ),
              selectedIcon: BottomIcon(
                color: AppColors.primaryColor,
                imageName: 'assets/icons/document_f.svg',
                text: 'Alert',
              ),
              // backgroundColor: Colors.,
              selectedColor: Colors.white,
              unSelectedColor: const Color(0xffd4d4d8),
              title: const Text('Alert')),
          BottomBarItem(
            icon: BottomIcon(
              imageName: 'assets/icons/profile.svg',
              color: AppColors.primaryColor,
              text: 'Profile',
            ),
            selectedIcon: BottomIcon(
              color: AppColors.primaryColor,
              imageName: 'assets/icons/profile_f.svg',
              text: 'Profile',
            ),
            selectedColor: Colors.white,
            unSelectedColor: const Color(0xffd4d4d8),
            // backgroundColor: Color(0xffd4d4d8),
            title: const Text(
              'Pofile',
              style: TextStyle(color: Colors.white),
            ),
            // badge: const Text('9+'),
            // showBadge: true,
          ),
        ],
        hasNotch: true,
        // fabLocation: StylishBarFabLocation.center,
        currentIndex: selected ?? 0,
        onTap: (index) {
          pageController.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),
    );
  }
}

class BottomIcon extends StatelessWidget {
  final String text;
  final String imageName;
  final Color color;
  const BottomIcon({
    super.key,
    required this.text,
    required this.imageName,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            imageName,
            color: color,
            height: 26,
            width: 26,
          ),
          // Text(
          //   text,
          //   style: TextStyle(fontSize: 15, color: color),
          // )
        ],
      ),
    );
  }
}
