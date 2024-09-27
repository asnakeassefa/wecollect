import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:wecollect/core/utility/theme/theme.dart';
import 'package:wecollect/feature/profile/presentation/bloc/user_bloc.dart';
import 'package:wecollect/feature/profile/presentation/bloc/user_state.dart';
import 'package:wecollect/feature/profile/presentation/screen/edit_profile.dart';

import '../../../../core/dj/injection.dart';
import '../../../auth/presentation/screen/login.dart';
import '../../../reward/presentation/screen/reward_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> _clearUserData() async {
    // Clear any user data you may have stored (e.g., tokens, user info)
    // Example for using secure storage, adjust as needed
  }
  File? _image;
  var isloading = false;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String role = "";
  late BuildContext topContext;
  LatLng? selectedLocation;
  String amPm = 'AM';
  String weightUnit = 'kg';
  bool useCurrentLocation = false;
  LocationData? currentLocation;
  final Completer<GoogleMapController> _controller = Completer();

  Future<void> _pickImage() async {
    // Request permissions
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserCubit>()..getUserProfile(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            'Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<UserCubit, UserState>(listener: (context, state) {
                if (state is UserError && state.message.contains('expired')) {
                  // navigate to login page
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                } else if (state is UserError) {
                  // show error message
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                  ));
                }
                if (state is UserLoaded) {
                  setState(() {
                    _nameController.text = state.user.data?.name ?? "";
                    _emailController.text = state.user.data?.email ?? "";
                    _phoneController.text = state.user.data?.phoneNumber ?? "";
                    role = state.user.data?.role ?? "";
                  });
                }
              }, builder: (context, state) {
                topContext = context;
                if (state is UserLoading) {
                  return const SizedBox(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is UserLoaded) {
                  return Padding(
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
                                backgroundImage: NetworkImage(
                                    state.user.data?.profilePhoto ?? ""),
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
                                    icon: const Icon(
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
                          state.user.data?.name ?? "No user name",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.bodyTextColor.withOpacity(.6),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(state.user.data?.email ?? "email",
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[400])),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                }
                return const SizedBox(
                  height: 100,
                  width: 100,
                );
              }),
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
                onTap: () {
                  // show alert Box to edit profile
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ),
                  );
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, RewardScreen.routeName);
                },
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
                  thumbColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                    if (states.contains(WidgetState.disabled)) {
                      return AppColors.primaryColor.withOpacity(.90);
                    }
                    return AppColors.primaryColor.withOpacity(.90);
                  }),
                  trackColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                    if (states.contains(WidgetState.disabled)) {
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
                onTap: () async {
                  // clear all login information from the secure storage
                  // and go to login screen
                  await _storage.delete(
                    key: 'accessToken',
                  );
                  await _storage.delete(
                    key: 'refreshToken',
                  );
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.routeName, (route) => false);
                },
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
