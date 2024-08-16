import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

import '../../../../core/dj/injection.dart';
import '../../../agent_map/presentation/screen/agent_map_screen.dart';
import '../../../landing/presentation/widget/recent_activity_card.dart';
import '../bloc/request_bloc.dart';
import '../bloc/request_state.dart';

class PickUpAssigned extends StatefulWidget {
  const PickUpAssigned({super.key});

  @override
  State<PickUpAssigned> createState() => _PickUpAssignedState();
}

class _PickUpAssignedState extends State<PickUpAssigned> {
  LocationData? currentLocation;

  final Completer<GoogleMapController> _controller = Completer();
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

  @override
  void initState() {
    getCurrentPosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future requestDetail() {
      return showModalBottomSheet(
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DetailNote(
                    text1: 'Date and Time: ',
                    child: Text(' April 10 , 2024, 10:43 AM',
                        style: TextStyle(fontSize: 18)),
                  ),
                  const DetailNote(
                    text1: 'Agent Name: ',
                    child: Text(' John Doe', style: TextStyle(fontSize: 18)),
                  ),
                  const DetailNote(
                    text1: 'Reedamble Points: ',
                    child: Text(' +10', style: TextStyle(fontSize: 18)),
                  ),
                  DetailNote(
                    text1: 'Status: ',
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('Completed',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const DetailNote(
                    text1: 'Environmental Impact: ',
                    child: Column(
                      children: [
                        Text('Plastic Collection: 10kg',
                            style: TextStyle(fontSize: 18)),
                        SizedBox(height: 24),
                        Text('CO2 Emissions Reduced: 5kg',
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                  DetailNote(
                    text1: 'Feedback and Rating: ',
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [1, 2, 3, 4, 5]
                              .map((e) => Icon(Icons.star,
                                  color: e < 4 ? Colors.amber : Colors.grey))
                              .toList(),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          child: const Text(
                            '"Efficient service, prompt pickup, and friendly agent! Highly recommend this app for hassle-free plastic waste collection. Keep up the excellent work!"',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
          // return AgentMap(source: source, destination: destination);
        },
      );
    }

    return BlocProvider(
      create: (context) => getIt<RequestCubit>()..fetchAgentRequests(),
      child: BlocConsumer<RequestCubit, RequestState>(
        listener: (context, state) {
          if(state is RequestError && state.message.contains('expired')){
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          }
          if (state is RequestError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }

        },
        builder: (context, state) {
          if (state is RequestLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AgentRequestLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      'Pick Up Assigned',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    Column(
                      children: state.requests.map((recentActivityCard) {
                        return RecentActivityCard(
                          status: recentActivityCard.taskStatus ?? "",
                          date: recentActivityCard.assignedDate ?? "",
                          time: recentActivityCard.assignedTime ?? "",
                          title:
                              recentActivityCard.requestId?.wastePlasticType?.type ?? "",
                          onPressed: () {
                            if (recentActivityCard.taskStatus ==
                                'completed') {
                              requestDetail();
                            }
                            if (currentLocation?.latitude == null &&
                                currentLocation?.longitude == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Couldn't get user destination address")));
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    log(recentActivityCard.toString());
                                    return AgentMap(
                                      destination: LatLng(
                                        recentActivityCard.requestId?.latitude ?? 0.0,
                                        recentActivityCard.requestId?.longitude ?? 0.0,
                                      ),
                                      source: LatLng(
                                        currentLocation?.latitude ?? 0.0,
                                        currentLocation?.longitude ?? 0.0,
                                      ),
                                      acceptType: "pending",
                                      request: {
                                        "date":
                                            recentActivityCard.assignedDate ??
                                                "",
                                        "time":
                                            recentActivityCard.assignedTime ??
                                                "",
                                        "name": recentActivityCard
                                                .requestId?.requestor?.name ??
                                            "",
                                        "requestId": recentActivityCard.id,
                                        "phone": recentActivityCard
                                                .requestId?.requestor?.phoneNumber ??
                                            "",
                                        "status":
                                            recentActivityCard.taskStatus ??
                                                "",
                                      },
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class DetailNote extends StatelessWidget {
  final String text1;
  final Widget child;
  const DetailNote({
    super.key,
    required this.text1,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        children: [
          Text(
            text1,
            style: TextStyle(color: AppColors.secondaryColor, fontSize: 18),
          ),
          child,
        ],
      ),
    );
  }
}
