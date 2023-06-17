import 'package:equatable/equatable.dart';
import 'package:potrico/models/authenticated_form.dart';

import '../models/auth_model.dart';

class AuthenticatedFormState extends Equatable {
  const AuthenticatedFormState();

  @override
  List<Object> get props => [];
}

class AuthenticatedFormStateInitial extends AuthenticatedFormState {
  const AuthenticatedFormStateInitial();

  @override
  List<Object> get props => [];
}

class AuthenticatedFormStateLaoding extends AuthenticatedFormState {
  const AuthenticatedFormStateLaoding();

  @override
  List<Object> get props => [];
}

class AuthenticatedFormStateSuccess extends AuthenticatedFormState {
  final AuthenticatedForm successData;
  const AuthenticatedFormStateSuccess(this.successData);

  @override
  List<Object> get props => [];
}

class AuthenticatedFormStateerror extends AuthenticatedFormState {
  final String error;
  const AuthenticatedFormStateerror(this.error);

  @override
  List<Object> get props => [error];
}
