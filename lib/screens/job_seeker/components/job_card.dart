import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/functions/general_functions.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/job_fulldetails_controllers.dart';
import '../jobs/job_details.dart';

class JobCard extends ConsumerWidget {
  const JobCard({
    super.key,
    required this.jobName,
    required this.jobType,
    required this.jobId,
    required this.jobCategory,
    required this.location,
    required this.salary,
    required this.ref,
    required this.pageOn,
  });

  final String jobName;
  final int jobType;
  final String jobId;
  final String jobCategory;
  final String location;
  final String salary;
  final WidgetRef ref;
  final int pageOn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 90.w,
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      decoration: const BoxDecoration(
        color: porticoYellowWithOpacity16,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  ref
                      .read(jobFullDetailsControllerProvider.notifier)
                      .getJobDetails(jobId);

                  goToPage(context, JobDetails(pageFron: pageOn,),);
                },
                child: SizedBox(
                  width: 70.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        jobName,
                        // textAlign: TextAlign.center,
                        style: fontRoboto(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: porticoBlackText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 2.w),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                            ),
                            child: AutoSizeText(
                              (jobType == 1)
                                  ? "Fulltime"
                                  : (jobType == 2)
                                      ? "Remote"
                                      : (jobType == 3)
                                          ? "Hybrid"
                                          : "",
                              textAlign: TextAlign.center,
                              style: fontRoboto(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: porticoBlackText,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 2.w),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                            ),
                            child: AutoSizeText(
                              jobCategory,
                              textAlign: TextAlign.center,
                              style: fontRoboto(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: porticoBlackText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Image.asset("assets/images/bookmark.png"),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          InkWell(
            onTap: () {
              ref
                .read(jobFullDetailsControllerProvider.notifier)
                .getJobDetails(jobId);

                goToPage(context, JobDetails(pageFron: pageOn,));
            },
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 0.5,
                    color: porticoLGrey,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 42.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/location.png"),
                            SizedBox(
                              width: 3.w,
                            ),
                            AutoSizeText(
                              location,
                              style: fontRoboto(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: porticoBlackText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 42.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              salary,
                              textAlign: TextAlign.center,
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
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
