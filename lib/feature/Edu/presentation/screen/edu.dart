import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:wecollect/core/utility/theme/theme.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(child: Image.asset('assets/images/onboarding4.png')),
            const SizedBox(height: 20),
            Text(
              'Educational Content',
              style: TextStyle(
                  fontSize: 24,
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: const Column(
                  children: [
                    Text(
                      'The Impact of Plastic Pollution on Marine Life',
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(),
                  ],
                ),
                collapsed: const Text(
                  "Learn how recycling can reduce plastic pollution and protect  the environment.",
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: const Text(
                  "In an era marked by rapid industrialization and unbridled consumption, the imperative to safeguard our environment has never been more pressing. Environmental protection is not merely a moral obligation; it is an existential necessity. The health of our planet directly impacts the well-being of all living beings, including humans. Yet, despite growing awareness of environmental issues, the pace of degradation continues to outstrip conservation efforts.",
                  softWrap: true,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: const Column(
                  children: [
                    Text(
                      'The Impact of Plastic Pollution on Marine Life',
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(),
                  ],
                ),
                collapsed: const Text(
                  "Learn how recycling can reduce plastic pollution and protect  the environment.",
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: const Text(
                  "In an era marked by rapid industrialization and unbridled consumption, the imperative to safeguard our environment has never been more pressing. Environmental protection is not merely a moral obligation; it is an existential necessity. The health of our planet directly impacts the well-being of all living beings, including humans. Yet, despite growing awareness of environmental issues, the pace of degradation continues to outstrip conservation efforts.",
                  softWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
