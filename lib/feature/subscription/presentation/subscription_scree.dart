import 'package:flutter/material.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

class Subscribe extends StatefulWidget {
  const Subscribe({super.key});

  @override
  State<Subscribe> createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Subscribe'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width * .9,
          height: MediaQuery.sizeOf(context).height * .7,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: AppColors.primaryColor.withOpacity(0.9)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Monthly',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 10),
              const Text('\$9.98/mo',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 40),
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 10),
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width * .7,
                      child: const Text('Regular collection Requests',
                          style: TextStyle(fontSize: 20, color: Colors.white))),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 10),
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width * .7,
                      child: const Text('Monthly Earned Reward',
                          style: TextStyle(fontSize: 20, color: Colors.white))),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 10),
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width * .7,
                      child: const Text('Continues support and updates',
                          style: TextStyle(fontSize: 20, color: Colors.white))),
                ],
              ),
              const SizedBox(height: 100),
              Center(
                child: ElevatedButton(
                  
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {},
                  child: const Text(
                    'Buy now',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
