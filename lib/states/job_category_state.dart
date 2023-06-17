import 'package:equatable/equatable.dart';

import '../models/job_category.dart';

class JobCategoryState extends Equatable {
  const JobCategoryState();

  @override
  List<Object> get props => [];
}

class JobCategoryStateInitial extends JobCategoryState {
  const JobCategoryStateInitial();

  @override
  List<Object> get props => [];
}

class JobCategoryStateLaoding extends JobCategoryState {
  const JobCategoryStateLaoding();

  @override
  List<Object> get props => [];
}

class JobCategoryStateSuccess extends JobCategoryState {
  final JobCategories successData;
  const JobCategoryStateSuccess(this.successData);

  @override
  List<Object> get props => [];
}

class JobCategoryStateError extends JobCategoryState {
  final String error;
  const JobCategoryStateError(this.error);

  @override
  List<Object> get props => [error];
}
