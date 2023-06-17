import 'package:equatable/equatable.dart';

import '../models/countries_model.dart';
import '../models/job_details_model.dart';

class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

class CountryStateInitial extends CountryState {
  const CountryStateInitial();

  @override
  List<Object> get props => [];
}

class CountryStateLaoding extends CountryState {
  const CountryStateLaoding();

  @override
  List<Object> get props => [];
}

class CountryStateSuccess extends CountryState {
  final CountriesModel successData;
  const CountryStateSuccess(this.successData);

  @override
  List<Object> get props => [];
}

class CountryStateError extends CountryState {
  final String error;
  const CountryStateError(this.error);

  @override
  List<Object> get props => [error];
}
