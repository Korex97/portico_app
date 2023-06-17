import 'package:equatable/equatable.dart';

import '../models/applicant_details_model.dart';
import '../models/job_applicants.dart';

class ApplicantDetailsState extends Equatable {
  const ApplicantDetailsState();

  @override
  List<Object> get props => [];
}

class ApplicantDetailsStateInitial extends ApplicantDetailsState {
  const ApplicantDetailsStateInitial();

  @override
  List<Object> get props => [];
}

class ApplicantDetailsStateLaoding extends ApplicantDetailsState {
  const ApplicantDetailsStateLaoding();

  @override
  List<Object> get props => [];
}

class ApplicantDetailsStateSuccess extends ApplicantDetailsState {
  final ApplicantDetailsModel successData;
  const ApplicantDetailsStateSuccess(this.successData);

  @override
  List<Object> get props => [];
}

class ApplicantDetailsStateError extends ApplicantDetailsState {
  final String error;
  const ApplicantDetailsStateError(this.error);

  @override
  List<Object> get props => [error];
}
