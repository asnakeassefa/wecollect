import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wecollect/core/utility/widget/button.dart';

class LocationPicker extends StatefulWidget {
  final myLocation;
  const LocationPicker({super.key, required this.myLocation});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final Completer<GoogleMapController> _controller = Completer();
  LocationData? currentLocation;

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
    currentLocation = widget.myLocation;
    if (widget.myLocation == null) getCurrentPosition();
    // getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height * .9,
        child: currentLocation == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.8,
                    child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                          zoom: 14.4746,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('Your Loacation'),
                            position: LatLng(currentLocation!.latitude!,
                                currentLocation!.longitude!),
                            infoWindow:
                                const InfoWindow(title: 'Your Location'),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueViolet,
                            ),
                          ),
                        },
                        onTap: (LatLng latLng) {
                          setState(() {
                            currentLocation = LocationData.fromMap({
                              'latitude': latLng.latitude,
                              'longitude': latLng.longitude
                            });
                          });
                        },
                        onMapCreated: (controller) {
                          _controller.complete(controller);
                        }),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        LatLng(currentLocation?.latitude ?? 0.0,
                            currentLocation?.longitude ?? 0.0),
                      );
                    },
                    text: 'Selecte Location',
                  )
                ],
              ),
      ),
    );
  }
}
