import 'package:equatable/equatable.dart';

import '../models/job_applicants.dart';

class JobApplicantsState extends Equatable {
  const JobApplicantsState();

  @override
  List<Object> get props => [];
}

class JobApplicantsStateInitial extends JobApplicantsState {
  const JobApplicantsStateInitial();

  @override
  List<Object> get props => [];
}

class JobApplicantsStateLaoding extends JobApplicantsState {
  const JobApplicantsStateLaoding();

  @override
  List<Object> get props => [];
}

class JobApplicantsStateSuccess extends JobApplicantsState {
  final JobApplicantModel successData;
  const JobApplicantsStateSuccess(this.successData);

  @override
  List<Object> get props => [];
}

class JobApplicantsStateError extends JobApplicantsState {
  final String error;
  const JobApplicantsStateError(this.error);

  @override
  List<Object> get props => [error];
}
