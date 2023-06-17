import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../widgets/widgets.dart';
import '../navigation/navigation.dart';

class JobSeekerResume extends StatefulWidget {
  const JobSeekerResume({super.key});

  @override
  State<JobSeekerResume> createState() => _JobSeekerResumeState();
}

class _JobSeekerResumeState extends State<JobSeekerResume> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w,),
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
                    AutoSizeText(
                      "Upload Resume",
                      style: fontRoboto(
                        textStyle: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: porticoBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
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
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      child: AutoSizeText(
                        "Lorem Ipsum has been the industry's standard.Lorem Ipsum has been the industry's standard.",
                        textAlign: TextAlign.center,
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
                      height: 4.h,
                    ),
                    Center(
                      child: Container(
                        width: 40.w,
                        padding:
                            EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                        decoration: const BoxDecoration(
                          color: porticoBlackText,
                          borderRadius: BorderRadius.all(
                            Radius.circular(38),
                          ),
                        ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
