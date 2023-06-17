import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/functions/general_functions.dart';
import 'package:potrico/screens/job_seeker/navigation/navigation.dart';
import 'package:potrico/screens/job_seeker/profile/profile_details.dart';
import 'package:potrico/screens/job_seeker/resume/my_resume.dart';
import 'package:potrico/screens/onboarding/login.dart';
import 'package:potrico/store/jobs_available.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/details_controller.dart';
import '../../../models/user_details.dart';
import '../../../services/base_url.dart';
import '../../../states/user_details_state.dart';
import '../../widgets/loading_screen.dart';
import '../../widgets/widgets.dart';

class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({super.key});

  @override
  ConsumerState<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  final userDetailsProvider = StateProvider<UserData>((ref) => UserData());
  UserData userDetails = UserData();

  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    insert();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      Future.delayed(Duration.zero, () async {
        await checkDetailsState();
      });
      userDetails = ref.read(userDetailsProvider.notifier).state;
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeadStyle(
              firstImage: "assets/images/menu.png",
              lastImage: "assets/images/edit-2-fill.png",
            ),
            SizedBox(
              height: 3.h,
            ),
            if (loading) ...[
              const LoadingWidget(),
            ] else ...[
              if (userDetails.id != null) ...[
                Center(
                  child: (userDetails.profilePic!.isNotEmpty)
                      ? CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 6.h,
                          backgroundImage: NetworkImage(
                            "${BaseUrl.imageUrl}${userDetails.profilePic}",
                          ),
                        )
                      : Image.asset("assets/images/applicant.png"),
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
                        // userDetails.fullname!,
                        applicants.name,
                        textAlign: TextAlign.center,
                        style: fontRoboto(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: porticoBlackText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: AutoSizeText(
                          userDetails.email!,
                          style: fontRoboto(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: porticoApplicantDetailsText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              width: 90.w,
              height: 70.h,
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  InkWell(
                    onTap: () => goToPage(
                      context,
                      const ProfileDetails(),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.5.h, horizontal: 2.w),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: porticoLGrey,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 60.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 4.w),
                                  decoration: const BoxDecoration(
                                    color: porticoLightPink,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/bank-fill.png",
                                      color: porticoPink,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                AutoSizeText(
                                  "Profile",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                  "assets/images/arrow-right-s-line.png"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => goToPage(
                      context,
                      const JobSeekerNavigation(
                        page: 2,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.5.h, horizontal: 2.w),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: porticoLGrey,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 60.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 4.w),
                                  decoration: const BoxDecoration(
                                    color: porticoLightPink,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/briefcase-fill.png",
                                      color: porticoPink,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                AutoSizeText(
                                  "My Applied Jobs",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                  "assets/images/arrow-right-s-line.png"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: porticoLGrey,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 4.w),
                                decoration: const BoxDecoration(
                                  color: porticoLightPink,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/bookmark.png",
                                    color: porticoPink,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              AutoSizeText(
                                "Saved Jobs",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/arrow-right-s-line.png"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      goToPage(
                        context,
                        const JobSeekerResume(),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.5.h, horizontal: 2.w),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: porticoLGrey,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 60.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 4.w),
                                  decoration: const BoxDecoration(
                                    color: porticoLightPink,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/document.png",
                                      color: porticoPink,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                AutoSizeText(
                                  "My Resume",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                  "assets/images/arrow-right-s-line.png"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => goToPage(context, const LoginUser()),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.5.h, horizontal: 2.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 60.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 4.w),
                                  decoration: const BoxDecoration(
                                    color: porticoLightPink,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/exit.png",
                                      color: porticoPink,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                AutoSizeText(
                                  "Sign Out",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                  "assets/images/arrow-right-s-line.png"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]);
    });
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

  void insert() {
    applicants.name = "Ori iru Arin";
    applicants.dateOfBirth = "6th, July 200BC";
    applicants.education = [
      "Sow the seeds",
      "Loyola",
      "Futa",
      "School of Responsibility"
    ];
    applicants.experience = ["TopTech", "NYSC", "Teesas"];
    applicants.maritalStatus = 6;
    applicants.resume = File("");
    applicants.address = "Currently homeless";
  }

  void getDetails() {
    String applicantName = applicants.name;
    String dob = applicants.dateOfBirth;
    String address = applicants.address;
    File resume = applicants.resume;
    List<String> educations = applicants.education;
    List<String> experience = applicants.experience;
  }
}
