import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/screens/employer/navigationbar/navigation_bar.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/account_form_controller.dart';
import '../../../controllers/details_controller.dart';
import '../../../controllers/job_category_controller.dart';
import '../../../controllers/jobs_details_controller.dart';
import '../../../functions/general_functions.dart';
import '../../../models/add_job_model.dart';
import '../../../models/authenticated_form.dart';
import '../../../models/job_category.dart';
import '../../../models/user_details.dart';
import '../../../states/authenticated_form_states.dart';
import '../../../states/job_category_state.dart';
import '../../../states/user_details_state.dart';
import '../../onboarding/login.dart';
import '../../widgets/widgets.dart';

class AddNewJob extends ConsumerStatefulWidget {
  const AddNewJob({super.key});

  @override
  ConsumerState<AddNewJob> createState() => _AddNewJobState();
}

class _AddNewJobState extends ConsumerState<AddNewJob> {
  TextEditingController salaryController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  List companyList = [
    {'name': 'Select Company', 'value': ''},
  ];
  String? selectedCompany;

  List categoryList = [
    {'name': 'Select Category', 'value': ''},
  ];
  String? selectedCategory;

  List typeList = [
    {'name': 'Select Job Type', 'value': ''},
    {'name': 'Fulltime', 'value': '1'},
    {'name': 'Remote', 'value': '2'},
    {'name': 'Hybrid', 'value': '3'},
  ];
  String? selectedType;

  bool categoryLoading = false;
  bool loading = false;
  bool formLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ref, child) {
        Future.delayed(Duration.zero, () {
          getUserCompany();
          jobCategory();
          checkFormState();
        });
        return Column(
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
              "Add New Job",
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
              "COMPANY",
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
              child: DropdownButtonFormField(
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
                        style: BorderStyle.solid),
                  ),
                  hintStyle: fontRoboto(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: porticoBlack,
                    ),
                  ),
                ),
                hint: const Text("Select Company"),
                value: selectedCompany,
                onChanged: (value) {
                  setState(() {
                    if (value != null && value != "") {
                      selectedCompany = value;
                    }
                  });
                },
                items: companyList.map((account) {
                  return DropdownMenuItem<String>(
                    value: account['value'],
                    child: Text(account['name']),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            AutoSizeText(
              "CATEGORY",
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
              child: DropdownButtonFormField(
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
                        style: BorderStyle.solid),
                  ),
                  hintStyle: fontRoboto(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: porticoBlack,
                    ),
                  ),
                ),
                hint: const Text("Select Location"),
                value: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    if (value != null && value != "") {
                      selectedCategory = value;
                    }
                  });
                },
                items: categoryList.map((account) {
                  return DropdownMenuItem<String>(
                    value: account['value'],
                    child: Text(account['name']),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            AutoSizeText(
              "JOB TYPE",
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
              child: DropdownButtonFormField(
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
                        style: BorderStyle.solid),
                  ),
                  hintStyle: fontRoboto(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: porticoBlack,
                    ),
                  ),
                ),
                hint: const Text("Select Job Type"),
                value: selectedType,
                onChanged: (value) {
                  setState(() {
                    if (value != null && value != "") {
                      selectedType = value;
                    }
                  });
                },
                items: typeList.map((account) {
                  return DropdownMenuItem<String>(
                    value: account['value'],
                    child: Text(account['name']),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            AutoSizeText(
              "Job Role",
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
                controller: positionController,
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
                  hintText: "Role",
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
            SizedBox(
              height: 1.5.h,
            ),
            AutoSizeText(
              "SALARY",
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
                controller: salaryController,
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
                  hintText: "Expected Salary",
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
            SizedBox(
              height: 1.5.h,
            ),
            AutoSizeText(
              "LOCATION",
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
                controller: locationController,
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
                  hintText: "Job Location",
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
              "EXPERIENCE",
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
                controller: experienceController,
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
                  hintText: "Experience Level Required",
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
              "Requirements",
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
                controller: requirementsController,
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
                  hintText: "Applicants Requirements",
                  hintStyle: fontRoboto(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: porticoBlack,
                    ),
                  ),
                ),
                minLines: 7,
                maxLines: 25,
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            InkWell(
              onTap: () {
                if (!formLoading) submitJob();
              },
              child: PotricoButton(
                buttonText: "Post Job",
                loading: formLoading,
              ),
            ),
          ],
        );
      }),
    );
  }

  submitJob() {
    if (selectedCompany == null || selectedCompany == "") {
      showErrorToast(context, "Kindly Select Your Company");
      return;
    }

    if (selectedCategory == null || selectedCategory == "") {
      showErrorToast(context, "Kindly Select job category");
      return;
    }

    if (selectedType == null || selectedType == "") {
      showErrorToast(context, "Kindly Select job type");
      return;
    }

    if (salaryController.text.isEmpty ||
        locationController.text.isEmpty ||
        experienceController.text.isEmpty ||
        requirementsController.text.isEmpty) {
      showErrorToast(context, "Kindly enter all fields");
      return;
    }

    AddJobModel job = AddJobModel(
      selectedCategory!,
      locationController.text,
      positionController.text,
      selectedType!,
      salaryController.text,
      experienceController.text,
      requirementsController.text,
    );

    ref.read(accountFormControllerProvider.notifier).addJob(job);
  }

  jobCategory() {
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
          List category = [
            {'name': 'Select Category', 'value': ''}
          ];
          for (var element in success.data!.categories!) {
            if (element.status == 1) {
              category.add({'name': element.name, 'value': element.id});
            }
          }
          Future.delayed(Duration.zero, () {
            setState(() {
              categoryList = category;
            });
          });
        } else {
          Future.delayed(Duration.zero, () {
            setState(() {
              categoryList = [
                {'name': 'Select Category', 'value': ''},
              ];
            });
          });
        }
      }
    }
  }

  getUserCompany() {
    var state = ref.watch(userDetailsControllerProvider);
    if (state is UserDetailsStateLaoding) {
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
      if (state is UserDetailsStateError) {
        Future.delayed(Duration.zero, () {
          showErrorToast(context, state.error);
          ref.read(userDetailsControllerProvider.notifier).resetState();
        });
      }

      if (state is UserDetailsStateSuccess) {
        UserDetails success = state.successData;
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
          List company = [
            {'name': 'Select Company', 'value': ''}
          ];

          var userCompany = (success.body!.data!.companyDetails == null)
              ? null
              : success.body!.data!.companyDetails;

          if (userCompany != null) {
            for (var element in success.body!.data!.companyDetails!) {
              company.add({
                'name': element.companyName,
                'value': element.employerId,
              });
            }
          }
          Future.delayed(Duration.zero, () {
            setState(() {
              companyList = company;
              selectedCompany =
                  success.body!.data!.companyDetails![0].employerId;
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

  checkFormState() {
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
    }

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
        ref.read(jobDetailsControllerProvider.notifier).getJobPosted();
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
