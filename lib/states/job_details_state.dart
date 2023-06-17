import 'package:equatable/equatable.dart';

import '../models/job_details_model.dart';
import '../models/job_full_details_model.dart';

class JobFullDetailsState extends Equatable {
  const JobFullDetailsState();

  @override
  List<Object> get props => [];
}

class JobFullDetailsStateInitial extends JobFullDetailsState {
  const JobFullDetailsStateInitial();

  @override
  List<Object> get props => [];
}

class JobFullDetailsStateLaoding extends JobFullDetailsState {
  const JobFullDetailsStateLaoding();

  @override
  List<Object> get props => [];
}

class JobFullDetailsStateSuccess extends JobFullDetailsState {
  final JobFullDetailsModel successData;
  const JobFullDetailsStateSuccess(this.successData);

  @override
  List<Object> get props => [];
}

class JobFullDetailsStateError extends JobFullDetailsState {
  final String error;
  const JobFullDetailsStateError(this.error);

  @override
  List<Object> get props => [error];
}
