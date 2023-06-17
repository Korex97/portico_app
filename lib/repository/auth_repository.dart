import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/models/update_details_model.dart';


import '../models/auth_model.dart';
import '../models/failure_model.dart';
import '../models/login_model.dart';
import '../models/signup_model.dart';
import '../services/account_service.dart';

class AuthRepository {
  final AccountService accountService;
  AuthRepository(this.accountService);

  Future<Either<Failure, AuthModel>> login(LoginModel loginData) async {
    Either<Failure, Map<String, dynamic>> response =
        await accountService.loginUser(loginData);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      AuthModel authResponse = AuthModel.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, AuthModel>> signup(SignUpModel signupData) async {
    Either<Failure, Map<String, dynamic>> response =
        await accountService.signUp(signupData);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      AuthModel authResponse = AuthModel.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }
  
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(authServiceProvider));
});
