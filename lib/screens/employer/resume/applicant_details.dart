import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/models/change_status_model.dart';
import 'package:potrico/screens/employer/navigationbar/navigation_bar.dart';
import 'package:potrico/states/applicant_details_state.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/applicant_details_controller.dart';
import '../../../controllers/applicant_status_controller.dart';
import '../../../controllers/job_applicants_controller.dart';
import '../../../functions/general_functions.dart';
import '../../../models/applicant_details_model.dart';
import '../../../models/authenticated_form.dart';
import '../../../services/base_url.dart';
import '../../../states/authenticated_form_states.dart';
import '../../onboarding/login.dart';
import '../../widgets/widgets.dart';

class ApplicantDetails extends ConsumerStatefulWidget {
  const ApplicantDetails({super.key});

  @override
  ConsumerState<ApplicantDetails> createState() => _ApplicantDetailsState();
}

class _ApplicantDetailsState extends ConsumerState<ApplicantDetails> {
  ApplicantData? applicantDetails = ApplicantData();
  bool loading = false;
  bool formLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        Future.delayed(Duration.zero, () {
          stateValidation();
          checkFormState();
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
                      backRoute: Navigation(
                        page: 1,
                      ),
                      firstImage: "assets/images/arrow-left-fill.png",
                      lastImage: null,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    if (loading) ...[
                      Center(
                        child: Image.asset(
                          "assets/images/dot-loader.gif",
                        ),
                      ),
                    ] else ...[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (applicantDetails != null &&
                                  applicantDetails!.profilePic == null) ...[
                                CircleAvatar(
                                  radius: 50,
                                  foregroundColor: Colors.transparent,
                                  child: Image.asset(
                                      "assets/images/applicant.png"),
                                ),
                              ] else if (applicantDetails!
                                  .profilePic!.isEmpty) ...[
                                CircleAvatar(
                                  radius: 50,
                                  foregroundColor: Colors.transparent,
                                  child: Image.asset(
                                      "assets/images/applicant.png"),
                                ),
                              ] else ...[
                                CircleAvatar(
                                  radius: 50,
                                  foregroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                      "${BaseUrl.imageUrl}${applicantDetails!.profilePic}"),
                                ),
                              ],
                              SizedBox(
                                height: 3.h,
                              ),
                              AutoSizeText(
                                (applicantDetails != null &&
                                        applicantDetails!.fullname != null)
                                    ? applicantDetails!.fullname!
                                    : "",
                                style: fontRoboto(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: porticoApplicantText,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              AutoSizeText(
                                (applicantDetails != null &&
                                        applicantDetails!.email != null)
                                    ? applicantDetails!.email!
                                    : "",
                                style: fontRoboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: porticoApplicantDetailsText,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              AutoSizeText(
                                (applicantDetails != null &&
                                        applicantDetails!.state != null &&
                                        applicantDetails!.city != null &&
                                        applicantDetails!.country != null)
                                    ? "${applicantDetails!.city!}, ${applicantDetails!.state!}  ${applicantDetails!.country!}"
                                    : "",
                                textAlign: TextAlign.center,
                                style: fontRoboto(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: porticoApplicantText,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (applicantDetails != null &&
                                          applicantDetails!.phoneno != null &&
                                          applicantDetails!.phoneno != "") {
                                            sendMessage(
                                            applicantDetails!.phoneno!);
                                          }
                                    },
                                    child: Container(
                                      width: 40.w,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.h, horizontal: 3.w),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(38),
                                        ),
                                        color: porticoBlackText,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset("assets/images/chat.png"),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          AutoSizeText(
                                            "Message",
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
                                  InkWell(
                                    onTap: () {
                                      if (applicantDetails != null &&
                                          applicantDetails!.phoneno != null &&
                                          applicantDetails!.phoneno != "") {
                                        makePhoneCall(
                                            applicantDetails!.phoneno!);
                                      }
                                    },
                                    child: Container(
                                      width: 40.w,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.h, horizontal: 3.w),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(38),
                                        ),
                                        color: porticoBlackText,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              "assets/images/phone-fill.png"),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          AutoSizeText(
                                            "Call Now",
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
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.5.h,
                      ),
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
                          color: white,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/map-pin.png"),
                                SizedBox(
                                  width: 2.w,
                                ),
                                AutoSizeText(
                                  (applicantDetails != null &&
                                          applicantDetails!.location != null)
                                      ? applicantDetails!.location!
                                      : "",
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/phone-fill.png",
                                  color: porticoGrey,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                AutoSizeText(
                                  (applicantDetails != null &&
                                          applicantDetails!.phoneno != null)
                                      ? applicantDetails!.phoneno!
                                      : "",
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/phone-fill.png",
                                  color: porticoGrey,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                AutoSizeText(
                                  (applicantDetails != null &&
                                          applicantDetails!.phoneno != null)
                                      ? applicantDetails!.phoneno!
                                      : "",
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
                      if (applicantDetails == null ||
                          applicantDetails!.userEducation == null ||
                          applicantDetails!.userEducation!.isEmpty) ...[
                        NoRecord(
                          ref: ref,
                          contentName: "No Education added",
                          showButton: false,
                        )
                      ] else ...[
                        for (var element
                            in applicantDetails!.userEducation!) ...[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 5.w),
                            decoration: const BoxDecoration(
                              color: white,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                    vertical: 1.h,
                                  ),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: porticoBlueWithOpacity8,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                        "assets/images/bank-fill.png"),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 60.w,
                                      child: AutoSizeText(
                                        element.certificate!,
                                        style: fontRoboto(
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: porticoBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    SizedBox(
                                      width: 60.w,
                                      child: AutoSizeText(
                                        element.schoolName!,
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
                                      height: 1.5.h,
                                    ),
                                    SizedBox(
                                      width: 60.w,
                                      child: AutoSizeText(
                                        element.endDate!,
                                        style: fontRoboto(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: porticoGrey,
                                          ),
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
                        ],
                      ],
                      SizedBox(
                        height: 1.h,
                      ),
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
                      if (applicantDetails == null ||
                          applicantDetails!.userEducation == null ||
                          applicantDetails!.userEducation!.isEmpty) ...[
                        NoRecord(
                          ref: ref,
                          contentName: "No Experience added",
                          showButton: false,
                        )
                      ] else ...[
                        for (var element
                            in applicantDetails!.userExperience!) ...[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 5.w),
                            decoration: const BoxDecoration(
                              color: white,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                    vertical: 1.h,
                                  ),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: porticoBlueWithOpacity8,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                        "assets/images/business.png"),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 60.w,
                                      child: AutoSizeText(
                                        element.role!,
                                        style: fontRoboto(
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: porticoBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    SizedBox(
                                      width: 60.w,
                                      child: AutoSizeText(
                                        element.company!,
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
                                      height: 1.5.h,
                                    ),
                                    SizedBox(
                                      width: 60.w,
                                      child: AutoSizeText(
                                        "${element.startDate}  |  ${element.endDate!}",
                                        style: fontRoboto(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: porticoGrey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                        ],
                      ],
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: (applicantDetails != null &&
                                applicantDetails!.status != null &&
                                applicantDetails!.status! != 0)
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (applicantDetails != null &&
                              applicantDetails!.status != null &&
                              (applicantDetails!.status == 0 ||
                                  applicantDetails!.status == 2)) ...[
                            InkWell(
                              onTap: () {
                                if (!formLoading) {
                                  approveOrDecline(applicantDetails!.id!, 1);
                                }
                              },
                              child: SizedBox(
                                width: (applicantDetails!.status! != 0)
                                    ? 60.w
                                    : 43.w,
                                child: Button(
                                  buttonText: "Accept",
                                  horizontalPadding: 2.w,
                                  verticalPadding: 2.h,
                                  borderRadius: 12,
                                  bgColor: porticoPinkWithOpacity15,
                                  txtColor: porticoPink,
                                  showloading: formLoading,
                                ),
                              ),
                            ),
                          ],
                          if (applicantDetails != null &&
                              applicantDetails!.status != null &&
                              (applicantDetails!.status == 0 ||
                                  applicantDetails!.status == 1)) ...[
                            InkWell(
                              onTap: () {
                                if (!formLoading) {
                                  approveOrDecline(applicantDetails!.id!, 2);
                                }
                              },
                              child: SizedBox(
                                width: (applicantDetails!.status! != 0)
                                    ? 60.w
                                    : 43.w,
                                child: Button(
                                  buttonText: "Cancel",
                                  horizontalPadding: 2.w,
                                  verticalPadding: 2.h,
                                  borderRadius: 12,
                                  bgColor: porticoPink,
                                  txtColor: white,
                                  showloading: formLoading,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
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

  approveOrDecline(String id, int status) {
    var applicant = ChangeStatusModel(id, status);
    ref
        .read(applicantStatusControllerProvider.notifier)
        .changeApplicantStatus(applicant);
  }

  stateValidation() {
    var state = ref.watch(applicantDetailsControllerProvider);
    if (state is ApplicantDetailsStateLaoding) {
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
      if (state is ApplicantDetailsStateError) {
        Future.delayed(Duration.zero, () {
          showErrorToast(context, state.error);
          ref.read(applicantDetailsControllerProvider.notifier).resetState();
        });
      }

      if (state is ApplicantDetailsStateSuccess) {
        ApplicantDetailsModel success = state.successData;
        // check authentication
        if (success.statusCode == 401) {
          Future.delayed(Duration.zero, () {
            showErrorToast(context, "User not authorized");
            ref.read(applicantDetailsControllerProvider.notifier).resetState();
            goToPage(context, const LoginUser());
          });
        }

        // check for errors
        if (success.statusCode == 200) {
          if (success.body!.status != null && success.body!.status!) {
            setState(() {
              applicantDetails = success.body!.data!;
            });
          } else {
            setState(() {
              applicantDetails = ApplicantData();
            });
          }
        } else {
          Future.delayed(Duration.zero, () {
            showErrorToast(context, success.body!.text!);
            ref.read(applicantDetailsControllerProvider.notifier).resetState();
          });
        }
      }
    }
  }

  checkFormState() {
    var myState = ref.watch(applicantStatusControllerProvider);
    if (myState is AuthenticatedFormStateLaoding) {
      Future.delayed(Duration.zero, () {
        setState(() {
          formLoading = true;
        });
      });
    } else {
      Future.delayed(Duration.zero, () {
        setState(() {
          formLoading = false;
        });
      });
    }

    if (myState is AuthenticatedFormStateerror) {
      Future.delayed(Duration.zero, () {
        showErrorToast(context, myState.error);
        ref.read(applicantStatusControllerProvider.notifier).resetState();
      });
    }

    if (myState is AuthenticatedFormStateSuccess) {
      AuthenticatedForm success = myState.successData;
      // check authentication
      if (success.statusCode == 401) {
        showErrorToast(context, "User not authorized");
        ref.read(applicantStatusControllerProvider.notifier).resetState();
        goToPage(context, const LoginUser());
      }

      // check for errors
      if (success.statusCode == 200) {
        showSuccessToast(context, success.body!.text!);
        ref.read(applicantStatusControllerProvider.notifier).resetState();
        ref
            .read(jobApplicantsControllerProvider.notifier)
            .getEmployerJobApplicants();
        goToPage(context, const Navigation(page: 1));
      } else {
        Future.delayed(Duration.zero, () {
          showErrorToast(context, success.body!.text!);
          ref.read(applicantStatusControllerProvider.notifier).resetState();
        });
      }
    }
  }
}
