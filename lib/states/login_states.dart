import 'package:equatable/equatable.dart';

import '../models/auth_model.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginStateInitial extends LoginState {
  const LoginStateInitial();

  @override
  List<Object> get props => [];
}

class LoginStateLaoding extends LoginState {
  const LoginStateLaoding();

  @override
  List<Object> get props => [];
}

class LoginStateSuccess extends LoginState {
  final AuthModel successData;
  const LoginStateSuccess(this.successData);

  @override
  List<Object> get props => [];
}

class LoginStateerror extends LoginState {
  final String error;
  const LoginStateerror(this.error);

  @override
  List<Object> get props => [error];
}
