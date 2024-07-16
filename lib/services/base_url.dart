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
}
