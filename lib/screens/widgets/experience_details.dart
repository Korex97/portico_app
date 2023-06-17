import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/controllers/account_form_controller.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';

class ExperienceDetailsCard extends ConsumerWidget {
  const ExperienceDetailsCard({
    super.key,
    required this.firmName,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.id,
    this.canDelete = false,
  });

  final String firmName;
  final String role;
  final String startDate;
  final String endDate;
  final String duration;
  final String id;
  final bool canDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
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
                "assets/images/business.png",
                color: porticoGreen,
              ),
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
                  role,
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
                  firmName,
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
                  "$startDate - $endDate  |  $duration",
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
          if (canDelete)
            InkWell(
              onTap: () {
                ref
                    .read(accountFormControllerProvider.notifier)
                    .deleteExperienceDetails(id);
              },
              child: const Icon(
                Icons.delete,
                color: porticoApplicantRejected,
              ),
            )
        ],
      ),
    );
  }
}
