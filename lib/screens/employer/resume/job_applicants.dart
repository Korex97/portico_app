import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:potrico/functions/general_functions.dart';
import 'package:potrico/models/job_applicants.dart';
import 'package:potrico/screens/employer/navigationbar/navigation_bar.dart';
import 'package:potrico/screens/employer/resume/applicant_details.dart';
import 'package:potrico/services/base_url.dart';
import 'package:potrico/states/job_Applicants_state.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/applicant_details_controller.dart';
import '../../../controllers/job_applicants_controller.dart';
import '../../onboarding/login.dart';
import '../../widgets/widgets.dart';

class JobApplicants extends ConsumerStatefulWidget {
  final String jobname;
  const JobApplicants({super.key, required this.jobname});

  @override
  ConsumerState<JobApplicants> createState() => _JobApplicantsState();
}

class _JobApplicantsState extends ConsumerState<JobApplicants> {
  bool loading = false;
  List<Applicants> applicants = [];
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        Future.delayed(Duration.zero, () {
          stateValidation();
        });
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 6.h, left: 5.w, right: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadStyle(
                      backRoute: Navigation(),
                      firstImage: "assets/images/arrow-left-fill.png",
                      lastImage: null,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    AutoSizeText(
                      "${widget.jobname} Applicants",
                      style: fontRoboto(
                        textStyle: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: porticoBlackText,
                        ),
                      ),
                    ),
                    if (loading) ...[
                      Center(
                        child: Image.asset(
                          "assets/images/dot-loader.gif",
                        ),
                      ),
                    ] else ...[
                      SizedBox(
                        height: 4.h,
                      ),
                      if (applicants.isEmpty) ...[
                        NoRecord(
                          ref: ref,
                          contentName: 'Applicant',
                          showButton: false,
                        ),
                      ],
                      if (applicants.isNotEmpty) ...[
                        SizedBox(
                          height: 70.h,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              for (var element in applicants) ...[
                                InkWell(
                                  onTap: () {
                                    ref
                                      .read(
                                          applicantDetailsControllerProvider.notifier)
                                      .getApplicantDetails(element.id!);
                                    goToPage(
                                      context,
                                      const ApplicantDetails(),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 2.h),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 0.5,
                                          color: porticoLGrey,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 60.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (element.profilePic != null &&
                                                  element.profilePic!
                                                      .isNotEmpty) ...[
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage: NetworkImage(
                                                    "${BaseUrl.imageUrl}${element.profilePic}",
                                                  ),
                                                ),
                                              ] else ...[
                                                const CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage: AssetImage(
                                                    "assets/images/image_resume.png",
                                                  ),
                                                ),
                                              ],
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  AutoSizeText(
                                                    "${element.fullname}",
                                                    style: fontRoboto(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            porticoApplicantText,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  AutoSizeText(
                                                    "${element.createdAt}",
                                                    style: fontRoboto(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: porticoGrey,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3.w, vertical: 1.h),
                                          decoration: BoxDecoration(
                                            color: (element.status == 0)
                                                ? porticoApplicantPendingWithOpacity10
                                                : (element.status == 1)
                                                    ? porticoPinkApplicantSuccessWithOpacity10
                                                    : porticoApplicantRejectedWithOpacity10,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          child: Center(
                                            child: AutoSizeText(
                                              "${element.statusValue}",
                                              style: fontRoboto(
                                                textStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: (element.status == 0)
                                                      ? porticoApplicantRejected
                                                      : (element.status == 1)
                                                          ? porticoApplicantWithSuccess
                                                          : porticoApplicantRejected,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
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
            setState(() {
              applicants = success.body!.data!.applicants!;
            });
          } else {
            setState(() {
              applicants = [];
            });
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
