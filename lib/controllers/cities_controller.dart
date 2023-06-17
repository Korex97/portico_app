import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/models/cities_model.dart';
import 'package:potrico/states/cities_state.dart';
import '../models/failure_model.dart';
import '../repository/location_repository.dart';


class CitiesController extends StateNotifier<CitiesState> {
  CitiesController(this.ref) : super(const CitiesStateInitial());

  final Ref ref;

  getAllCities(String stateSelected) async {
    state = const CitiesStateLaoding();

    Either<Failure, CitiesModel> response = await ref.read(countryRepositoryProvider).getAllCities(stateSelected);

    if (response.isRight) {
      state = CitiesStateSuccess(response.right);
    } else {
      state = CitiesStateError(response.left.message);
    }
  }

  resetState() async {
    state = const CitiesStateInitial();
  }

}

final citiesControllerProvider =
    StateNotifierProvider<CitiesController, CitiesState>((ref) {
  return CitiesController(ref);
});

