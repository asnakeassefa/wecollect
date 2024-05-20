import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wecollect/core/data/constant.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

class AgentMap extends StatefulWidget {
  const AgentMap({super.key});

  @override
  State<AgentMap> createState() => _AgentMapState();
}

class _AgentMapState extends State<AgentMap> {
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  static const LatLng source = LatLng(8.874913, 38.819923);
  static const LatLng destination = LatLng(8.898961, 38.815061);

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
      log('here in current location');
      setState(() {});
    });
  }

  void getPolyLines() async {
    PolylinePoints polylinePoints = PolylinePoints();
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(source.latitude, source.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving,
      );
      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
        setState(() {});
      }
    } catch (e) {}
  }

  // void getCurrentPosition() async {
  //   Location location = Location();
  // }

  @override
  void initState() {
    getPolyLines();
    getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent Map'),
      ),
      body: currentLocation == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: source,
                zoom: 14.4746,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  color: AppColors.primaryColor,
                  points: polylineCoordinates,
                  width: 4,
                ),
              },
              markers: {
                const Marker(
                  markerId: MarkerId('source'),
                  position: source,
                  infoWindow: InfoWindow(title: 'Source'),
                  icon: BitmapDescriptor.defaultMarker,
                ),
                Marker(
                  markerId: const MarkerId('Current Loacation'),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  infoWindow: const InfoWindow(title: 'Current Location'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen,
                  ),
                ),
                const Marker(
                  markerId: MarkerId('Destination'),
                  position: destination,
                  infoWindow: InfoWindow(title: 'Destination'),
                  icon: BitmapDescriptor.defaultMarker,
                ),
              },
            ),
    );
  }
}
