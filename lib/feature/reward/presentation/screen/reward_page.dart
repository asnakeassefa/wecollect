import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

class RewardScreen extends StatefulWidget {
  static const String routeName = '/reward';
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Rewards and Redemption',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .30,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.15,
                  width: double.infinity,
                  color: AppColors.primaryColor,
                ),
                Positioned(
                  child: Center(
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.16,
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Reedamble Points',
                            style: TextStyle(
                                fontSize: 24, color: AppColors.primaryColor),
                          ),
                          const SizedBox(height: 20),
                          Text('200',
                              style: TextStyle(
                                  fontSize: 24, color: AppColors.bodyTextColor))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RewardCard(
                image: 'assets/icons/reward.svg',
                bodyText: 'Convert to mobile cards',
                title: 'CARD',
              ),
              RewardCard(
                image: 'assets/icons/transfer.svg',
                bodyText: 'Transfer points to others',
                title: 'TRANSFER',
              )
            ],
          ),
          const SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RewardCard(
                image: 'assets/icons/donate.svg',
                bodyText: 'Donate your points',
                title: 'DONATE',
              ),
              RewardCard(
                image: 'assets/icons/cashout.svg',
                bodyText: 'Get money from your points',
                title: 'CASH OUT',
              )
            ],
          )
        ],
      ),
    );
  }
}

class RewardCard extends StatelessWidget {
  final String title;
  final String bodyText;
  final String image;
  const RewardCard({
    super.key,
    required this.title,
    required this.bodyText,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.sizeOf(context).width * .45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: AppColors.primaryColor,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          SvgPicture.asset(
            image,
            height: 70,
            width: 70,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.secondaryTitleColor),
          ),
          const SizedBox(height: 10),
          Text(
            bodyText,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
