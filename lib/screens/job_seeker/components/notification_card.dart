import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';

class NotificationBox extends StatelessWidget {
  const NotificationBox({
    super.key, required this.NotificationHeader, required this.NotificationContent, required this.date, required this.time,
  });

  final String NotificationHeader;
  final String NotificationContent;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      decoration: const BoxDecoration(
        color: porticoLGreen,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10.w,
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.5.w),
            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Center(
              child: Image.asset("assets/images/notification-bing.png"),
            ),
          ),
          SizedBox(
            width: 65.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                 NotificationHeader,
                  style: fontRoboto(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                SizedBox(
                  width: 60.w,
                  child: AutoSizeText(
                    NotificationContent,
                    style: fontRoboto(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: porticoGrey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      date,
                      style: fontRoboto(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: porticoGrey,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    const CircleAvatar(
                      backgroundColor: porticoGrey,
                      radius: 3,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    AutoSizeText(
                      time,
                      style: fontRoboto(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: porticoGrey,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}