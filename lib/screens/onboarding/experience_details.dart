import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/constants/colors.dart';
import 'package:potrico/constants/fonts.dart';
import 'package:potrico/models/experience_form.dart';
import 'package:potrico/screens/onboarding/education_details.dart';
import 'package:potrico/screens/onboarding/login.dart';
import 'package:potrico/screens/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/account_form_controller.dart';
import '../../controllers/details_controller.dart';
import '../../functions/general_functions.dart';
import '../../models/user_details.dart';
import '../../states/authenticated_form_states.dart';
import '../../states/user_details_state.dart';
import '../job_seeker/navigation/navigation.dart';
import '../widgets/experience_details.dart';
import 'signup.dart';

class ExperienceDetails extends ConsumerStatefulWidget {
  const ExperienceDetails({super.key, this.backRoute = const SignUp()});

  final Widget backRoute;

  @override
  ConsumerState<ExperienceDetails> createState() => _ExperienceDetailsState();
}

class _ExperienceDetailsState extends ConsumerState<ExperienceDetails> {
  final userDetailsProvider = StateProvider<List<UserExperience>>((ref) => []);
  List<UserExperience> experience = [];
  TextEditingController fieldNameController = TextEditingController();
  TextEditingController industryController = TextEditingController();

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2023, 1),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          (selectedStartDate != null) ? selectedStartDate! : DateTime(2023, 1),
      firstDate:
          (selectedStartDate != null) ? selectedStartDate! : DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedEndDate = picked;
      });
    }
  }

  bool loading = false;
  bool formLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      Future.delayed(Duration.zero, () async {
        await detailsStateValidation();
        await checkDetailsState();
      });
      experience = ref.read(userDetailsProvider.notifier).state;
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
                    backRoute: EducationDetails(
                      backRoute: widget.backRoute,
                    ),
                    stage: 3,
                    firstImage: "assets/images/arrow-left-fill.png",
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  AutoSizeText(
                    "Experience Details",
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
                        hintText: "Enter your role in the company",
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
                    "COMPANY / INDUSTRY",
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
                      controller: industryController,
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
                        hintText: "Enter the company name",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 43.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "START DATE",
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
                            InkWell(
                              onTap: () {
                                selectDate(context);
                              },
                              child: Container(
                                width: 43.w,
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 3.w),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    border: Border.all(
                                      color: porticoLGrey,
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (selectedStartDate != null)
                                          ? "${selectedStartDate!.toLocal()}"
                                              .split(' ')[0]
                                          : "YYYY-MM-DD",
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: porticoGrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 43.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "END DATE",
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
                            InkWell(
                              onTap: () {
                                selectEndDate(context);
                              },
                              child: Container(
                                width: 43.w,
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 3.w),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    border: Border.all(
                                      color: porticoLGrey,
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (selectedEndDate != null)
                                          ? (calculateDifference(
                                                      selectedEndDate!) ==
                                                  0)
                                              ? "present"
                                              : "${selectedEndDate!.toLocal()}"
                                                  .split(' ')[0]
                                          : "YYYY-MM-DD",
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: porticoGrey,
                                        ),
                                      ),
                                    ),
                                  ],
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
                  SizedBox(
                    width: 90.w,
                    child: InkWell(
                      onTap: () {
                        if (!formLoading) {
                          addExperience();
                        }
                      },
                      child: DottedBorder(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 4.w),
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        child: Center(
                          child: (!loading)
                              ? AutoSizeText(
                                  "+ Add Experience",
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
                    height: 25.h,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        if (experience.isNotEmpty) ...[
                          for (var item in experience) ...[
                            ExperienceDetailsCard(
                              firmName: item.company!,
                              role: item.role!,
                              startDate: item.startDate!,
                              endDate: item.endDate!,
                              duration: item.duration!,
                              id: item.experienceId!,
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
                      if (experience.isEmpty) {
                        showErrorToast(
                            context, "Kindly add your work experience");
                      } else {
                        ref
                            .read(userDetailsControllerProvider.notifier)
                            .getDetails();
                        goToPage(context, const JobSeekerNavigation());
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
                  success.body!.data!.userExperience!;
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
          industryController.text = "";
          fieldNameController.text = "";
          selectedStartDate = null;
          selectedEndDate = null;
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

  addExperience() {
    if (fieldNameController.text.isEmpty ||
        industryController.text.isEmpty ||
        selectedStartDate == null ||
        selectedEndDate == null) {
      showErrorToast(context, "Enter all fields");
    } else {
      ExperienceForm experience = ExperienceForm(
          industryController.text,
          fieldNameController.text,
          "${selectedStartDate!.toLocal()}".split(' ')[0],
          (calculateDifference(selectedEndDate!) == 0)
              ? "present"
              : "${selectedStartDate!.toLocal()}".split(' ')[0]);

      ref
          .read(accountFormControllerProvider.notifier)
          .updateExperienceDetails(experience);
    }
  }
}
