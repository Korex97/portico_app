import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/functions/general_functions.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/details_controller.dart';
import '../../../controllers/job_category_controller.dart';
import '../../../controllers/jobs_details_controller.dart';
import '../../../models/job_category.dart';
import '../../../models/job_details_model.dart';
import '../../../models/user_details.dart';
import '../../../states/job_category_state.dart';
import '../../../states/jobs_states.dart';
import '../../../states/user_details_state.dart';
import '../../onboarding/login.dart';
import '../../widgets/loading_screen.dart';
import '../../widgets/widgets.dart';
import '../components/job_card.dart';
import '../notifications/notifications.dart';

class JobSeekerJobs extends ConsumerStatefulWidget {
  const JobSeekerJobs({super.key});

  @override
  ConsumerState<JobSeekerJobs> createState() => _JobSeekerJobsState();
}

class _JobSeekerJobsState extends ConsumerState<JobSeekerJobs> {
  final TextEditingController jobSearchController = TextEditingController();
  final userDetailsProvider = StateProvider<UserData>((ref) => UserData());
  final jobProvider = StateProvider<List<Jobs>>((ref) => []);
  final categoriesProvider = StateProvider<List<Categories>>((ref) => []);
  List<Jobs> allJobs = [];
  List<Categories> allCategories = [];
  bool jobsLoading = true;
  bool categoryLoading = false;
  bool loading = false;
  UserData userDetails = UserData();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      Future.delayed(Duration.zero, () async {
        await checkDetailsState();
        await jobCategory();
        await jobDetailsState();
      });
      userDetails = ref.read(userDetailsProvider.notifier).state;
      allJobs = ref.read(jobProvider.notifier).state;
      allCategories = ref.read(categoriesProvider.notifier).state;
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
                    firstImage: "assets/images/menu.png",
                    lastImage: "assets/images/notification.png",
                    route: AllNotifications(),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  AutoSizeText(
                    (userDetails.fullname != null) ? userDetails.fullname! : "",
                    style: fontRoboto(
                      textStyle: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: porticoBlackText,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  AutoSizeText(
                    (userDetails.city != null &&
                            userDetails.state != null &&
                            userDetails.country != null)
                        ? "${userDetails.city!} ${userDetails.state!}, ${userDetails.country!}"
                        : "",
                    style: fontRoboto(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: porticoBlackTextWithOpacity5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    width: 90.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
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
                        InkWell(
                          onTap: () async {
                            await showFilterModal(context, allCategories);
                          },
                          child: Image.asset(
                            "assets/images/equalizer.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  if (jobsLoading) ...[
                    const LoadingWidget(),
                  ] else ...[
                    if (allJobs.isEmpty) ...[
                      NoRecord(
                        ref: ref,
                        contentName: "jobs",
                        showButton: false,
                      )
                    ] else ...[
                      SizedBox(
                        height: 60.h,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            for (var element in allJobs) ...[
                              JobCard(
                                jobCategory: element.categoryName!,
                                jobId: element.id!,
                                jobName: element.position!,
                                jobType: element.jobType!,
                                location: element.location!,
                                salary: element.expectedSalary!,
                                ref: ref,
                                pageOn: 0,
                              ),
                              SizedBox(
                                height: 2.5.h,
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
    });
  }

  // state validation areas
  jobCategory() async {
    var state = ref.watch(jobCategoryControllerProvider);
    if (state is JobCategoryStateLaoding) {
      Future.delayed(Duration.zero, () {
        setState(() {
          categoryLoading = true;
        });
      });
    } else {
      // remove loading
      Future.delayed(Duration.zero, () {
        setState(() {
          categoryLoading = false;
        });
      });
      // state validation
      if (state is JobCategoryStateError) {
        Future.delayed(Duration.zero, () {
          showErrorToast(context, state.error);
          ref.read(jobCategoryControllerProvider.notifier).resetState();
        });
      }

      if (state is JobCategoryStateSuccess) {
        JobCategories success = state.successData;

        // check for errors
        if (success.status!) {
          ref.read(categoriesProvider.notifier).state =
              success.data!.categories!;
        } else {
          ref.read(categoriesProvider.notifier).state = [];
        }
      }
    }
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
            ref.read(userDetailsProvider.notifier).state = success.body!.data!;
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
            if (success.body!.status!) {
              ref.read(jobProvider.notifier).state = success.body!.data!.jobs!;
            } else {
              ref.read(jobProvider.notifier).state = [];
            }
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
