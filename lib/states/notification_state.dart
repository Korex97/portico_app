import 'package:equatable/equatable.dart';
import '../models/notification_model.dart';

class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationStateInitial extends NotificationState {
  const NotificationStateInitial();

  @override
  List<Object> get props => [];
}

class NotificationStateLaoding extends NotificationState {
  const NotificationStateLaoding();

  @override
  List<Object> get props => [];
}

class NotificationStateSuccess extends NotificationState {
  final NotificationModel successData;
  const NotificationStateSuccess(this.successData);

  @override
  List<Object> get props => [];
}

class NotificationStateError extends NotificationState {
  final String error;
  const NotificationStateError(this.error);

  @override
  List<Object> get props => [error];
}
