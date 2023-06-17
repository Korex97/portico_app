import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/constants/colors.dart';
import 'package:potrico/models/education_form_model.dart';
import 'package:potrico/screens/onboarding/experience_details.dart';
import 'package:potrico/screens/onboarding/personal_details.dart';
import 'package:sizer/sizer.dart';

import '../../constants/fonts.dart';
import '../../controllers/account_form_controller.dart';
import '../../controllers/details_controller.dart';
import '../../functions/general_functions.dart';
import '../../models/user_details.dart';
import '../../states/authenticated_form_states.dart';
import '../../states/user_details_state.dart';
import '../widgets/education_details_card.dart';
import '../widgets/widgets.dart';
import 'login.dart';

class EducationDetails extends ConsumerStatefulWidget {
  const EducationDetails({super.key, required this.backRoute});

  final Widget backRoute;

  @override
  ConsumerState<EducationDetails> createState() => _EducationDetailsState();
}

class _EducationDetailsState extends ConsumerState<EducationDetails> {
  final userDetailsProvider = StateProvider<List<UserEducation>>((ref) => []);
  List<UserEducation> education = [];

  bool loading = false;
  bool formLoading = false;

  TextEditingController fieldNameController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      Future.delayed(Duration.zero, () async {
        await detailsStateValidation();
        await checkDetailsState();
      });
      education = ref.read(userDetailsProvider.notifier).state;
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
                    backRoute: PersonalDetailsUpdate(
                      userType: '1',
                      backRoute: widget.backRoute,
                    ),
                    stage: 2,
                    firstImage: "assets/images/arrow-left-fill.png",
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  AutoSizeText(
                    "Education Details",
                    style: fontRoboto(
                      textStyle: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: porticoBlackText,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  AutoSizeText(
                    "FIELD NAME",
                    style: fontRoboto(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: porticoGrey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  SizedBox(
                    child: TextFormField(
                      controller: fieldNameController,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: fontRoboto(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: porticoBlack,
                        ),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: porticoLGrey,
                            width: 1.0,
                          ),
                        ),
                        focusColor: porticoGrey,
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: porticoLGrey,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: porticoGrey,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Kindly enter your field of study",
                        hintStyle: fontRoboto(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: porticoBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  AutoSizeText(
                    "SCHOOL NAME",
                    style: fontRoboto(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: porticoGrey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  SizedBox(
                    child: TextFormField(
                      controller: schoolNameController,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: fontRoboto(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: porticoBlack,
                        ),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: porticoLGrey,
                            width: 1.0,
                          ),
                        ),
                        focusColor: porticoGrey,
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: porticoLGrey,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: porticoGrey,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Name of school you attended",
                        hintStyle: fontRoboto(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: porticoBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    width: 90.w,
                    child: InkWell(
                      onTap: () {
                        if (!formLoading) {
                          addEducation();
                        }
                      },
                      child: DottedBorder(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 4.w),
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        child: Center(
                          child: (!formLoading)
                              ? AutoSizeText(
                                  "+ Add Education",
                                  textAlign: TextAlign.center,
                                  style: fontRoboto(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: gradient2,
                                    ),
                                  ),
                                )
                              : Image.asset(
                                  "assets/images/loading.gif",
                                  width: 7.w,
                                  height: 2.h,
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 30.h,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        if (education.isNotEmpty) ...[
                          for (var item in education) ...[
                            EducationDetailsCard(
                              id: item.educationId!,
                              certificate: item.certificate!,
                              university: item.schoolName!,
                              startDate: "",
                              canDelete: true,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                          ],
                          SizedBox(
                            height: 3.h,
                          )
                        ]
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () {
                      if (education.isEmpty) {
                        showErrorToast(
                            context, "Kindly add your education details");
                      } else {
                        goToPage(
                            context,
                            ExperienceDetails(
                              backRoute: widget.backRoute,
                            ));
                      }
                    },
                    child: const PotricoButton(
                      buttonText: "Next",
                    ),
                  ),
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
            if (success.body!.data!.userEducation != null) {
              ref.read(userDetailsProvider.notifier).state =
                  success.body!.data!.userEducation!;
            } else {
              ref.read(userDetailsProvider.notifier).state = [];
            }
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

  detailsStateValidation() async {
    var myState = ref.watch(accountFormControllerProvider);
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

      if (myState is AuthenticatedFormStateerror) {
        Future.delayed(Duration.zero, () {
          showErrorToast(context, myState.error);
          ref.read(accountFormControllerProvider.notifier).resetState();
        });
      }

      if (myState is AuthenticatedFormStateSuccess) {
        if (myState.successData.body!.status!) {
          showSuccessToast(context, myState.successData.body!.text!);
          ref.read(accountFormControllerProvider.notifier).resetState();
          ref.read(userDetailsControllerProvider.notifier).getDetails();
        } else {
          Future.delayed(Duration.zero, () {
            showErrorToast(
              context,
              myState.successData.body!.text!,
            );
            ref.read(accountFormControllerProvider.notifier).resetState();
          });
        }
      }
    }
  }

  addEducation() {
    if (schoolNameController.text.isEmpty || fieldNameController.text.isEmpty) {
      showErrorToast(context, "Enter all fields");
    } else {
      EducationForm education =
          EducationForm(schoolNameController.text, fieldNameController.text);
      ref
          .read(accountFormControllerProvider.notifier)
          .updateEducationDetails(education);
    }
  }
}
