import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/models/authenticated_form.dart';
import 'package:potrico/models/employee_details_form.dart';
import 'package:potrico/models/update_details_model.dart';
import 'package:potrico/models/user_details.dart';


import '../models/auth_model.dart';
import '../models/education_form_model.dart';
import '../models/experience_form.dart';
import '../models/failure_model.dart';
import '../models/login_model.dart';
import '../models/notification_model.dart';
import '../models/signup_model.dart';
import '../services/account_service.dart';

class AccountRepository {
  final AccountService accountService;
  AccountRepository(this.accountService);

  Future<Either<Failure, AuthenticatedForm>> userInfo(UpdateDetails details) async {
    Either<Failure, Map<String, dynamic>> response =
        await accountService.updateUserInfo(details);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      AuthenticatedForm authResponse = AuthenticatedForm.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, AuthenticatedForm>> updateEmployeeDetails(EmployeeDetailsForm details) async {
    Either<Failure, Map<String, dynamic>> response =
        await accountService.updateEmployeeDetails(details);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      AuthenticatedForm authResponse = AuthenticatedForm.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, AuthenticatedForm>> updateEducationDetails(EducationForm details) async {
    Either<Failure, Map<String, dynamic>> response =
        await accountService.updateEducationDetails(details);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      AuthenticatedForm authResponse = AuthenticatedForm.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, AuthenticatedForm>> deleteEducation(String details) async {
    Either<Failure, Map<String, dynamic>> response =
        await accountService.deleteEducation(details);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      AuthenticatedForm authResponse = AuthenticatedForm.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

   Future<Either<Failure, AuthenticatedForm>> updateExperienceDetails(ExperienceForm details) async {
    Either<Failure, Map<String, dynamic>> response =
        await accountService.updateExperienceDetails(details);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      AuthenticatedForm authResponse = AuthenticatedForm.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, AuthenticatedForm>> deleteExperience(String details) async {
    Either<Failure, Map<String, dynamic>> response =
        await accountService.deleteExperienceDetails(details);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      AuthenticatedForm authResponse = AuthenticatedForm.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, UserDetails>> getDetails() async {
    Either<Failure, Map<String, dynamic>> response =
        await accountService.getUserDetails();
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      UserDetails authResponse = UserDetails.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }


  Future<Either<Failure, NotificationModel>> getUserNotifications() async {
    Either<Failure, Map<String, dynamic>> response = await accountService.getUserNotifications();
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      NotificationModel authResponse = NotificationModel.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }
  

  
}

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return AccountRepository(ref.read(authServiceProvider));
});
