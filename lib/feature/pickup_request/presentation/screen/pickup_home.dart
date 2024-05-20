import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

import '../../../../core/dj/injection.dart';
import '../bloc/request_bloc.dart';
import 'pickup_history.dart';
import 'pickup_request.dart';

class PickUpHome extends StatefulWidget {
  const PickUpHome({super.key});

  @override
  State<PickUpHome> createState() => _PickUpHomeState();
}

class _PickUpHomeState extends State<PickUpHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => getIt<RequestCubit>(),
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
                  tabs: const [
                    Tab(
                      child: Text(
                        'Pick Up Request',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Pick Up History',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                )),
            body: const TabBarView(
              children: [
                PickUpRequest(),
                PickUpHistory(),
              ],
            )),
      ),
    );
  }
}
