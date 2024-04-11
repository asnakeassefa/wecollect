import 'package:flutter/material.dart';
import 'package:wecollect/core/utility/theme/theme.dart';
import 'package:wecollect/feature/requiest_detail/presentation/screen/requiest_detail.dart';

import '../../../track/presentation/screen/track.dart';
import '../../data/notification_model.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> notifications = [
    NotificationModel(title: 'Alert Message', body: 'clients arrived'),
    NotificationModel(title: 'Collection Confirmed', body: 'Time: 2:00 am'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(
              color: AppColors.secondaryTitleColor,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: notifications.map((e) {
            return NotificationTile(notificationModel: e);
          }).toList(),
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  NotificationModel notificationModel;
  NotificationTile({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    // notification tile to show notification
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
          leading: Icon(Icons.task_alt, color: Colors.green),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const RequestDetail();
            }));
          },
          title: Text(notificationModel.title),
          subtitle: Text(notificationModel.body),
        ));
  }
}
