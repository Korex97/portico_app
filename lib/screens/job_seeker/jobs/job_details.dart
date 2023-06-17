import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/screens/job_seeker/navigation/navigation.dart';
import 'package:potrico/screens/job_seeker/resume/add_resume.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/job_fulldetails_controllers.dart';
import '../../../functions/general_functions.dart';
import '../../../models/job_full_details_model.dart';
import '../../../services/base_url.dart';
import '../../../states/job_details_state.dart';
import '../../onboarding/login.dart';
import '../../widgets/loading_screen.dart';
import '../../widgets/widgets.dart';

class JobDetails extends ConsumerStatefulWidget {
  const JobDetails({super.key, required this.pageFron});

  final int pageFron;

  @override
  ConsumerState<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends ConsumerState<JobDetails> {
  // The rating value
  double? ratingValue = 4.5;
  bool toggleButton = true;

  final jobDetailsProvider =
      StateProvider<JobFullDetails>((ref) => JobFullDetails());

  JobFullDetails jobDetails = JobFullDetails();
  bool loading = false;
  List reviews = [];

  List<String> str = [
    "Lorem Ipsum is simply dummy text.",
    "Lorem Ipsum is simply dummy text. Lorem Ipsum has been the industry's standard",
    "Lorem Ipsum is simply.",
    "Lorem Ipsum has been the industry's Lorem Ipsum is simply dummy text.",
    "Lorem Ipsum has been the industry's standard.",
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      Future.delayed(Duration.zero, () async {
        await jobDetailsState();
      });
      jobDetails = ref.read(jobDetailsProvider.notifier).state;
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
                  HeadStyle(
                    backRoute: JobSeekerNavigation(
                      page: widget.pageFron,
                    ),
                    firstImage: "assets/images/arrow-left-fill.png",
                    lastImage: "assets/images/bookmark-fill.png",
                  ),
                  if (loading) ...[
                    const LoadingWidget(),
                  ] else ...[
                    if (jobDetails.id != null) ...[
                      SizedBox(
                        height: 3.h,
                      ),
                      Center(
                        child: (jobDetails.employerPic!.isNotEmpty)
                            ? CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 6.h,
                                backgroundImage: NetworkImage(
                                  "${BaseUrl.imageUrl}${jobDetails.employerPic}",
                                ),
                              )
                            : Image.asset("assets/images/twitter_icon.png"),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              "${jobDetails.position} at ${jobDetails.companyName}",
                              style: fontRoboto(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: porticoBlackText,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  jobDetails.location!,
                                  style: fontRoboto(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: porticoGrey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                const CircleAvatar(
                                  backgroundColor: porticoGrey,
                                  radius: 4,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                AutoSizeText(
                                  jobDetails.categoryName!,
                                  style: fontRoboto(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: porticoGrey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.5.h, horizontal: 3.w),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              color: porticoLightGreyBorder, width: 1),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 25.w,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: porticoMidGrey, width: 1))),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      jobDetails.jobTypeValue!,
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: porticoBlack,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    AutoSizeText(
                                      "Job type",
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: porticoGrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 25.w,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: porticoMidGrey, width: 1))),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      "\$ ${jobDetails.expectedSalary}",
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: porticoBlack,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    AutoSizeText(
                                      "Salary",
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: porticoGrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25.w,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      jobDetails.experienceLevel!,
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: porticoBlack,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    AutoSizeText(
                                      "Experience",
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: porticoGrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 2.w),
                        decoration: const BoxDecoration(
                          color: porticoLightGreyBorder,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  toggleButton = !toggleButton;
                                });
                              },
                              child: Container(
                                width: 40.w,
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 2.w),
                                decoration: BoxDecoration(
                                  color: (toggleButton)
                                      ? porticoBlackText
                                      : Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Center(
                                  child: AutoSizeText(
                                    "Description",
                                    style: fontRoboto(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: (toggleButton)
                                            ? white
                                            : porticoBlackText,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  toggleButton = !toggleButton;
                                });
                              },
                              child: Container(
                                width: 40.w,
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 2.w),
                                decoration: BoxDecoration(
                                  color: (!toggleButton)
                                      ? porticoBlackText
                                      : Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Center(
                                  child: AutoSizeText(
                                    "Reviews",
                                    style: fontRoboto(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: (!toggleButton)
                                            ? white
                                            : porticoBlackText,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      if (toggleButton)
                        SizedBox(
                          width: 90.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                "Details",
                                style: fontRoboto(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: porticoBlack,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              SizedBox(
                                width: 90.w,
                                child: AutoSizeText(
                                  "${jobDetails.companyBio}",
                                  style: fontRoboto(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: porticoGrey,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              AutoSizeText(
                                "Requirements",
                                style: fontRoboto(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: porticoBlack,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              SizedBox(
                                width: 90.w,
                                child: AutoSizeText(
                                  "${jobDetails.requirements}",
                                  style: fontRoboto(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: porticoGrey,
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: 90.w,
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: str.map((strone) {
                              //       return Column(
                              //         children: [
                              //           Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.start,
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.center,
                              //             children: [
                              //               const Text(
                              //                 "\u2022",
                              //                 style: TextStyle(
                              //                     fontSize: 15,
                              //                     color: porticoGrey),
                              //               ),
                              //               SizedBox(
                              //                 width: 2.w,
                              //               ),
                              //               SizedBox(
                              //                 width: 80.w,
                              //                 child: AutoSizeText(
                              //                   strone,
                              //                   style: fontRoboto(
                              //                     textStyle: const TextStyle(
                              //                       fontSize: 14,
                              //                       fontWeight: FontWeight.w400,
                              //                       color: porticoBlack,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //           SizedBox(
                              //             height: 1.5.h,
                              //           )
                              //         ],
                              //       );
                              //     }).toList(),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      if (!toggleButton)
                        SizedBox(
                          width: 90.w,
                          height: 50.h,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              if (reviews.isEmpty) ...[
                                NoRecord(
                                  ref: ref,
                                  contentName: "reviews for this jobs",
                                  showButton: false,
                                )
                              ] else ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                          "assets/images/review_image1.png"),
                                    ),
                                    SizedBox(
                                      width: 70.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            "Cody Fisher",
                                            style: fontRoboto(
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: porticoBlackText,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          RatingBar(
                                              initialRating: ratingValue!,
                                              itemSize: 20,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              ratingWidget: RatingWidget(
                                                  full: const Icon(Icons.star,
                                                      color: Colors.orange),
                                                  half: const Icon(
                                                    Icons.star_half,
                                                    color: Colors.orange,
                                                  ),
                                                  empty: const Icon(
                                                    Icons.star_outline,
                                                    color: Colors.orange,
                                                  )),
                                              onRatingUpdate: (value) {}),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          SizedBox(
                                            width: 60.w,
                                            child: AutoSizeText(
                                              "Lorem Ipsum has been the industry's stand ard.Lorem Ipsum has been the industry's standard.",
                                              style: fontRoboto(
                                                textStyle: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: porticoGrey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                          "assets/images/review_image1.png"),
                                    ),
                                    SizedBox(
                                      width: 70.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            "Cody Fisher",
                                            style: fontRoboto(
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: porticoBlackText,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          RatingBar(
                                              initialRating: ratingValue!,
                                              itemSize: 20,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              ratingWidget: RatingWidget(
                                                  full: const Icon(Icons.star,
                                                      color: Colors.orange),
                                                  half: const Icon(
                                                    Icons.star_half,
                                                    color: Colors.orange,
                                                  ),
                                                  empty: const Icon(
                                                    Icons.star_outline,
                                                    color: Colors.orange,
                                                  )),
                                              onRatingUpdate: (value) {}),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          SizedBox(
                                            width: 60.w,
                                            child: AutoSizeText(
                                              "Lorem Ipsum has been the industry's stand ard.Lorem Ipsum has been the industry's standard.",
                                              style: fontRoboto(
                                                textStyle: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: porticoGrey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                          "assets/images/review_image1.png"),
                                    ),
                                    SizedBox(
                                      width: 70.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            "Cody Fisher",
                                            style: fontRoboto(
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: porticoBlackText,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          RatingBar(
                                              initialRating: ratingValue!,
                                              itemSize: 20,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              ratingWidget: RatingWidget(
                                                  full: const Icon(Icons.star,
                                                      color: Colors.orange),
                                                  half: const Icon(
                                                    Icons.star_half,
                                                    color: Colors.orange,
                                                  ),
                                                  empty: const Icon(
                                                    Icons.star_outline,
                                                    color: Colors.orange,
                                                  )),
                                              onRatingUpdate: (value) {}),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          SizedBox(
                                            width: 60.w,
                                            child: AutoSizeText(
                                              "Lorem Ipsum has been the industry's stand ard.Lorem Ipsum has been the industry's standard.",
                                              style: fontRoboto(
                                                textStyle: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: porticoGrey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 6.h,
                      ),
                      PotricoButton(buttonText: "Apply for this job", route: (jobDetails.id != null)? AddResume(jobId: jobDetails.id!, role: jobDetails.position!, company: jobDetails.companyName!): null,)
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

  jobDetailsState() async {
    final myState = ref.watch(jobFullDetailsControllerProvider);
    if (myState is JobFullDetailsStateLaoding) {
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
      if (myState is JobFullDetailsStateError) {
        Future.delayed(Duration.zero, () {
          showErrorToast(context, myState.error);
          ref.read(jobFullDetailsControllerProvider.notifier).resetState();
        });
      }

      if (myState is JobFullDetailsStateSuccess) {
        JobFullDetailsModel success = myState.successData;
        // check authentication
        if (success.statusCode == 401) {
          Future.delayed(Duration.zero, () {
            showErrorToast(context, "User not authorized");
            ref.read(jobFullDetailsControllerProvider.notifier).resetState();
            goToPage(context, const LoginUser());
          });
        }

        // check for errors
        if (success.statusCode == 200) {
          Future.delayed(Duration.zero, () {
            if (success.body!.status!) {
              ref.read(jobDetailsProvider.notifier).state =
                  success.body!.data!.jobs!;
            } else {
              ref.read(jobDetailsProvider.notifier).state = JobFullDetails();
            }
          });
        } else {
          Future.delayed(Duration.zero, () {
            showErrorToast(context, success.body!.text!);
            ref.read(jobFullDetailsControllerProvider.notifier).resetState();
          });
        }
      }
    }
  }
}
