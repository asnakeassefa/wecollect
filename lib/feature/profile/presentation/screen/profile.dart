import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/ava-character.png'),
                      radius: 65,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 20,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Yohn Doi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.bodyTextColor.withOpacity(.6),
                ),
              ),
              const SizedBox(height: 10),
              Text('johndoi@example.com',
                  style: TextStyle(fontSize: 18, color: Colors.grey[400])),
              const SizedBox(height: 24),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primaryColor.withOpacity(.1),
                  child: Icon(
                    Icons.edit_sharp,
                    color: AppColors.primaryColor,
                  ),
                ),
                title: const Text('Edit Profile'),
                subtitle: const Text('Change your profile details',
                    style: TextStyle(color: Colors.grey)),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primaryColor.withOpacity(.1),
                  child: Icon(
                    Icons.emoji_events,
                    color: AppColors.primaryColor,
                  ),
                ),
                title: const Text('Rewards & Redemption'),
                subtitle: const Text('manage your rewards',
                    style: TextStyle(color: Colors.grey)),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primaryColor.withOpacity(.1),
                  child: Icon(
                    Icons.location_on,
                    color: AppColors.primaryColor,
                  ),
                ),
                title: const Text('Location'),
                subtitle: const Text('Manage your device location',
                    style: TextStyle(color: Colors.grey)),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {
                    // setState(() {
                    //   useCurrentLocation = value;
                    // });
                  },
                  // inactiveThumbColor: AppColors.primaryColor,
                  // activeColor: AppColors.primaryColor,
                  thumbColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return AppColors.primaryColor.withOpacity(.90);
                    }
                    return AppColors.primaryColor.withOpacity(.90);
                  }),
                  trackColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return AppColors.primaryColor.withOpacity(.1);
                    }
                    return AppColors.primaryColor.withOpacity(.3);
                  }),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primaryColor.withOpacity(.1),
                  child: Icon(
                    Icons.logout_sharp,
                    color: AppColors.primaryColor,
                  ),
                ),
                title: const Text('Logout'),
                subtitle: const Text('Further secure your account for safety',
                    style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}