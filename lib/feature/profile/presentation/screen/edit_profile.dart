import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:wecollect/feature/profile/presentation/bloc/user_bloc.dart';
import 'package:wecollect/feature/profile/presentation/bloc/user_state.dart';

import '../../../../core/dj/injection.dart';
import '../../../../core/utility/theme/theme.dart';
import '../../../../core/utility/widget/button.dart';
import '../../../../core/utility/widget/button2.dart';
import '../../../pickup_request/presentation/widget/location_pick.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Future<void> _pickImage() async {
    final ImageSource? source = await _showImageSourceDialog();

    if (source != null) {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }
  }

  Future<ImageSource?> _showImageSourceDialog() async {
    return showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choose Image Source',
            style: TextStyle(color: AppColors.primaryColor),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(ImageSource.gallery);
                  },
                  icon: const Icon(
                    Icons.photo_library,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(ImageSource.camera);
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String role = "";
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? selectedLocation;
  LocationData? currentLocation;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserCubit>()..getUserProfile(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {
              if (state is UserSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
              if (state is UserError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is UserLoading) {
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * .9,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is UserLoaded) {
                _nameController.text = state.user.data?.name ?? "";
                _emailController.text = state.user.data?.email ?? "";
                _phoneController.text = state.user.data?.phoneNumber ?? "";
                // role = state.user.data?.role ?? "";
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: _image != null
                                  ? Image.file(_image!).image
                                  : null,
                              child: _image == null ? Icon(Icons.person) : null,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => _pickImage(),
                              child: Text('Pick Image'),
                            ),
                            // ElevatedButton(
                            //   onPressed: () => _pickImage(ImageSource.camera),
                            //   child: Text('Pick Image from Camera'),
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "John Doe",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(Icons.person,
                                color: AppColors.secondaryColor),
                          ),
                        ),

                        // validate if the email is valid or phone is valid
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "johndoe@example.com",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(Icons.email,
                                color: AppColors.secondaryColor),
                          ),
                        ),

                        // validate if the email is valid or phone is valid
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "0912345678",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(Icons.phone,
                                color: AppColors.secondaryColor),
                          ),
                        ),

                        // validate if the email is valid or phone is valid
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // show current location with lat and long

                      Text(
                          'Your Location: lat ${currentLocation?.latitude}, long ${currentLocation?.longitude}'),
                      // location picker
                      CustomButton2(
                          onPressed: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LocationPicker(
                                            myLocation: currentLocation)))
                                .then((value) async {
                              currentLocation = LocationData.fromMap({
                                'latitude': value.latitude,
                                'longitude': value.longitude
                              });
                              setState(() {});
                            });
                          },
                          text: 'Pick Location'),

                      const SizedBox(height: 20),
                      Row(
                        children: [
                          CustomButton(
                            width: MediaQuery.sizeOf(context).width * .43,
                            onPressed: () {
                              final userCubit = context.read<UserCubit>();
                              userCubit.updateUserProfile({
                                'name': _nameController.text,
                                'email': _emailController.text,
                                'phone': _phoneController.text,
                                'role': role,
                                'latitude': selectedLocation?.latitude,
                                'longitude': selectedLocation?.longitude,
                                'profile_photo':
                                    _image != null ? _image!.path : '',
                              });
                            },
                            isLoading: false,
                            text: "Save",
                          ),
                          const Spacer(),
                          CustomButton2(
                            width: MediaQuery.sizeOf(context).width * .43,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: "Cancel",
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (state is UserError) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const Center(
                child: Text('An error occured'),
              );
            },
          ),
        ),
      ),
    );
  }
}
