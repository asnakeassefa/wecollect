import 'package:flutter/material.dart';

class AgentCard extends StatelessWidget {
  const AgentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/ava-character.png'),
        ),
        title: const Text('Agent Name: John Doe'),
        subtitle: const Text('Phone Number:     251912345678'),
        tileColor: Colors.grey[300],
      ),
    );
  }
}
