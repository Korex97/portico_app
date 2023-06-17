import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:potrico/screens/job_seeker/navigation/navigation.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../widgets/widgets.dart';
import '../notifications/notifications.dart';

class ChatContent extends StatefulWidget {
  const ChatContent({super.key});

  @override
  State<ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: porticoBlueBg,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: white,
                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 6.h),
                child: const HeadStyle(
                  backRoute: JobSeekerNavigation(page: 1,),
                  firstImage: "assets/images/arrow-left-fill.png",
                  lastImage: null,
                  route: AllNotifications(),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
                  margin: const EdgeInsets.only(
                    bottom: 6.0,
                  ), //Same as `blurRadius` i guess
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: AutoSizeText(
                    "Your Chats",
                    style: fontRoboto(
                      textStyle: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: porticoBlack,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: SizedBox(
                      height: 62.h,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 70.w,
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 5.w),
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
                                    SizedBox(
                                      width: 60.w,
                                      child: AutoSizeText(
                                        "Lorem Ipsum has been the industry's standard.Lorem Ipsum has been the industry's standard.",
                                        style: fontRoboto(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: porticoBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    AutoSizeText(
                                      "2 mins ago",
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: porticoGrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 70.w,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.h, horizontal: 5.w),
                                    decoration: const BoxDecoration(
                                      color: porticoBlackText,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 60.w,
                                          child: AutoSizeText(
                                            "Lorem Ipsum has been the industry's standard.Lorem Ipsum has been the industry's standard.",
                                            textAlign: TextAlign.end,
                                            style: fontRoboto(
                                              textStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: white,
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
                                            "2 mins ago",
                                            textAlign: TextAlign.end,
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
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                width: 70.w,
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 5.w),
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
                                    SizedBox(
                                      width: 60.w,
                                      child: AutoSizeText(
                                        "Lorem Ipsum has been the industry's standard.Lorem Ipsum has been the industry's standard.",
                                        style: fontRoboto(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: porticoBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    AutoSizeText(
                                      "2 mins ago",
                                      style: fontRoboto(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: porticoGrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.w, vertical: 2.h),
                      margin: const EdgeInsets.only(
                        bottom: 6.0,
                      ), //Same as `blurRadius` i guess
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 2.h),
                            decoration: const BoxDecoration(
                              color: porticoLGrey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            width: 70.w,
                            child: SizedBox(
                              child: TextFormField(
                                controller: messageController,
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
                                  fillColor: porticoLGrey,
                                  enabledBorder: InputBorder.none,
                                  focusColor: porticoGrey,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: "Your Message",
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
                          ),
                          CircleAvatar(
                            radius: 3.h,
                            backgroundColor: porticoPink,
                            child: Image.asset("assets/images/send.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
