import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wecollect/core/utility/theme/theme.dart';
import 'package:wecollect/feature/Edu/presentation/bloc/dashboard_state.dart';

import '../../../../core/dj/injection.dart';
import '../../../auth/presentation/screen/login.dart';
import '../bloc/content_bloc.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContentCubit>()..getContents(),
      child: SingleChildScrollView(
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
              BlocConsumer<ContentCubit, ContentState>(
                listener: (context, state) {
                  if (state is ContentError &&
                      state.message.contains('expired')) {
                    // navigate to login page
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      }),
                      (route) => false,
                    );
                  } else if (state is ContentError) {
                    // show error message
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is ContentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ContentLoaded) {
                    return Column(
                      children: state.content.data == null
                          ? []
                          : state.content.data!.map((content) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ExpandablePanel(
                                  theme: const ExpandableThemeData(
                                    headerAlignment:
                                        ExpandablePanelHeaderAlignment.center,
                                    tapBodyToCollapse: true,
                                  ),
                                  header: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        content.title ?? "",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                  collapsed: Text(
                                    content.content ?? "",
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  expanded: Text(
                                    content.content ?? "",
                                    textAlign: TextAlign.justify,
                                    softWrap: true,
                                  ),
                                ),
                              );
                            }).toList(),
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 75),
            ],
          ),
        ),
      ),
    );
  }
}
