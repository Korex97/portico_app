import 'dart:convert';
import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/add_job_model.dart';
import '../models/apply_for_job_model.dart';
import '../models/change_status_model.dart';
import '../models/failure_model.dart';
import '../networklayer/connectivity.dart';
import '../storage/storage.dart';
import 'base_url.dart';
import 'package:http/http.dart' as http;

class JobService extends BaseUrl {
  SecureStorage storage = SecureStorage();

  Future<Either<Failure, Map<String, dynamic>>> getJobPosted(
      {String value = "",
      String location = "",
      String category = "",
      String salaryRange = ""}) async {
    // get user Token
    var token = await storage.tokenRead();

    // check for connectivity before calling API
    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();


    if (connectionCheck) {
      try {
        http.Response response = await http.get(
          super.getAllJobs(value, category, location, salaryRange),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer $token"
          },
        );

        var responseBody = jsonEncode({
          'statusCode': response.statusCode,
          'body': jsonDecode(response.body)
        });

        log(response.body);
        return Right(jsonDecode(responseBody));
      } catch (e) {
        log(e.toString());
        Failure failure = Failure(e.toString(), false);
        return Left(failure);
      }
    } else {
      Failure failure = Failure("Unable to connect to the internet", false);
      return Left(failure);
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getAllJobApplicants(
      String job) async {
    // get user Token
    var token = await storage.tokenRead();

    // check for connectivity before calling API
    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      try {
        http.Response response = await http.get(
          super.getJobApplicants(job),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer $token"
          },
        );

        var responseBody = jsonEncode({
          'statusCode': response.statusCode,
          'body': jsonDecode(response.body)
        });

        log(response.body);
        return Right(jsonDecode(responseBody));
      } catch (e) {
        log(e.toString());
        Failure failure = Failure(e.toString(), false);
        return Left(failure);
      }
    } else {
      Failure failure = Failure("Unable to connect to the internet", false);
      return Left(failure);
    }
  }

  Future<Either<Failure, Map<String, dynamic>>>
      getAllEmployerApplicants() async {
    // get user Token
    var token = await storage.tokenRead();

    // check for connectivity before calling API
    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      try {
        http.Response response = await http.get(
          super.getEmployerJobApplicant,
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer $token"
          },
        );

        var responseBody = jsonEncode({
          'statusCode': response.statusCode,
          'body': jsonDecode(response.body)
        });

        log(response.body);
        return Right(jsonDecode(responseBody));
      } catch (e) {
        log(e.toString());
        Failure failure = Failure(e.toString(), false);
        return Left(failure);
      }
    } else {
      Failure failure = Failure("Unable to connect to the internet", false);
      return Left(failure);
    }
  }

  Future<Either<Failure, Map<String, dynamic>>>
      getAllJobsUserAppliedfor() async {
    // get user Token
    var token = await storage.tokenRead();

    // check for connectivity before calling API
    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      try {
        http.Response response = await http.get(
          super.getAllJobsAppliedFor,
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer $token"
          },
        );

        var responseBody = jsonEncode({
          'statusCode': response.statusCode,
          'body': jsonDecode(response.body)
        });

        log(response.body);
        return Right(jsonDecode(responseBody));
      } catch (e) {
        log(e.toString());
        Failure failure = Failure(e.toString(), false);
        return Left(failure);
      }
    } else {
      Failure failure = Failure("Unable to connect to the internet", false);
      return Left(failure);
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getJobCategory() async {
    // get user Token
    var token = await storage.tokenRead();

    // check for connectivity before calling API
    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      try {
        http.Response response = await http.get(
          super.getAllJobCategory,
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer $token"
          },
        );

        log(response.body);
        return Right(jsonDecode(response.body));
      } catch (e) {
        log(e.toString());
        Failure failure = Failure(e.toString(), false);
        return Left(failure);
      }
    } else {
      Failure failure = Failure("Unable to connect to the internet", false);
      return Left(failure);
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> addJob(
      AddJobModel jobData) async {
    // get user Token
    var token = await storage.tokenRead();

    var body = <String, dynamic>{};
    body['job_category'] = jobData.jobCategory;
    body['location'] = jobData.location;
    body['position'] = jobData.position;
    body['job_type'] = jobData.jobType;
    body['expected_salary'] = jobData.expectedSalary;
    body['experience_level'] = jobData.experienceLevel;
    body['requirements'] = jobData.requirements;

    // check for connectivity before calling API
    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      try {
        http.Response response = await http.post(super.addJobs,
            headers: {
              "Authorization": "Bearer $token",
            },
            body: body);

        var responseBody = jsonEncode({
          'statusCode': response.statusCode,
          'body': jsonDecode(response.body)
        });

        log(response.body);
        return Right(jsonDecode(responseBody));
      } catch (e) {
        log(e.toString());
        Failure failure = Failure(e.toString(), false);
        return Left(failure);
      }
    } else {
      Failure failure = Failure("Unable to connect to the internet", false);
      return Left(failure);
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getApplicantDetails(
      String applicant) async {
    // get user Token
    var token = await storage.tokenRead();

    var body = <String, dynamic>{};
    body['applicant'] = applicant;

    // check for connectivity before calling API
    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      try {
        http.Response response = await http.post(super.applicantsDetails,
            headers: {
              "Authorization": "Bearer $token",
            },
            body: body);

        var responseBody = jsonEncode({
          'statusCode': response.statusCode,
          'body': jsonDecode(response.body)
        });

        log(response.body);
        return Right(jsonDecode(responseBody));
      } catch (e) {
        log(e.toString());
        Failure failure = Failure(e.toString(), false);
        return Left(failure);
      }
    } else {
      Failure failure = Failure("Unable to connect to the internet", false);
      return Left(failure);
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> changeApplicantStatus(
      ChangeStatusModel applicant) async {
    // get user Token
    var token = await storage.tokenRead();

    var body = <String, dynamic>{};
    body['applicant'] = applicant.id;
    body['status'] = applicant.status;

    // check for connectivity before calling API
    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      try {
        http.Response response = await http.post(super.chnageApplicantStatusUri,
            headers: {
              "Authorization": "Bearer $token",
            },
            body: body);

        var responseBody = jsonEncode({
          'statusCode': response.statusCode,
          'body': jsonDecode(response.body)
        });

        log(response.body);
        return Right(jsonDecode(responseBody));
      } catch (e) {
        log(e.toString());
        Failure failure = Failure(e.toString(), false);
        return Left(failure);
      }
    } else {
      Failure failure = Failure("Unable to connect to the internet", false);
      return Left(failure);
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getJobFullDetails(
      String job) async {
    // get user Token
    var token = await storage.tokenRead();

    // check for connectivity before calling API
    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      try {
        http.Response response = await http.get(
          super.getJobDetails(job),
          headers: {
            "Authorization": "Bearer $token",
          },
        );

        var responseBody = jsonEncode({
          'statusCode': response.statusCode,
          'body': jsonDecode(response.body)
        });

        log(response.body);
        return Right(jsonDecode(responseBody));
      } catch (e) {
        log(e.toString());
        Failure failure = Failure(e.toString(), false);
        return Left(failure);
      }
    } else {
      Failure failure = Failure("Unable to connect to the internet", false);
      return Left(failure);
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> applForJob(
      ApplyForJobModel details) async {
    // check for connectivity before calling API

    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      var request = http.MultipartRequest('POST', super.applyForJobUri);
      var token = await storage.tokenRead();
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      request.fields['job_id'] = details.jobId;
      request.files.add(http.MultipartFile.fromBytes(
          'resume', details.resume.readAsBytesSync(),
          filename: details.resume.path));
      request.headers.addAll(headers);

      try {
        var streamedResponse = await request.send();
        http.Response response =
            await http.Response.fromStream(streamedResponse);

        var responseBody = jsonEncode({
          'status_code': response.statusCode,
          'body': jsonDecode(response.body)
        });

        log(response.body);
        return Right(jsonDecode(responseBody));
      } catch (e) {
        log(e.toString());
        Failure failure = Failure(e.toString(), false);
        return Left(failure);
      }
    } else {
      Failure failure = Failure("Unable to connect to the internet", false);
      return Left(failure);
    }
  }
}

final jobServiceProvider = Provider<JobService>((ref) => JobService());
