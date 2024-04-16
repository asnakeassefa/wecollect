import 'package:flutter/material.dart';
import 'package:wecollect/core/utility/theme/theme.dart';
import 'package:wecollect/core/utility/widget/button.dart';

import '../../../../core/utility/widget/agent.dart';
import '../../../../core/utility/widget/button2.dart';
import '../../../track/presentation/screen/track.dart';

class RequestDetail extends StatefulWidget {
  const RequestDetail({super.key});

  @override
  State<RequestDetail> createState() => _RequestDetailState();
}

class _RequestDetailState extends State<RequestDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Request Detail',
          style: TextStyle(
            color: AppColors.secondaryTitleColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * .70,
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text('Will be there in 10 minutes',
                  style:
                      TextStyle(fontSize: 24, color: AppColors.secondaryColor)),
              const SizedBox(height: 80),
              const AgentCard(),
              const Spacer(),
              CustomButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const TrackDetailPage();
                    }));
                  },
                  text: 'Confirm Request'),
              const SizedBox(height: 24),
              CustomButton2(onPressed: () {}, text: 'Cancel Request')
            ],
          ),
        ),
      ),
    );
  }
}
