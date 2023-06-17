import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/controllers/job_applicants_controller.dart';
import 'package:potrico/models/apply_for_job_model.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/account_form_controller.dart';
import '../../../functions/general_functions.dart';
import '../../../states/authenticated_form_states.dart';
import '../../widgets/resume_card.dart';
import '../../widgets/widgets.dart';
import '../jobs/job_details.dart';
import '../navigation/navigation.dart';

class AddResume extends ConsumerStatefulWidget {
  const AddResume(
      {super.key,
      required this.jobId,
      required this.role,
      required this.company});

  final String jobId;
  final String role;
  final String company;

  @override
  ConsumerState<AddResume> createState() => _AddResumeState();
}

class _AddResumeState extends ConsumerState<AddResume> {
  final resumeProvider = StateProvider<File?>((ref) => null);
  bool formLoading = false;
  File? uploadedFile;

  @override
  void initState() {
    uploadedFile = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      Future.delayed(Duration.zero, () async {
        await detailsStateValidation();
      });
      uploadedFile = ref.read(resumeProvider.notifier).state;
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 6.h,
                    horizontal: 5.w,
                  ),
                  decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: porticoBlackTextWithOpacity2,
                        offset: Offset.zero,
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadStyle(
                        jobId: widget.jobId,
                        backRoute: const JobDetails(
                          pageFron: 0,
                        ),
                        firstImage: "assets/images/arrow-left-fill.png",
                        lastImage: null,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        width: 70.w,
                        child: AutoSizeText(
                          "Continue applying for ${widget.role} at ${widget.company}",
                          style: fontRoboto(
                            textStyle: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: porticoBlack,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      if (uploadedFile == null)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/Floor.png"),
                              SizedBox(
                                height: 2.h,
                              ),
                              AutoSizeText(
                                "Your Resume",
                                style: fontRoboto(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: porticoBlack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Center(
                        child: Container(
                          width: 40.w,
                          padding: EdgeInsets.symmetric(
                              horizontal: 7.w, vertical: 1.h),
                          decoration: const BoxDecoration(
                            color: porticoBlackText,
                            borderRadius: BorderRadius.all(
                              Radius.circular(38),
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              File? file = await getResumeFile();

                              if (file != null) {
                                ref.read(resumeProvider.notifier).state = file;
                              } else {
                                ref.read(resumeProvider.notifier).state = null;
                              }
                            },
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/upload.png",
                                    color: white,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  AutoSizeText(
                                    "Upload",
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
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                if (uploadedFile == null)
                  SizedBox(
                    height: 35.h,
                  ),
                if (uploadedFile != null)
                  SizedBox(
                    height: 15.h,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w, left: 5.w),
                      child: ResumeCard(filename: getFilename(uploadedFile!)),
                    ),
                  ),
                if (uploadedFile != null)
                  SizedBox(
                    height: 29.h,
                  ),
                InkWell(
                  onTap: () {
                    if (!formLoading) {
                      apply();
                    }
                  },
                  child: PotricoButton(
                    buttonText: "Apply Job",
                    loading: formLoading,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
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
          ref
              .read(jobApplicantsControllerProvider.notifier)
              .getAllJobsUserAppliedfor();
          goToPage(
              context,
              const JobSeekerNavigation(
                page: 2,
              ));
          ref.read(accountFormControllerProvider.notifier).resetState();
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

  apply() {
    if (uploadedFile == null) {
      showErrorToast(context, "Kindly upload your resume");
    } else {
      ApplyForJobModel applicant =
          ApplyForJobModel(widget.jobId, uploadedFile!);

      ref.read(accountFormControllerProvider.notifier).applyForJob(applicant);
    }
  }
}
