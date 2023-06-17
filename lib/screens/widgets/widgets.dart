import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/controllers/job_fulldetails_controllers.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../controllers/details_controller.dart';
import '../../controllers/job_category_controller.dart';
import '../../controllers/notification_controller.dart';
import '../../functions/general_functions.dart';
import '../employer/navigationbar/navigation_bar.dart';

class PotricoButton extends StatelessWidget {
  final Widget? route;
  final Color buttonColor;
  final Color textColor;
  final String buttonText;
  final bool? loading;
  const PotricoButton({
    super.key,
    this.route,
    this.buttonColor = porticoPinkWithOpacity25,
    this.textColor = porticoPink,
    required this.buttonText,
    this.loading,
  });

  @override
  Widget build(BuildContext context) {
    if (route == null) {
      return Button(
        buttonText: buttonText,
        showloading: loading,
      );
    } else {
      return InkWell(
        onTap: () => goToPage(context, route!),
        child: Button(
          buttonText: buttonText,
          showloading: loading,
        ),
      );
    }
  }
}

class Button extends PotricoButton {
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? borderRadius;
  final Color? bgColor;
  final Color? txtColor;
  final double? txtSize;
  final bool? showloading;
  const Button({
    super.key,
    required super.buttonText,
    this.horizontalPadding,
    this.verticalPadding,
    this.borderRadius,
    this.bgColor,
    this.txtColor,
    this.txtSize,
    this.showloading,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: (horizontalPadding != null) ? horizontalPadding! : 5.w,
          vertical: (verticalPadding != null) ? verticalPadding! : 2.h),
      decoration: BoxDecoration(
        color: (bgColor != null) ? bgColor : buttonColor,
        borderRadius: BorderRadius.all(
          Radius.circular((borderRadius != null) ? borderRadius! : 50),
        ),
      ),
      child: Center(
        child: (showloading == null || !showloading!)
            ? AutoSizeText(
                super.buttonText,
                style: fontRoboto(
                  textStyle: TextStyle(
                    fontSize: (txtSize != null) ? txtSize : 20,
                    fontWeight: FontWeight.w600,
                    color: (txtColor != null) ? txtColor : textColor,
                  ),
                ),
              )
            : Image.asset(
                "assets/images/loading.gif",
                height: 5.h,
                width: 10.w,
              ),
      ),
    );
  }
}

class Progress extends StatelessWidget {
  final double stage;
  Progress({
    super.key,
    required this.stage,
  });

  late String stageText = stage.toInt().toString();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 15.w,
      height: 7.h,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            startAngle: 340,
            endAngle: 340,
            pointers: <RangePointer>[
              RangePointer(
                value: stage,
                cornerStyle: CornerStyle.bothCurve,
                width: 0.2,
                color: porticoYellow,
                sizeUnit: GaugeSizeUnit.factor,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                positionFactor: 0.1,
                angle: 90,
                widget: Text(
                  '$stageText / 3',
                  style: const TextStyle(
                    fontSize: 11,
                    color: porticoYellow,
                  ),
                ),
              )
            ],
            minimum: 0,
            maximum: 3,
            showLabels: false,
            showTicks: false,
            axisLineStyle: const AxisLineStyle(
              thickness: 0.2,
              cornerStyle: CornerStyle.bothCurve,
              color: porticoLGrey,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
          ),
        ],
      ),
    );
  }
}

class HeadStyle extends ConsumerWidget {
  final String firstImage;
  final String? lastImage;
  final double? stage;
  final Widget? backRoute;
  final bool isNotification;
  final String? jobId;
  final Widget? route;
  const HeadStyle({
    super.key,
    required this.firstImage,
    this.lastImage = "progress",
    this.stage,
    this.jobId,
    this.backRoute,
    this.isNotification = true,
    this.route,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            if (backRoute != null) {
              if (jobId != null) {
                ref
                    .read(jobFullDetailsControllerProvider.notifier)
                    .getJobDetails(jobId!);
              }
              goToPage(context, backRoute!);
            }
          },
          child: Image.asset(firstImage),
        ),
//////////**Image Widget  */////////        
        Image.asset(
          "assets/images/Frame 1.png",
        ),
        if (lastImage == null) ...[
          SizedBox(
            width: 15.w,
          )
        ] else if (lastImage == "progress") ...[
          Progress(
            stage: (lastImage == "progress" && stage != null) ? stage! : 1,
          ),
        ] else ...[
          InkWell(
            onTap: () {
              if (route != null) {
                if (isNotification) {
                  ref
                      .read(userNotificationControllerProvider.notifier)
                      .getUserNotifications();
                }

                goToPage(context, route!);
              }
            },
            child: Image.asset(
              lastImage!,
            ),
          ),
        ],
      ],
    );
  }
}

class NoRecord extends StatelessWidget {
  const NoRecord({
    super.key,
    required this.ref,
    required this.contentName,
    this.showButton = true,
  });

  final WidgetRef ref;
  final String contentName;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 20.h,
                child: Image.asset(
                  "assets/images/no_record.png",
                )),
            AutoSizeText(
              "No $contentName found",
              textAlign: TextAlign.center,
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
            if (showButton)
              InkWell(
                onTap: () {
                  ref.read(userDetailsControllerProvider.notifier).getDetails();
                  ref
                      .read(
                        jobCategoryControllerProvider.notifier,
                      )
                      .getJobCategories();
                  goToPage(
                    context,
                    const Navigation(
                      page: 2,
                    ),
                  );
                },
                child: SizedBox(
                  width: 60.w,
                  child: Button(
                    buttonText: "Add New Job",
                    horizontalPadding: 2.w,
                    verticalPadding: 2.h,
                    borderRadius: 12,
                    bgColor: porticoPinkWithOpacity15,
                    txtColor: porticoPink,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ComingSoon extends StatelessWidget {
  const ComingSoon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 20.h,
                child: Image.asset(
                  "assets/images/no_record.png",
                )),
            AutoSizeText(
              "Feature coming soon",
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
      ),
    );
  }
}
