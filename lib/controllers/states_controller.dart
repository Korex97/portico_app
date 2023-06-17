import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/models/cities_model.dart';
import 'package:potrico/models/countries_model.dart';
import 'package:potrico/models/states_model.dart';
import 'package:potrico/states/cities_state.dart';
import '../models/failure_model.dart';
import '../repository/location_repository.dart';
import '../states/all_states_state.dart';


class StatesController extends StateNotifier<AllStatesState> {
  StatesController(this.ref) : super(const AllStatesStateInitial());

  final Ref ref;

  getAllStates(String country) async {
    state = const AllStatesStateLaoding();

    Either<Failure, StatesModel> response = await ref.read(countryRepositoryProvider).getAllStates(country);

    if (response.isRight) {
      state = AllStatesStateSuccess(response.right);
    } else {
      state = AllStatesStateError(response.left.message);
    }
  }

  resetState() async {
    state = const AllStatesStateInitial();
  }

}

final statesControllerProvider =
    StateNotifierProvider<StatesController, AllStatesState>((ref) {
  return StatesController(ref);
});

