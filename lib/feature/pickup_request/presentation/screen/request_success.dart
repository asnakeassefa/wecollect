import 'package:flutter/material.dart';
import 'package:wecollect/core/utility/widget/button.dart';
import 'package:wecollect/feature/home_page.dart';

import '../../../../core/utility/theme/theme.dart';
import '../../../track/presentation/screen/track.dart';

class RequiestSuccess extends StatelessWidget {
  const RequiestSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          // container to with image child
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * .5,
              child: Image.asset('assets/images/welcome.png'),
            ),
            const Text(
              'Request Success',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            CustomButton(
                onPressed: () {
                  // pop to all screen and push homepage
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }), (route) => false);
                },
                text: "Done"),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const TrackDetailPage();
                }));
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.sizeOf(context).width * 0.90, 50),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Track Request',
                style: TextStyle(color: AppColors.bodyTextColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
