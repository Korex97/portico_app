import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:potrico/models/countries_model.dart';
import '../models/failure_model.dart';
import '../repository/location_repository.dart';
import '../states/countries_state.dart';


class CountriesController extends StateNotifier<CountryState> {
  CountriesController(this.ref) : super(const CountryStateInitial());

  final Ref ref;

  getAllCountries() async {
    state = const CountryStateLaoding();

    Either<Failure, CountriesModel> response = await ref.read(countryRepositoryProvider).getAllCountries();

    if (response.isRight) {
      state = CountryStateSuccess(response.right);
    } else {
      state = CountryStateError(response.left.message);
    }
  }

  resetState() async {
    state = const CountryStateInitial();
  }

}

final countriesControllerProvider =
    StateNotifierProvider<CountriesController, CountryState>((ref) {
  return CountriesController(ref);
});

