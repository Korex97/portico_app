import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/functions/general_functions.dart';
import 'package:potrico/screens/job_seeker/chats/chat_details.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../widgets/widgets.dart';
import '../notifications/notifications.dart';

class AllChats extends ConsumerStatefulWidget {
  const AllChats({super.key});

  @override
  ConsumerState<AllChats> createState() => _AllChatsState();
}

class _AllChatsState extends ConsumerState<AllChats> {
  bool comingsoon = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeadStyle(
            firstImage: "assets/images/menu.png",
            lastImage: null,
            route: AllNotifications()),
        SizedBox(
          height: 3.h,
        ),
        AutoSizeText(
          "Your Chats",
          style: fontRoboto(
            textStyle: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: porticoBlack,
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        if (comingsoon) ...[
          const ComingSoon()
        ] else ...[
          SizedBox(
            height: 80.h,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                InkWell(
                  onTap: () => goToPage(context, const ChatContent()),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: porticoLGrey,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 65.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                child: Image.asset(
                                    "assets/images/image_resume.png"),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: 50.w,
                                    child: AutoSizeText(
                                      "Eleanor Pena",
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: porticoApplicantText,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  SizedBox(
                                    width: 50.w,
                                    child: AutoSizeText(
                                      "Hi everyone, how are you all?",
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: porticoGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                          child: AutoSizeText(
                            "2 mins ago",
                            style: fontRoboto(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: porticoGrey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                InkWell(
                  onTap: () => goToPage(context, const ChatContent()),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: porticoLGrey,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 65.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                child: Image.asset(
                                    "assets/images/image_resume.png"),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: 50.w,
                                    child: AutoSizeText(
                                      "Eleanor Pena",
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: porticoApplicantText,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  SizedBox(
                                    width: 50.w,
                                    child: AutoSizeText(
                                      "Hi everyone, how are you all?",
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: porticoGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                          child: AutoSizeText(
                            "2 mins ago",
                            style: fontRoboto(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: porticoGrey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                InkWell(
                  onTap: () => goToPage(context, const ChatContent()),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: porticoLGrey,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 65.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                child: Image.asset(
                                    "assets/images/image_resume.png"),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: 50.w,
                                    child: AutoSizeText(
                                      "Eleanor Pena",
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: porticoApplicantText,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  SizedBox(
                                    width: 50.w,
                                    child: AutoSizeText(
                                      "Hi everyone, how are you all?",
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: porticoGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                          child: AutoSizeText(
                            "2 mins ago",
                            style: fontRoboto(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: porticoGrey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
