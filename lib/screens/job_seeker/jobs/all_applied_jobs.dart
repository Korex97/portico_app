import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/functions/general_functions.dart';
import 'package:potrico/screens/job_seeker/notifications/notifications.dart';
import 'package:potrico/screens/widgets/loading_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/job_applicants_controller.dart';
import '../../../models/job_applicants.dart';
import '../../../states/job_Applicants_state.dart';
import '../../onboarding/login.dart';
import '../../widgets/widgets.dart';
import '../components/job_card.dart';
import 'job_details.dart';

class AllAppliedJobs extends ConsumerStatefulWidget {
  const AllAppliedJobs({super.key});

  @override
  ConsumerState<AllAppliedJobs> createState() => _AllAppliedJobsState();
}

class _AllAppliedJobsState extends ConsumerState<AllAppliedJobs> {
  final jobProvider = StateProvider<List<Applicants>>((ref) => []);
  bool loading = false;
  List<Applicants> appliedJobs = [];
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      Future.delayed(Duration.zero, () async {
        await stateValidation();
      });
      appliedJobs = ref.read(jobProvider.notifier).state;
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeadStyle(
              firstImage: "assets/images/menu.png",
              lastImage: "assets/images/notification.png",
              route: AllNotifications(
                backPage: 2,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            AutoSizeText(
              "My Jobs",
              style: fontRoboto(
                textStyle: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: porticoBlackText,
                ),
              ),
            ),
            if (loading) ...[
              const LoadingWidget()
            ] else ...[
              if (appliedJobs.isEmpty) ...[
                NoRecord(
                  ref: ref,
                  contentName: "applied jobs",
                  showButton: false,
                ),
              ] else ...[
                SizedBox(
                  height: 70.h,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      for ( var item in appliedJobs ) ...[
                         JobCard(jobName: item.position!, jobType: item.jobType!, jobId: item.jobId!, jobCategory: item.categoryName!, location: item.location!, salary: item.expectedSalary!, ref: ref, pageOn: 2),
                          SizedBox(
                            height: 2.h,
                          ),
                      ],
                      SizedBox(
                        height: 2.h,
                      ),
                     
                    ],
                  ),
                ),
              ],
            ],
          ]);
    });
  }

  stateValidation() {
    var state = ref.watch(jobApplicantsControllerProvider);
    if (state is JobApplicantsStateLaoding) {
      Future.delayed(Duration.zero, () {
        setState(() {
          loading = true;
        });
      });
    } else {
      // remove loading
      Future.delayed(Duration.zero, () {
        setState(() {
          loading = false;
        });
      });
      // state validation
      if (state is JobApplicantsStateError) {
        Future.delayed(Duration.zero, () {
          showErrorToast(context, state.error);
          ref.read(jobApplicantsControllerProvider.notifier).resetState();
        });
      }

      if (state is JobApplicantsStateSuccess) {
        JobApplicantModel success = state.successData;
        // check authentication
        if (success.statusCode == 401) {
          Future.delayed(Duration.zero, () {
            showErrorToast(context, "User not authorized");
            ref.read(jobApplicantsControllerProvider.notifier).resetState();
            goToPage(context, const LoginUser());
          });
        }

        // check for errors
        if (success.statusCode == 200) {
          if (success.body!.status != null && success.body!.status!) {
            var allJobs = success.body!.data!.applicants;
            if (allJobs != null && allJobs.isNotEmpty) {
              ref.read(jobProvider.notifier).state = allJobs;
            } else {
              ref.read(jobProvider.notifier).state = [];
            }
          } else {
            ref.read(jobProvider.notifier).state = [];
          }
        } else {
          Future.delayed(Duration.zero, () {
            showErrorToast(context, success.body!.text!);
            ref.read(jobApplicantsControllerProvider.notifier).resetState();
          });
        }
      }
    }
  }
}
