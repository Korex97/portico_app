import 'package:equatable/equatable.dart';

import '../models/job_details_model.dart';

class JobDetailsState extends Equatable {
  const JobDetailsState();

  @override
  List<Object> get props => [];
}

class JobDetailsStateInitial extends JobDetailsState {
  const JobDetailsStateInitial();

  @override
  List<Object> get props => [];
}

class JobDetailsStateLaoding extends JobDetailsState {
  const JobDetailsStateLaoding();

  @override
  List<Object> get props => [];
}

class JobDetailsStateSuccess extends JobDetailsState {
  final JobDetailsModel successData;
  const JobDetailsStateSuccess(this.successData);

  @override
  List<Object> get props => [];
}

class JobDetailsStateError extends JobDetailsState {
  final String error;
  const JobDetailsStateError(this.error);

  @override
  List<Object> get props => [error];
}
