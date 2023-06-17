import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/constants/colors.dart';
import 'package:potrico/screens/employer/home/home.dart';
import 'package:potrico/screens/employer/resume/all_resumes.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/details_controller.dart';
import '../../../controllers/job_applicants_controller.dart';
import '../../../controllers/job_category_controller.dart';
import '../../../controllers/jobs_details_controller.dart';
import '../../../functions/general_functions.dart';
import '../../../models/user_details.dart';
import '../../../states/user_details_state.dart';
import '../../onboarding/login.dart';
import '../jobs/add_new_job.dart';

class Navigation extends ConsumerStatefulWidget {
  final int page;
  const Navigation({super.key, this.page = 0});

  @override
  ConsumerState<Navigation> createState() => _NavigationState();
}

class _NavigationState extends ConsumerState<Navigation> {
  List pages = <Widget>[
    const EmployerHome(),
    const AllApplicants(),
    const AddNewJob(),
    Container(),
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
      if ( index == 0 ){
        ref.read(jobDetailsControllerProvider.notifier).getJobPosted();
      }
      if ( index == 1 ){
        ref.read(jobApplicantsControllerProvider.notifier).getEmployerJobApplicants();
      }
      if ( index == 2 ){
        ref.read(jobCategoryControllerProvider.notifier).getJobCategories();
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
            padding: EdgeInsets.only(top: 6.h, left: 5.w, right: 5.w),
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
                  label: "Applicants",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.badge_rounded),
                  label: "Jobs",
                ),
              ],
            )),
      ),
    );
  }
}
