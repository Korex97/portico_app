import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/constants/colors.dart';
import 'package:potrico/controllers/job_applicants_controller.dart';
import 'package:potrico/screens/job_seeker/jobs/all_applied_jobs.dart';
import 'package:sizer/sizer.dart';
import '../chats/all_chats.dart';
import '../home/home.dart';
import '../profile/profile.dart';

class JobSeekerNavigation extends ConsumerStatefulWidget {
  final int page;
  const JobSeekerNavigation({super.key, this.page = 0});

  @override
  ConsumerState<JobSeekerNavigation> createState() =>
      _JobSeekerNavigationState();
}

class _JobSeekerNavigationState extends ConsumerState<JobSeekerNavigation> {
  List pages = <Widget>[
    const JobSeekerHome(),
    const AllChats(),
    const AllAppliedJobs(),
    const UserProfile(),
  ];

  late int currentIndex;

  @override
  void initState() {
    currentIndex = widget.page;
    super.initState();
  }

  void onTapNavigationBar(int index) {
    setState(() {
      currentIndex = index;
      if (index == 2) {
        ref
            .read(jobApplicantsControllerProvider.notifier)
            .getAllJobsUserAppliedfor();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 6.h,
              left: 5.w,
              right: 5.w,
            ),
            child: pages[currentIndex],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              )),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            currentIndex: currentIndex,
            selectedItemColor: white,
            unselectedItemColor: porticoGrey,
            onTap: onTapNavigationBar,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_rounded),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.badge_rounded),
                label: "My Jobs",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
