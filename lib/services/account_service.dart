import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:potrico/models/update_details_model.dart';
import '../models/education_form_model.dart';
import '../models/employee_details_form.dart';
import '../models/experience_form.dart';
import '../models/failure_model.dart';
import '../models/login_model.dart';
import '../models/signup_model.dart';
import '../networklayer/connectivity.dart';
import '../storage/storage.dart';
import 'base_url.dart';

class AccountService extends BaseUrl {
  SecureStorage storage = SecureStorage();

  Future<Either<Failure, Map<String, dynamic>>> loginUser(
      LoginModel loginData) async {
    // check for connectivity before calling API

    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      var body = <String, dynamic>{};
      body['email'] = loginData.email;
      body['password'] = loginData.password;

      try {
        http.Response response = await http.post(
          super.login,
          body: body,
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

  Future<Either<Failure, Map<String, dynamic>>> signUp(
      SignUpModel signupData) async {
    // check for connectivity before calling API

    bool connectionCheck = await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      var body = <String, dynamic>{};
      body['email'] = signupData.email;
      body['user_type'] = signupData.userType;
      body['password'] = signupData.password;
      body['confirmpassword'] = signupData.confirmpassword;

      try {
        http.Response response = await http.post(
          super.register,
          body: body,
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

  Future<Either<Failure, Map<String, dynamic>>> updateEmployeeDetails(
      EmployeeDetailsForm employeeData) async {
    // check for connectivity before calling API

    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      var token = await storage.tokenRead();
      var body = <String, dynamic>{};
      body['company_name'] = employeeData.companyName;
      body['company_location'] = employeeData.companyLocation;
      body['opening_date'] = employeeData.openingDate;
      body['company_bio'] = employeeData.companyBio;
      body['state'] = employeeData.stateLocated;

      try {
        http.Response response = await http.post(
          super.updateEmployerDetails,
          headers: {"Authorization": "Bearer $token"},
          body: body,
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

  Future<Either<Failure, Map<String, dynamic>>> updateEducationDetails(EducationForm education) async {
    // check for connectivity before calling API

    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      var token = await storage.tokenRead();
      var body = <String, dynamic>{};
      body['school_name'] = education.schoolName;
      body['field'] = education.field;

      try {
        http.Response response = await http.post(
          super.updateUserEducationDetails,
          headers: {"Authorization": "Bearer $token"},
          body: body,
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

  Future<Either<Failure, Map<String, dynamic>>> deleteEducation(String education) async {
    // check for connectivity before calling API

    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      var token = await storage.tokenRead();

      try {
        http.Response response = await http.get(
          Uri.parse("${super.deleteEducationDetails}?education_id=$education"),
          headers: {"Authorization": "Bearer $token"},
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

  Future<Either<Failure, Map<String, dynamic>>> updateExperienceDetails(ExperienceForm experience) async {
    // check for connectivity before calling API

    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      var token = await storage.tokenRead();
      var body = <String, dynamic>{};
      body['company'] = experience.company;
      body['role'] = experience.role;
      body['startdate'] = experience.startdate;
      body['enddate'] = experience.enddate;

      try {
        http.Response response = await http.post(
          super.updateExperience,
          headers: {"Authorization": "Bearer $token"},
          body: body,
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

  Future<Either<Failure, Map<String, dynamic>>> deleteExperienceDetails(String experience) async {
    // check for connectivity before calling API

    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      var token = await storage.tokenRead();

      try {
        http.Response response = await http.get(
          Uri.parse("${super.deleteExperience}?experience_id=$experience"),
          headers: {"Authorization": "Bearer $token"},
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

  Future<Either<Failure, Map<String, dynamic>>> updateUserInfo(
      UpdateDetails details) async {
    // check for connectivity before calling API

    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      var request = http.MultipartRequest('POST', super.updateInfo);
      var token = await storage.tokenRead();
      Map<String, String> headers = {"Authorization": "Bearer $token"};

      request.fields['phoneno'] = details.phoneno;
      request.fields['fullname'] = details.fullname;
      request.fields['city'] = details.city;
      request.fields['state'] = details.state;
      request.fields['country'] = details.country;
      request.fields['address'] = details.address;
      request.fields['gender'] = details.gender;
      request.fields['zipcode'] = details.zipcode;
      if ( details.imageChosen != null ){
        request.files.add(http.MultipartFile.fromBytes(
            'image', details.imageChosen!.readAsBytesSync(),
            filename: details.imageChosen!.path));
      }else{
        request.fields['image'] = details.currentImage;
      }
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

  Future<Either<Failure, Map<String, dynamic>>> getUserDetails() async {
    var token = await storage.tokenRead();

    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      try {
        http.Response response = await http.get(
          super.userdetails,
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

  Future<Either<Failure, Map<String, dynamic>>> getUserNotifications() async {
    var token = await storage.tokenRead();

    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      try {
        http.Response response = await http.get(
          super.usernotification,
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

}

final authServiceProvider = Provider<AccountService>((ref) => AccountService());
