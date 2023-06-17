import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/screens/job_seeker/navigation/navigation.dart';
import 'package:potrico/screens/widgets/loading_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/cities_controller.dart';
import '../../../controllers/countries_controller.dart';
import '../../../controllers/details_controller.dart';
import '../../../controllers/states_controller.dart';
import '../../../functions/general_functions.dart';
import '../../../models/user_details.dart';
import '../../../services/base_url.dart';
import '../../../states/user_details_state.dart';
import '../../onboarding/login.dart';
import '../../onboarding/personal_details.dart';
import '../../widgets/education_details_card.dart';
import '../../widgets/experience_details.dart';
import '../../widgets/widgets.dart';

class ProfileDetails extends ConsumerStatefulWidget {
  const ProfileDetails({super.key});

  @override
  ConsumerState<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends ConsumerState<ProfileDetails> {
  final userDetailsProvider = StateProvider<UserData>((ref) => UserData());
  UserData userDetails = UserData();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      Future.delayed(Duration.zero, () async {
        await checkDetailsState();
      });
      userDetails = ref.read(userDetailsProvider.notifier).state;
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
                    backRoute: JobSeekerNavigation(
                      page: 3,
                    ),
                    firstImage: "assets/images/arrow-left-fill.png",
                    lastImage: null,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  if (loading) ...[
                    SizedBox(
                      height: 4.h,
                    ),
                    const LoadingWidget(),
                  ] else ...[
                    if (userDetails.id != null) ...[
                      SizedBox(
                        height: 80.h,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
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
                                    userDetails.fullname!,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.w),
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
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: SizedBox(
                                width: 85.w,
                                child: AutoSizeText(
                                  "${userDetails.city!}, ${userDetails.state!}  ${userDetails.country!}",
                                  textAlign: TextAlign.center,
                                  style: fontRoboto(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: porticoApplicantDetailsText,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  ref.read(countriesControllerProvider.notifier).getAllCountries();
                                  if ( userDetails.country != null ){
                                    if ( userDetails.country!.isNotEmpty ) {
                                      ref
                                      .read(
                                          statesControllerProvider.notifier)
                                      .getAllStates(userDetails.country!);
                                    }
                                  }
                                  if ( userDetails.state != null ){
                                    if ( userDetails.state!.isNotEmpty ) {
                                      ref
                                      .read(
                                          citiesControllerProvider.notifier)
                                      .getAllCities(userDetails.state!);
                                    }
                                  }
                                  goToPage(context, PersonalDetailsUpdate(userType: userDetails.userType!, editRoute: true, backRoute: const ProfileDetails(),));
                                },
                                child: Container(
                                  width: 30.w,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7.w, vertical: 1.h),
                                  decoration: const BoxDecoration(
                                    color: porticoBlackText,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(38),
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/edit-2-fill.png",
                                          color: white,
                                        ),
                                        AutoSizeText(
                                          "Edit",
                                          textAlign: TextAlign.center,
                                          style: fontRoboto(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  "Applicant Info",
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
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 5.w),
                                  decoration: const BoxDecoration(
                                    color: porticoLGreen,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: porticoBlackTextWithOpacity2,
                                          offset: Offset.zero,
                                          spreadRadius: 1,
                                          blurRadius: 8),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/map-pin.png",
                                            color: porticoGreen,
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          AutoSizeText(
                                            userDetails.location!,
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
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/phone-fill.png",
                                            color: porticoGreen,
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          AutoSizeText(
                                            userDetails.phoneno!,
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
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Image.asset(
                                          //   "assets/images/phone-fill.png",
                                          //   color: porticoGreen,
                                          // ),
                                          const Icon(
                                            Icons.email,
                                            color: porticoGreen,
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          AutoSizeText(
                                            userDetails.email!,
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
                                  height: 2.h,
                                ),
                                AutoSizeText(
                                  "Education Details",
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
                                if (userDetails.userEducation!.isEmpty) ...[
                                  NoRecord(
                                    ref: ref,
                                    contentName: "education details",
                                    showButton: false,
                                  )
                                ] else ...[
                                  for (var item
                                      in userDetails.userEducation!) ...[
                                    EducationDetailsCard(
                                      certificate: item.certificate!,
                                      id: item.educationId!,
                                      startDate: "",
                                      university: item.schoolName!,
                                    ),
                                    SizedBox(
                                      height: 2.5.h,
                                    ),
                                  ]
                                ],
                                AutoSizeText(
                                  "Work Experience",
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
                                if (userDetails.userExperience!.isEmpty) ...[
                                  NoRecord(
                                    ref: ref,
                                    contentName: "experience details",
                                    showButton: false,
                                  )
                                ] else ...[
                                  for (var item
                                      in userDetails.userExperience!) ...[
                                    ExperienceDetailsCard(
                                        firmName: item.company!,
                                        role: item.role!,
                                        startDate: item.startDate!,
                                        endDate: item.endDate!,
                                        duration: item.duration!,
                                        id: item.experienceId!),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                ],
                                SizedBox(
                                  height: 5.h,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ]
                  ],
                ],
              ),
            ),
          ),
        ),
      );
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
}
