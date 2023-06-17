import 'package:equatable/equatable.dart';

import '../models/auth_model.dart';
import '../models/user_details.dart';

class UserDetailsState extends Equatable {
  const UserDetailsState();

  @override
  List<Object> get props => [];
}

class UserDetailsStateInitial extends UserDetailsState {
  const UserDetailsStateInitial();

  @override
  List<Object> get props => [];
}

class UserDetailsStateLaoding extends UserDetailsState {
  const UserDetailsStateLaoding();

  @override
  List<Object> get props => [];
}

class UserDetailsStateSuccess extends UserDetailsState {
  final UserDetails successData;
  const UserDetailsStateSuccess(this.successData);

  @override
  List<Object> get props => [];
}

class UserDetailsStateError extends UserDetailsState {
  final String error;
  const UserDetailsStateError(this.error);

  @override
  List<Object> get props => [error];
}
