import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wecollect/core/data/constant.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

class AgentMap extends StatefulWidget {
  final LatLng source;
  final LatLng destination;
  const AgentMap({super.key, required this.source, required this.destination});

  @override
  State<AgentMap> createState() => _AgentMapState();
}

class _AgentMapState extends State<AgentMap> {
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  late LatLng source;
  late LatLng destination;
  

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

    location.onLocationChanged.listen((LocationData currentLocation) {
      this.currentLocation = currentLocation;

      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 14.4746,
        ),
      ));
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

  @override
  void initState() {
    source = widget.source;
    destination = widget.destination;
    getCurrentPosition();
    getPolyLines();
    super.initState();
  }

  void despose() {
    super.dispose();
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
              initialCameraPosition: CameraPosition(
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
                 Marker(
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
                    BitmapDescriptor.hueViolet,
                  ),
                ),
                Marker(
                  markerId: MarkerId('Destination'),
                  position: destination,
                  infoWindow: InfoWindow(title: 'Destination'),
                  icon: BitmapDescriptor.defaultMarker,
                ),
              },
              onMapCreated: (controller){
                _controller.complete(controller);
              }
            ),
    );
  }
}
