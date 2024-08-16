import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

import '../../../../core/dj/injection.dart';
import '../bloc/request_bloc.dart';
import 'pickup_assigned.dart';
import 'pickup_history.dart';
import 'pickup_request.dart';

class PickUpHome extends StatefulWidget {
  const PickUpHome({super.key});

  @override
  State<PickUpHome> createState() => _PickUpHomeState();
}

class _PickUpHomeState extends State<PickUpHome> {
  String? role = '';

  void getRole() async {
    final storage = FlutterSecureStorage();
    // role = await storage.read(key: 'role');
    role = await storage.read(key: 'role');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getRole();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<RequestCubit>()..fetchRequests(),
          ),
        ],
        child: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  'Pick Up Request',
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                bottom: TabBar(
                  indicatorColor: AppColors.primaryColor,
                  tabs: [
                    Tab(
                      child: Text(
                        role == 'agent'
                            ? 'Pick Up Assigned'
                            : 'Pick Up Request',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Tab(
                      child: Text(
                        'Pick Up History',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                )),
            body: TabBarView(
              children: [
                role == 'agent'
                    ? PickUpAssigned():
                      role == 'client'?
                        PickUpRequest(): Center(child: Text('User with this role cannot access this page')),
                PickUpHistory(),
              ],
            )),
      ),
    );
  }
}
