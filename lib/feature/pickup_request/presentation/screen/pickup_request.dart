import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:wecollect/core/utility/theme/theme.dart';
import 'package:wecollect/core/utility/widget/button.dart';
import 'package:wecollect/core/utility/widget/button2.dart';

import '../../../../core/network/endpoints.dart';
import '../../../../core/utility/refactor/date_formater.dart';
import '../bloc/request_bloc.dart';
import '../bloc/request_state.dart';
import '../widget/location_pick.dart';

class PickUpRequest extends StatefulWidget {
  const PickUpRequest({super.key});

  @override
  State<PickUpRequest> createState() => _PickUpRequestState();
}

class _PickUpRequestState extends State<PickUpRequest> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController _dateController =
      TextEditingController(text: formatCustomDate(DateTime.now()));
  DateTime dateTime = DateTime.now();
  final Completer<GoogleMapController> _controller = Completer();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  int hourValue = 1;
  int minuteValue = 0;
  int pickupType = 1;
  int wateTypeId = 1;
  LatLng? selectedLocation;
  String amPm = 'AM';
  String weightUnit = 'kg';
  bool useCurrentLocation = false;
  LocationData? currentLocation;

  String token = "";

  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void getToken() async {
    token = await _storage.read(key: 'accessToken') ?? "";
    log(token);
    setState(() {});
  }

  void getCurrentPosition() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.getLocation().then((value) {
      currentLocation = value;
      setState(() {});
    });
    GoogleMapController googleMapController = await _controller.future;
  }

  @override
  void initState() {
    super.initState();
    getToken();
    getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestCubit, RequestState>(
      listener: (context, state) {
        if (state is RequestSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(color: Colors.green),
              ),
              backgroundColor: Colors.white,
            ),
          );
        }

        if (state is RequestError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.primaryColor,
            ),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Pick a date and time which is suitable for you',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Date',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                // container with which is text field and date picker
                // the text filed is not editable but there is a date picker which picks date and change the text to the picked date

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now()
                                .add(const Duration(days: 3 * 365)),
                          ).then((value) {
                            if (value != null) {
                              dateTime = value;
                              _dateController.text = formatCustomDate(value);
                            }
                          });
                        },
                        icon: SvgPicture.asset(
                          'assets/icons/calendar.svg',
                          height: 28,
                          width: 28,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        child: TextField(
                          enabled: false,
                          controller: _dateController,
                          decoration: const InputDecoration(
                            hintText: "Select Date",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                const Text(
                  'Time',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),

                // dropdown for hours and minutes and pm and am with separet container
                const SizedBox(height: 20),

                Row(
                  children: [
                    // dropdown hours only
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        underline: const SizedBox(),
                        value: hourValue.toString(),
                        items: <String>[
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10',
                          '11',
                          '12'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            hourValue = int.parse(value!);
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(':', style: TextStyle(fontSize: 32)),
                    const SizedBox(width: 5),
                    // minute dropdown
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        underline: const SizedBox(),
                        value: minuteValue.toString(),
                        items: <String>[
                          // 60 minutes
                          '0',
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10',
                          '11',
                          '12',
                          '13',
                          '14',
                          '15',
                          '16',
                          '17',
                          '18',
                          '19',
                          '20',
                          '21',
                          '22',
                          '23',
                          '24',
                          '25',
                          '26',
                          '27',
                          '28',
                          '29',
                          '30',
                          '31',
                          '32',
                          '33',
                          '34',
                          '35',
                          '36',
                          '37',
                          '38',
                          '39',
                          '40',
                          '41',
                          '42',
                          '43',
                          '44',
                          '45',
                          '46',
                          '47',
                          '48',
                          '49',
                          '50',
                          '51',
                          '52',
                          '53',
                          '54',
                          '55',
                          '56',
                          '57',
                          '58',
                          '59',
                          '60'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            minuteValue = int.parse(value!);
                          });
                        },
                      ),
                    ),

                    const SizedBox(width: 5),
                    const Text(':', style: TextStyle(fontSize: 32)),
                    const SizedBox(width: 5),

                    // am pm
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        underline: const SizedBox(),
                        value: amPm,
                        items: <String>['AM', 'PM'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            amPm = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                const Text("pick waste type",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                token != ""
                    ? MultiSelectDropDown.network(
                        onOptionSelected: (options) {
                          pickupType = options.first.value as int;
                        },
                        networkConfig: NetworkConfig(
                          url: Endpoints.wasteType,
                          method: RequestMethod.get,
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer $token'
                          },
                        ),
                        borderColor: Colors.black54,
                        borderWidth: 1,

                        chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                        responseParser: (response) {
                          log(response.toString());
                          final list =
                              (response['data'] as List<dynamic>).map((e) {
                            final item = e as Map<String, dynamic>;
                            return ValueItem(
                              label: item['type'],
                              value: item['id'],
                            );
                          }).toList();

                          return Future.value(list);
                        },
                        maxItems: 1,
                        // searchEnabled: true,
                        // selectedOptions: options,
                        responseErrorBuilder: ((context, body) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('Error while fetching the data'),
                          );
                        }),
                      )
                    : Container(),

                const SizedBox(height: 20),
                const SizedBox(height: 24),
                const Text(
                  'Quantitiy/ Weight',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 24),
                // Text field for weight and dropdown for selecting weight units
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        child: TextField(
                          controller: weightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Enter Weight",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                          left: BorderSide(width: 1, color: Colors.grey),
                        )),
                        child: DropdownButton<String>(
                          underline: const SizedBox(),
                          value: weightUnit,
                          items: <String>['kg'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              weightUnit = value ?? "kg";
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                const Text(
                  'Add Image',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _image == null
                          ? const Text('No image selected.')
                          : SizedBox(
                              height: 250,
                              width: 400,
                              child: Image.file(_image!, fit: BoxFit.fitHeight),
                            ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _pickImage(ImageSource.gallery),
                        child: const Text('Pick Image from Gallery'),
                      ),
                      ElevatedButton(
                        onPressed: () => _pickImage(ImageSource.camera),
                        child: const Text('Pick Image from Camera'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Location',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add, color: AppColors.primaryColor))
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'use current location',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      // toggle for using current location and toggle when the switch is off
                      Switch(
                        value: useCurrentLocation,
                        onChanged: (value) {
                          setState(() {
                            useCurrentLocation = value;
                          });
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
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  child: Stack(
                    children: [
                      currentLocation == null
                          ? const Center(
                              child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator()),
                            )
                          : GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(currentLocation!.latitude!,
                                    currentLocation!.longitude!),
                                zoom: 14.4746,
                              ),
                              markers: {
                                Marker(
                                  markerId: const MarkerId('Current Loacation'),
                                  position: LatLng(currentLocation!.latitude!,
                                      currentLocation!.longitude!),
                                  infoWindow: const InfoWindow(
                                      title: 'Current Location'),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueViolet,
                                  ),
                                ),
                              },
                              onMapCreated: (controller) {
                                _controller.complete(controller);
                              }),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton2(
                    isDisabled: useCurrentLocation,
                    onPressed: () {
                      if (useCurrentLocation && currentLocation != null) {
                        return;
                      }
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationPicker(
                                      myLocation: currentLocation)))
                          .then((value) async {
                        selectedLocation = value;
                        GoogleMapController googleMapController =
                            await _controller.future;
                        googleMapController
                            .animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: value,
                            zoom: 14.4746,
                          ),
                        ));
                        currentLocation = LocationData.fromMap({
                          'latitude': value.latitude,
                          'longitude': value.longitude
                        });
                        setState(() {});
                      });
                    },
                    text: 'Pick Location'),

                const SizedBox(height: 24),
                CustomButton(
                    isLoading: state is RequestLoading,
                    onPressed: () async {
                      double lat = 0.0;
                      double long = 0.0;

                      if (useCurrentLocation && currentLocation != null) {
                        lat = currentLocation?.latitude ?? 0.0;
                        long = currentLocation?.longitude ?? 0.0;
                      } else if (selectedLocation != null) {
                        lat = selectedLocation?.latitude ?? 0.0;
                        long = selectedLocation?.longitude ?? 0.0;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a location'),
                            backgroundColor: Colors.grey,
                          ),
                        );
                        return;
                      }
                      // request pickup
                      String? requester =
                          await _storage.read(key: 'userId') ?? "";
                      int user = int.parse(requester);
                      context.read<RequestCubit>().createRequest(
                          // {
                          // 'date': formatCustomDate(dateTime),
                          // 'time': '$hourValue:$minuteValue $amPm',
                          // 'weight': '1 $weightUnit',
                          // 'latitude': '9.0192',
                          // 'longitude': '38.7525',

                          // "requestor": 1,
                          // "wastePlastic_type": 1,
                          // "request_date": "2024-06-19",
                          // "request_time": "13:45:00",
                          // "wastePlastic_size":10,
                          // "wastePlastic_address": "AA",
                          // "unique_location": "koshe",
                          // "latitude": 8.32526,
                          // "longitude": 39.5346
                          // }

                          {
                            "requestor": user,
                            "wastePlastic_type": pickupType,
                            "request_date":
                                "${dateTime.year}-${dateTime.month}-${dateTime.day}",
                            "request_time":
                                '$hourValue:$minuteValue:00'.toString(),
                            "wastePlastic_size":
                                int.parse(weightController.text),
                            "latitude": lat,
                            "longitude": long,
                          });
                    },
                    text: "Request Pickup"),

                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }
}
