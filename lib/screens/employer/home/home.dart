import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/details_controller.dart';
import '../../../controllers/job_applicants_controller.dart';
import '../../../controllers/job_category_controller.dart';
import '../../../controllers/jobs_details_controller.dart';
import '../../../functions/general_functions.dart';
import '../../../models/job_details_model.dart';
import '../../../models/user_details.dart';
import '../../../states/jobs_states.dart';
import '../../../states/user_details_state.dart';
import '../../onboarding/login.dart';
import '../../widgets/details_loading.dart';
import '../../widgets/widgets.dart';
import '../navigationbar/navigation_bar.dart';
import '../resume/job_applicants.dart';

class EmployerHome extends ConsumerStatefulWidget {
  const EmployerHome({super.key});

  @override
  ConsumerState<EmployerHome> createState() => _EmployerHomeState();
}

class _EmployerHomeState extends ConsumerState<EmployerHome> {
  UserData userDetails = UserData();
  List<Jobs> allJobs = [];
  bool loading = false;
  bool jobsLoading = false;

  TextEditingController jobSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await checkDetailsState();
      await jobDetailsState();
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeadStyle(
          firstImage: "assets/images/menu.png",
          lastImage: "assets/images/notification.png",
        ),
        SizedBox(
          height: 3.h,
        ),
        if (loading) const DetailsLoading(),
        if (!loading) ...[
          AutoSizeText(
            (userDetails.fullname == null) ? "" : userDetails.fullname!,
            style: fontRoboto(
              textStyle: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: porticoBlackText,
              ),
            ),
          ),
        ],
        SizedBox(
          height: 1.5.h,
        ),
        if (!loading) ...[
          AutoSizeText(
            (userDetails.state == null || userDetails.country == null)
                ? ""
                : "${userDetails.state} , ${userDetails.country}",
            style: fontRoboto(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: porticoBlackTextWithOpacity5,
              ),
            ),
          ),
        ],
        SizedBox(
          height: 2.h,
        ),
        Container(
          width: 90.w,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          decoration: const BoxDecoration(
            color: porticoLightGrey,
            borderRadius: BorderRadius.all(
              Radius.circular(28),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/search.png",
              ),
              SizedBox(
                width: 65.w,
                child: TextFormField(
                  controller: jobSearchController,
                  onChanged: (value) {
                    ref
                        .read(jobDetailsControllerProvider.notifier)
                        .getJobPosted(value: value);
                  },
                  enableSuggestions: true,
                  autocorrect: false,
                  style: fontRoboto(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: porticoGrey,
                    ),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusColor: porticoGrey,
                    border: InputBorder.none,
                    hintText: "What are you looking for?",
                    hintStyle: fontRoboto(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: porticoGrey,
                      ),
                    ),
                  ),
                ),
              ),
              Image.asset(
                "assets/images/equalizer.png",
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "Your jobs",
              style: fontRoboto(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: porticoBlackText,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        if (allJobs.isEmpty) ...[
          NoRecord(
            ref: ref,
            contentName: 'Job',
          ),
        ],
        if (allJobs.isNotEmpty)
          SizedBox(
            height: 60.h,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                for (var i = 0; i < allJobs.length; i++) ...[
                  InkWell(
                    onTap: () {
                      ref
                          .read(jobApplicantsControllerProvider.notifier)
                          .getJobApplicants(allJobs[i].id!);

                      goToPage(
                          context,
                          JobApplicants(
                            jobname: "${allJobs[i].position}",
                          ));
                    },
                    child: Container(
                      width: 90.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                      decoration: const BoxDecoration(
                        color: porticoYellowWithOpacity16,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 70.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      allJobs[i].position!,
                                      // textAlign: TextAlign.center,
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: porticoBlackText,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.h, horizontal: 2.w),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(40),
                                            ),
                                          ),
                                          child: AutoSizeText(
                                            (allJobs[i].jobType! == 1)
                                                ? "Fulltime"
                                                : (allJobs[i].jobType! == 2)
                                                    ? "Remote"
                                                    : (allJobs[i].jobType! == 3)
                                                        ? "Hybrid"
                                                        : "",
                                            textAlign: TextAlign.center,
                                            style: fontRoboto(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: porticoBlackText,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.h, horizontal: 2.w),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(40),
                                            ),
                                          ),
                                          child: AutoSizeText(
                                            allJobs[i].categoryName!,
                                            textAlign: TextAlign.center,
                                            style: fontRoboto(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: porticoBlackText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Image.asset("assets/images/bookmark.png"),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 0.5,
                                  color: porticoLGrey,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 42.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              "assets/images/location.png"),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          AutoSizeText(
                                            allJobs[i].location!,
                                            style: fontRoboto(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: porticoBlackText,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 42.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                            "\$ ${allJobs[i].expectedSalary}",
                                            textAlign: TextAlign.center,
                                            style: fontRoboto(
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: porticoBlackText,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                ],
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
      ],
    );
  }

  checkDetailsState() async {
    final myState = ref.watch(userDetailsControllerProvider);
    if (myState is UserDetailsStateLaoding) {
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
      if (myState is UserDetailsStateError) {
        Future.delayed(Duration.zero, () {
          showErrorToast(context, myState.error);
          ref.read(userDetailsControllerProvider.notifier).resetState();
        });
      }

      if (myState is UserDetailsStateSuccess) {
        UserDetails success = myState.successData;
        // check authentication
        if (success.statusCode == 401) {
          Future.delayed(Duration.zero, () {
            showErrorToast(context, "User not authorized");
            ref.read(userDetailsControllerProvider.notifier).resetState();
            goToPage(context, const LoginUser());
          });
        }

        // check for errors
        if (success.statusCode == 200) {
          Future.delayed(Duration.zero, () {
            setState(() {
              userDetails = success.body!.data!;
            });
          });
        } else {
          Future.delayed(Duration.zero, () {
            showErrorToast(context, success.body!.text!);
            ref.read(userDetailsControllerProvider.notifier).resetState();
          });
        }
      }
    }
  }

  jobDetailsState() async {
    final myState = ref.watch(jobDetailsControllerProvider);
    if (myState is JobDetailsStateLaoding) {
      Future.delayed(Duration.zero, () {
        setState(() {
          jobsLoading = true;
        });
      });
    } else {
      // remove loading
      Future.delayed(Duration.zero, () {
        setState(() {
          jobsLoading = false;
        });
      });
      // state validation
      if (myState is JobDetailsStateError) {
        Future.delayed(Duration.zero, () {
          showErrorToast(context, myState.error);
          ref.read(jobDetailsControllerProvider.notifier).resetState();
        });
      }

      if (myState is JobDetailsStateSuccess) {
        JobDetailsModel success = myState.successData;
        // check authentication
        if (success.statusCode == 401) {
          Future.delayed(Duration.zero, () {
            showErrorToast(context, "User not authorized");
            ref.read(jobDetailsControllerProvider.notifier).resetState();
            goToPage(context, const LoginUser());
          });
        }

        // check for errors
        if (success.statusCode == 200) {
          Future.delayed(Duration.zero, () {
            setState(() {
              if (success.body!.data == null) {
                allJobs = [];
              } else {
                allJobs = success.body!.data!.jobs!;
              }
            });
          });
        } else {
          Future.delayed(Duration.zero, () {
            showErrorToast(context, success.body!.text!);
            ref.read(jobDetailsControllerProvider.notifier).resetState();
          });
        }
      }
    }
  }
}
