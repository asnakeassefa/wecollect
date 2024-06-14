import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wecollect/core/utility/theme/theme.dart';
import 'package:wecollect/core/utility/widget/button.dart';
import 'package:wecollect/core/utility/widget/button2.dart';
import 'package:wecollect/feature/profile/presentation/bloc/user_bloc.dart';
import 'package:wecollect/feature/profile/presentation/bloc/user_state.dart';

import '../../../../core/dj/injection.dart';
import '../../../auth/presentation/screen/login.dart';
import '../../../reward/presentation/screen/reward_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FlutterSecureStorage _storage = FlutterSecureStorage();

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
                if (state is UserError && state.message.contains('token')) {
                  // navigate to login page
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
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
                  return SizedBox(
                    height: 300,
                    child: const Center(
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

                  if (_nameController.text.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Edit Profile'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  controller: _nameController,
                                  decoration:
                                      const InputDecoration(labelText: 'Name'),
                                ),
                                TextField(
                                  controller: _emailController,
                                  decoration:
                                      const InputDecoration(labelText: 'Email'),
                                ),
                                TextField(
                                  controller: _phoneController,
                                  decoration: const InputDecoration(
                                      labelText: 'Phone Number'),
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: _pickImage,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: _image != null
                                        ? FileImage(_image!)
                                        : null,
                                    child: _image == null
                                        ? const Icon(Icons.camera_alt, size: 40)
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            CustomButton(
                              onPressed: () {
                                final userCubit = topContext.read<UserCubit>();
                                userCubit.updateUserProfile({
                                  'name': _nameController.text,
                                  'email': _emailController.text,
                                  'phone': _phoneController.text,
                                  'role': role,
                                  'profile_photo': _image != null
                                      ? _image!.path
                                      : 'https://via.placeholder.com/150',
                                });
                                userCubit.stream.listen((state) {
                                  if (state is UserLoaded) {
                                    Navigator.pop(context);
                                  }
                                  if (state is UserLoading){
                                    setState(() {
                                      isloading = true;
                                    });
                                  }
                                }); 
                              },
                              isLoading: isloading,
                              text: "Save",
                            ),
                            SizedBox(height: 10),
                            CustomButton2(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                text: "Cancel")
                          ],
                        );
                      },
                    );
                  }
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
