import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wecollect/core/data/constant.dart';
import 'package:wecollect/core/utility/theme/theme.dart';
import 'package:wecollect/core/utility/widget/button.dart';
import 'package:wecollect/core/utility/widget/button2.dart';
import 'package:wecollect/feature/agent_map/presentation/bloc/map_state.dart';

import '../../../../core/dj/injection.dart';
import '../bloc/map_bloc.dart';

class AgentMap extends StatefulWidget {
  final LatLng source;
  final LatLng destination;
  final String acceptType;
  final Map<String, dynamic> request;
  const AgentMap(
      {super.key,
      required this.source,
      required this.destination,
      required this.acceptType,
      required this.request});

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

    log(source.toString() + destination.toString());

    super.initState();
  }

  void despose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Map'),
      // ),
      body: currentLocation == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : BlocProvider(
              create: (context) => getIt<MapCubit>(),
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .7,
                    child: GoogleMap(
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
                            markerId: const MarkerId('source'),
                            position: source,
                            infoWindow: const InfoWindow(title: 'Source'),
                            icon: BitmapDescriptor.defaultMarker,
                          ),
                          Marker(
                            markerId: const MarkerId('Current Loacation'),
                            position: LatLng(currentLocation!.latitude!,
                                currentLocation!.longitude!),
                            infoWindow:
                                const InfoWindow(title: 'Current Location'),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueViolet,
                            ),
                          ),
                          Marker(
                            markerId: const MarkerId('Destination'),
                            position: destination,
                            infoWindow: const InfoWindow(title: 'Destination'),
                            icon: BitmapDescriptor.defaultMarker,
                          ),
                        },
                        onMapCreated: (controller) {
                          _controller.complete(controller);
                        }),
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * .22,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('Client Name: ',
                                style: TextStyle(fontSize: 18)),
                            Text(widget.request['name'] ?? '',
                                style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('phone number: ',
                                style: TextStyle(fontSize: 18)),
                            Text(widget.request['phone'] ?? '',
                                style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Date and Time: ',
                                style: TextStyle(fontSize: 18)),
                            Text(widget.request['date'] ?? '',
                                style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Reedamble Points: ',
                                style: TextStyle(fontSize: 18)),
                            Text(widget.request['points'] ?? '',
                                style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Status: ',
                                style: TextStyle(fontSize: 18)),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: widget.acceptType == 'pending'
                                    ? Colors.orange
                                    : AppColors.secondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(widget.acceptType,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // butto to accept or reject a request
                  widget.acceptType != "rejected"
                      ? BlocConsumer<MapCubit, MapState>(
                          listener: (context, state) {
                            if (state is MapError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                ),
                              );
                            }

                            if (state is MapSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                ),
                              );

                              Navigator.pop(context);
                            }
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            return SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomButton2(
                                    isLoading: state is MapRejectLoading,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.43,
                                    onPressed: () async {
                                      final userId =
                                          await const FlutterSecureStorage()
                                              .read(key: 'userId');
                                      log('reject request');
                                      log({
                                        'requestId':
                                            widget.request['requestId'],
                                        'userId': userId,
                                        'agent_status': 'reject'
                                      }.toString());
                                      context.read<MapCubit>().createRequest({
                                        "requestId":
                                            widget.request['requestId'],
                                        "userId": userId,
                                        "agent_status": "reject"
                                      });
                                    },
                                    text: 'reject',
                                  ),
                                  CustomButton(
                                      isLoading: state is MapLoading,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.43,
                                      onPressed: () async {
                                        final userId =
                                            await const FlutterSecureStorage()
                                                .read(key: 'userId');
                                        log(widget.acceptType);
                                        if (widget.acceptType == 'pending') {
                                          context
                                              .read<MapCubit>()
                                              .createRequest({
                                            "requestId":
                                                widget.request['requestId'],
                                            "userId": userId,
                                            "agent_status": "accept"
                                          });
                                        } else if (widget.acceptType ==
                                            'accepted') {
                                          context
                                              .read<MapCubit>()
                                              .updateRequest({
                                            "requestId":
                                                widget.request['requestId'],
                                            "userId": userId,
                                            "task_status": "complete"
                                          });
                                        }
                                      },
                                      text: widget.acceptType == 'pending'
                                          ? 'Accept'
                                          : 'Completed'),
                                ],
                              ),
                            );
                          },
                        )
                      : Container()
                ]),
              ),
            ),
    );
  }
}
