import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/models/authenticated_form.dart';
import '../models/add_job_model.dart';
import '../models/applicant_details_model.dart';
import '../models/apply_for_job_model.dart';
import '../models/change_status_model.dart';
import '../models/failure_model.dart';
import '../models/job_applicants.dart';
import '../models/job_category.dart';
import '../models/job_details_model.dart';
import '../models/job_full_details_model.dart';
import '../services/job_services.dart';

class JobRepository {
  final JobService jobService;
  JobRepository(this.jobService);

  Future<Either<Failure, JobDetailsModel>> getJobPosted({
    String value = "",
    String location = "",
    String category = "",
    String salaryRange = "",
  }) async {
    Either<Failure, Map<String, dynamic>> response =
        await jobService.getJobPosted(
            value: value,
            category: category,
            location: location,
            salaryRange: salaryRange);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      JobDetailsModel authResponse = JobDetailsModel.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, JobFullDetailsModel>> getJobDetails(String job) async {
    Either<Failure, Map<String, dynamic>> response =
        await jobService.getJobFullDetails(job);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      JobFullDetailsModel authResponse =
          JobFullDetailsModel.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, JobCategories>> getJobCategories() async {
    Either<Failure, Map<String, dynamic>> response =
        await jobService.getJobCategory();
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      JobCategories authResponse = JobCategories.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, AuthenticatedForm>> addJob(AddJobModel jobData) async {
    Either<Failure, Map<String, dynamic>> response =
        await jobService.addJob(jobData);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      AuthenticatedForm authResponse = AuthenticatedForm.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, ApplicantDetailsModel>> getApplicantDetails(
      String applicant) async {
    Either<Failure, Map<String, dynamic>> response =
        await jobService.getApplicantDetails(applicant);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      ApplicantDetailsModel authResponse =
          ApplicantDetailsModel.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, AuthenticatedForm>> changeApplicantStatus(
      ChangeStatusModel applicant) async {
    Either<Failure, Map<String, dynamic>> response =
        await jobService.changeApplicantStatus(applicant);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      AuthenticatedForm authResponse = AuthenticatedForm.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, AuthenticatedForm>> applyForJob(
      ApplyForJobModel applicant) async {
    Either<Failure, Map<String, dynamic>> response =
        await jobService.applForJob(applicant);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      AuthenticatedForm authResponse = AuthenticatedForm.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, JobApplicantModel>> getJobApplicants(
      String job) async {
    Either<Failure, Map<String, dynamic>> response =
        await jobService.getAllJobApplicants(job);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      JobApplicantModel authResponse = JobApplicantModel.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, JobApplicantModel>> getEmployerApplixants() async {
    Either<Failure, Map<String, dynamic>> response =
        await jobService.getAllEmployerApplicants();
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      JobApplicantModel authResponse = JobApplicantModel.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, JobApplicantModel>> getAllJobsUserAppliedfor() async {
    Either<Failure, Map<String, dynamic>> response =
        await jobService.getAllJobsUserAppliedfor();
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      JobApplicantModel authResponse = JobApplicantModel.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }
}

final jobRepositoryProvider = Provider<JobRepository>((ref) {
  return JobRepository(ref.read(jobServiceProvider));
});
