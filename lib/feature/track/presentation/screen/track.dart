import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

class TrackDetailPage extends StatefulWidget {
  const TrackDetailPage({super.key});

  @override
  State<TrackDetailPage> createState() => _TrackDetailPageState();
}

class _TrackDetailPageState extends State<TrackDetailPage> {
  List<StepperData> stepperData = [
    StepperData(
      title: StepperText(
        "Request Placed",
        textStyle: TextStyle(
          color: AppColors.bodyTextColor,
        ),
      ),
      iconWidget: CircleAvatar(
        backgroundColor: AppColors.primaryColor,
      ),
      subtitle: StepperText("Your order has been placed"),
      // iconWidget: Container(
      //   padding: const EdgeInsets.all(8),
      //   decoration: const BoxDecoration(
      //       color: Colors.green,
      //       borderRadius: BorderRadius.all(Radius.circular(30))),
      // ),
    ),
    StepperData(
      title: StepperText("Verification",
          textStyle: TextStyle(color: AppColors.bodyTextColor)),
      subtitle: StepperText("Your order is being verified, please wait"),
      iconWidget: CircleAvatar(
        backgroundColor: AppColors.primaryColor,
      ),
    ),
    StepperData(
      title: StepperText("confirmation",
          textStyle: TextStyle(color: AppColors.bodyTextColor)),
      subtitle: StepperText(
          "Your order has been confirmed, Thank you for your order"),
      iconWidget: const CircleAvatar(
        backgroundColor: Colors.grey,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Track',
          style: TextStyle(
              color: AppColors.secondaryTitleColor,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AnotherStepper(
            stepperList: stepperData,
            stepperDirection: Axis.vertical,
            activeBarColor: AppColors.primaryColor,
            inActiveBarColor: Colors.grey,
            iconHeight: 18,
            iconWidth: 18,
            verticalGap: 30,
            activeIndex: 1,
            barThickness: 2,
          ),
        ),
      ),
    );
  }
}
