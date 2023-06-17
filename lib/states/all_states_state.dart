import 'package:equatable/equatable.dart';
import 'package:potrico/models/states_model.dart';

class AllStatesState extends Equatable {
  const AllStatesState();

  @override
  List<Object> get props => [];
}

class AllStatesStateInitial extends AllStatesState {
  const AllStatesStateInitial();

  @override
  List<Object> get props => [];
}

class AllStatesStateLaoding extends AllStatesState {
  const AllStatesStateLaoding();

  @override
  List<Object> get props => [];
}

class AllStatesStateSuccess extends AllStatesState {
  final StatesModel successData;
  const AllStatesStateSuccess(this.successData);

  @override
  List<Object> get props => [];
}

class AllStatesStateError extends AllStatesState {
  final String error;
  const AllStatesStateError(this.error);

  @override
  List<Object> get props => [error];
}
