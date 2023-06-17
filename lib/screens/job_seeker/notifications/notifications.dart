import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/notification_controller.dart';
import '../../../functions/general_functions.dart';
import '../../../models/notification_model.dart';
import '../../../states/notification_state.dart';
import '../../onboarding/login.dart';
import '../../widgets/widgets.dart';
import '../components/notification_card.dart';
import '../navigation/navigation.dart';

class AllNotifications extends ConsumerStatefulWidget {
  final int backPage;
  const AllNotifications({super.key, this.backPage = 0});

  @override
  ConsumerState<AllNotifications> createState() => _AllNotificationsState();
}

class _AllNotificationsState extends ConsumerState<AllNotifications> {
  bool loading = false;
  final notificationProvider =
      StateProvider<List<NotificationData>>((ref) => []);
  List<NotificationData> allNotification = [];
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      Future.delayed(Duration.zero, () async {
        await notificationsState();
      });
      allNotification = ref.read(notificationProvider.notifier).state;
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
                    backRoute: JobSeekerNavigation(
                      page: widget.backPage,
                    ),
                    firstImage: "assets/images/arrow-left-fill.png",
                    lastImage: null,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  AutoSizeText(
                    "Notifications",
                    style: fontRoboto(
                      textStyle: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: porticoBlackText,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  if (loading) ...[
                    Center(
                      child: SizedBox(
                        width: 50.w,
                        height: 10.w,
                        child: Image.asset("assets/images/dot-loader.gif",
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                  ] else ...[
                    if (allNotification.isEmpty) ...[
                      NoRecord(
                        ref: ref,
                        contentName: "notifications",
                        showButton: false,
                      )
                    ] else ...[
                      SizedBox(
                        height: 70.h,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            for (var item in allNotification) ...[
                              NotificationBox(
                                NotificationContent:
                                    (item.notificationtext != null)
                                        ? item.notificationtext!
                                        : "",
                                NotificationHeader:
                                    (item.notificationHeader != null)
                                        ? item.notificationHeader!
                                        : "",
                                date: (item.createdAt != null)
                                    ? item.createdAt!
                                    : "",
                                time: (item.time != null) ? item.time! : "",
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  notificationsState() async {
    final myState = ref.watch(userNotificationControllerProvider);
    if (myState is NotificationStateLaoding) {
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
      if (myState is NotificationStateError) {
        Future.delayed(Duration.zero, () {
          showErrorToast(context, myState.error);
          ref.read(userNotificationControllerProvider.notifier).resetState();
        });
      }

      if (myState is NotificationStateSuccess) {
        NotificationModel success = myState.successData;
        // check authentication
        if (success.statusCode == 401) {
          Future.delayed(Duration.zero, () {
            showErrorToast(context, "User not authorized");
            ref.read(userNotificationControllerProvider.notifier).resetState();
            goToPage(context, const LoginUser());
          });
        }

        // check for errors
        if (success.statusCode == 200) {
          Future.delayed(Duration.zero, () {
            if (success.body!.status!) {
              Future.delayed(Duration.zero, () {
                ref.read(notificationProvider.notifier).state =
                  success.body!.data!.notifications!;
              });
              
            } else {
              ref.read(notificationProvider.notifier).state = [];
            }
          });
        } else {
          Future.delayed(Duration.zero, () {
            showErrorToast(context, success.body!.text!);
            ref.read(userNotificationControllerProvider.notifier).resetState();
          });
        }
      }
    }
  }
}
