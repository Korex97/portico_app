import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth_model.dart';
import '../models/failure_model.dart';
import '../models/login_model.dart';
import '../models/signup_model.dart';
import '../models/update_details_model.dart';
import '../repository/auth_repository.dart';
import '../states/login_states.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginStateInitial());

  final Ref ref;

  login(LoginModel loginData) async {
    state = const LoginStateLaoding();

    Either<Failure, AuthModel> response =
        await ref.read(authRepositoryProvider).login(loginData);

    if (response.isRight) {
      state = LoginStateSuccess(response.right);
      // return Right(response.right);
    } else {
      state = LoginStateerror(response.left.message);
      // return Left(response.left);
    }
  }

  signup( SignUpModel signupData ) async {
    state = const LoginStateLaoding();

    Either<Failure, AuthModel> response =
        await ref.read(authRepositoryProvider).signup(signupData);

    if (response.isRight) {
      state = LoginStateSuccess(response.right);
    } else {
      state = LoginStateerror(response.left.message);
    }
  }

  resetState() async {
    state = const LoginStateInitial();
  }

}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});

final loginProviderNotifier = Provider<LoginState>((ref) {
  final loginState = ref.watch(loginControllerProvider);

  return loginState;
});
