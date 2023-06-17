import 'package:equatable/equatable.dart';
import '../models/cities_model.dart';

class CitiesState extends Equatable {
  const CitiesState();

  @override
  List<Object> get props => [];
}

class CitiesStateInitial extends CitiesState {
  const CitiesStateInitial();

  @override
  List<Object> get props => [];
}

class CitiesStateLaoding extends CitiesState {
  const CitiesStateLaoding();

  @override
  List<Object> get props => [];
}

class CitiesStateSuccess extends CitiesState {
  final CitiesModel successData;
  const CitiesStateSuccess(this.successData);

  @override
  List<Object> get props => [];
}

class CitiesStateError extends CitiesState {
  final String error;
  const CitiesStateError(this.error);

  @override
  List<Object> get props => [error];
}
