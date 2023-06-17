import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/models/authenticated_form.dart';
import 'package:potrico/models/employee_details_form.dart';
import 'package:potrico/screens/employer/jobs/add_new_job.dart';
import 'package:potrico/screens/onboarding/login.dart';
import 'package:potrico/screens/onboarding/personal_details.dart';
import 'package:potrico/states/authenticated_form_states.dart';
import 'package:potrico/states/user_details_state.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../controllers/account_form_controller.dart';
import '../../controllers/details_controller.dart';
import '../../functions/general_functions.dart';
import '../../models/user_details.dart';
import '../employer/home/home.dart';
import '../employer/navigationbar/navigation_bar.dart';
import '../widgets/widgets.dart';

class EmployerCompanyDetails extends ConsumerStatefulWidget {
  const EmployerCompanyDetails({super.key, required this.backRoute});

  final Widget backRoute;

  @override
  ConsumerState<EmployerCompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends ConsumerState<EmployerCompanyDetails> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyLocationController = TextEditingController();
  TextEditingController companyBioController = TextEditingController();
  bool loading = false;
  List<CompanyDetails>? companyDetails = [];

  DateTime? selectedDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2023, 1),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      statesValidation();
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
                HeadStyle(
                  backRoute: PersonalDetailsUpdate(
                    userType: '2',
                    backRoute: widget.backRoute,
                  ),
                  stage: 2,
                  firstImage: "assets/images/arrow-left-fill.png",
                ),
                SizedBox(
                  height: 2.h,
                ),
                AutoSizeText(
                  "Company Details",
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
                  "COMPANY NAME",
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
                    controller: companyNameController,
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
                      hintText: "Enter your company name",
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
                  height: 1.5.h,
                ),
                AutoSizeText(
                  "COMPANY LOCATION",
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
                    controller: companyLocationController,
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
                      hintText: "Enter your company's locatiom",
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
                  height: 1.5.h,
                ),
                AutoSizeText(
                  "COMPANY OPENING DATE",
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
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                    width: 90.w,
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
                          (selectedDate != null)
                              ? "${selectedDate!.toLocal()}".split(' ')[0]
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
                SizedBox(
                  height: 1.5.h,
                ),
                AutoSizeText(
                  "COMPANY BIO",
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
                    controller: companyBioController,
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
                      hintText: "Provide a short details about your comapany",
                      hintStyle: fontRoboto(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: porticoBlack,
                        ),
                      ),
                    ),
                    maxLines: 10,
                    minLines: 6,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    if (!loading) {
                      addDetails();
                    }
                  },
                  child: PotricoButton(
                    buttonText: "Next",
                    loading: loading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addDetails() {
    if (companyNameController.text.isEmpty ||
        companyLocationController.text.isEmpty ||
        companyBioController.text.isEmpty ||
        selectedDate == null) {
      showErrorToast(context, "Insert all fields");
    } else {
      EmployeeDetailsForm formDetails = EmployeeDetailsForm(
        companyNameController.text,
        companyLocationController.text,
        "${selectedDate!.toLocal()}".split(' ')[0],
        companyBioController.text,
        "",
      );
      ref.read(accountFormControllerProvider.notifier).resetState();
      ref
          .read(accountFormControllerProvider.notifier)
          .updateEmployerDetails(formDetails);
    }
  }

  void statesValidation() {
    var myState = ref.watch(userDetailsControllerProvider);
    var formState = ref.watch(accountFormControllerProvider);

    if (myState is UserDetailsStateLaoding ||
        formState is AuthenticatedFormStateLaoding) {
      Future.delayed(Duration.zero, () {
        setState(() {
          loading = true;
        });
      });
    } else {
      Future.delayed(Duration.zero, () {
        setState(() {
          loading = false;
        });
      });
      // User Details Check
      checkDetailsState(myState);
      // form State check
      checkFormState(formState);
    }
  }

  checkDetailsState(dynamic myState) {
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
            companyDetails = success.body!.data!.companyDetails!;
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

  checkFormState(dynamic myState) {
    if (myState is AuthenticatedFormStateerror) {
      Future.delayed(Duration.zero, () {
        showErrorToast(context, myState.error);
        ref.read(accountFormControllerProvider.notifier).resetState();
      });
    }

    if (myState is AuthenticatedFormStateSuccess) {
      AuthenticatedForm success = myState.successData;
      // check authentication
      if (success.statusCode == 401) {
          showErrorToast(context, "User not authorized");
          ref.read(accountFormControllerProvider.notifier).resetState();
          goToPage(context, const LoginUser());
      }

      // check for errors
      if (success.statusCode == 200) {
        showSuccessToast(context, success.body!.text!);
        ref.read(accountFormControllerProvider.notifier).resetState();
        ref.read(userDetailsControllerProvider.notifier).getDetails();
        log("got here");
        goToPage(context, const Navigation());
      } else {
        Future.delayed(Duration.zero, () {
          showErrorToast(context, success.body!.text!);
          ref.read(accountFormControllerProvider.notifier).resetState();
        });
      }
    }
  }
}
