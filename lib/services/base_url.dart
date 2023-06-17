import 'dart:developer';

class BaseUrl {
  static const basic = "https://portico.com.ng/api";
  static const base = "https://portico.com.ng/";
  static const imageUrl = "${base}assets/images/users/";
  static const categoryImageUrl = "${base}assets/images/category/";

// *************USER DETAILS***************
  final Uri login = Uri.parse("$basic/auth/login.php");
  final Uri register = Uri.parse("$basic/auth/register.php");
  final Uri forgotPass = Uri.parse("$basic/auth/forgotpass.php");
  final Uri requestresetpass = Uri.parse("$basic/accounts/resetpasscode.php");
  final Uri resetpass = Uri.parse("$basic/accounts/resetpass.php");
  final Uri changepass = Uri.parse("$basic/accounts/userchangepassword.php");
  final Uri userdetails = Uri.parse("$basic/accounts/getdetails.php");
  final Uri usernotification =
      Uri.parse("$basic/accounts/get_user_notification.php");
  final Uri updateInfo = Uri.parse("$basic/accounts/updateuserinfo.php");
  final Uri updateEmployerDetails =
      Uri.parse("$basic/employer/add_employer_details.php");
  final Uri updateUserEducationDetails =
      Uri.parse("$basic/education/add_education_details.php");
  final String deleteEducationDetails = "$basic/education/delete_education.php";
  final Uri updateExperience =
      Uri.parse("$basic/experience/add_experience.php");
  final String deleteExperience = "$basic/experience/delete_employer.php";

// *************Jobs***************//
  Uri getAllJobs(String value, String category, String location, String salary) {
    return 
    Uri.parse(
        "$basic/jobs/get_all_jobs.php?search=$value$category$location$salary"
    );
  }

  Uri getJobDetails(String value) {
    return Uri.parse("$basic/jobs/get_job_details.php?job_id=$value");
  }

  final Uri addJobs = Uri.parse("$basic/jobs/add_job.php");

// *************Job Categories***************//
  final Uri getAllJobCategory =
      Uri.parse("$basic/categories/get_all_categories.php");

// *************Job Applicants***************//
  final Uri getEmployerJobApplicant =
      Uri.parse("$basic/applicants/get_employer_applicants.php");
  Uri getJobApplicants(String value) {
    return Uri.parse("$basic/applicants/get_job_applicants.php?job_id=$value");
  }

  final Uri applicantsDetails =
      Uri.parse("$basic/applicants/get_applicant_details.php");
  final Uri chnageApplicantStatusUri =
      Uri.parse("$basic/applicants/change_applicant_status.php");
  final Uri getAllJobsAppliedFor =
      Uri.parse("$basic/applicants/get_user_applications.php");
  final Uri applyForJobUri = Uri.parse("$basic/applicants/add_applicants.php");

// *************SYSTEM DETAILS***************
// final Uri newappnotification=Uri.parse("$basic/newappnotification.php");
// final Uri appslider=Uri.parse("$basic/slider.php");
// final Uri mainsystem=Uri.parse("$basic/mainsystem.php");
// final Uri newmainsystem=Uri.parse("$basic/newmainsystem.php");

// *************POST DETAILS***************
// final Uri postrecents=Uri.parse("$basic/post/recentposts.php");
// final Uri postall=Uri.parse("$basic/post/allposts.php");
// final Uri postcats=Uri.parse("$basic/post/postcategories.php");
// final Uri posttopcat=Uri.parse("$basic/post/toppostcategories.php");
// final Uri postsingle=Uri.parse("$basic/post/singlepost.php");
// final Uri postwithcat=Uri.parse("$basic/post/postwithcat.php");
// final Uri postsearch=Uri.parse("$basic/post/searchpost.php");

// *************BOOK DETAILS***************
// final Uri bookrecents=Uri.parse("$basic/book/recentbooks.php");
// final Uri bookall=Uri.parse("$basic/book/allbooks.php");
// final Uri bookcats=Uri.parse("$basic/book/bookcategories.php");
// final Uri booktopcat=Uri.parse("$basic/book/topbookcategories.php");
// final Uri booksigle=Uri.parse("$basic/book/singlebook.php");
// final Uri bookwithcat=Uri.parse("$basic/book/bookwithcat.php");
// final Uri booksearch=Uri.parse("$basic/book/searchbook.php");
// final Uri bookorder=Uri.parse("$basic/book/userorderbooks.php");

// *************CLASS DETAILS***************
// final Uri classrecents=Uri.parse("$basic/class/recentclasses.php");
// final Uri classall=Uri.parse("$basic/class/allclasses.php");
// final Uri classcats=Uri.parse("$basic/class/classcategories.php");
// final Uri classtopcat=Uri.parse("$basic/class/topclasscategories.php");
// final Uri classdownload=Uri.parse("$basic/class/downloadme.php");
// final Uri classsingle=Uri.parse("$basic/class/singleclass.php");
// final Uri classwithcat=Uri.parse("$basic/class/classwithcat.php");
// final Uri classsearch=Uri.parse("$basic/class/searchclass.php");

// *************SODAQADETAILS***************
// final Uri sodaqahrecent=Uri.parse("$basic/sodaqah/recentsodaqahs.php");
// final Uri sodaqahall=Uri.parse("$basic/sodaqah/allsodaqahs.php");
// final Uri sodaqahpending=Uri.parse("$basic/sodaqah/pendingsodaqahs.php");
// final Uri sodaqahsingle=Uri.parse("$basic/sodaqah/singlesodaqahs.php");
// final Uri sodaqahsearch=Uri.parse("$basic/sodaqah/searchsodaqah.php");
// final Uri sodaqahdonate=Uri.parse("$basic/sodaqah/donatesodaqah.php");

// *************LECTURE DETAILS***************
// final Uri lecturerecents=Uri.parse("$basic/lecture/recentvideolectures.php");
// final Uri lectureall=Uri.parse("$basic/lecture/allvideolecture.php");
// final Uri lecturecats=Uri.parse("$basic/lecture/lecturecategories.php");
// final Uri lecturetopcat=Uri.parse("$basic/lecture/toplecturecategories.php");
// final Uri lecturesingle=Uri.parse("$basic/lecture/singlevideolecture.php");
// final Uri lecturewithcat=Uri.parse("$basic/lecture/videolecturewithcat.php");
// final Uri lecturesearch=Uri.parse("$basic/lecture/searchvideolecture.php");
}
