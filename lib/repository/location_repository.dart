import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cities_model.dart';
import '../models/countries_model.dart';
import '../models/failure_model.dart';
import '../models/states_model.dart';
import '../services/country_service.dart';

class CountryRepository {
  final CountryService countryService;
  CountryRepository(this.countryService);

  Future<Either<Failure, CountriesModel>> getAllCountries() async {
    Either<Failure, Map<String, dynamic>> response =
        await countryService.getAllCountry();
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      CountriesModel authResponse = CountriesModel.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, StatesModel>> getAllStates(String states) async {
    Either<Failure, Map<String, dynamic>> response = await countryService.getCountryStates(states);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      StatesModel authResponse = StatesModel.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  Future<Either<Failure, CitiesModel>> getAllCities(String cities) async {
    Either<Failure, Map<String, dynamic>> response =
        await countryService.getStatesCities(cities);
    if (response.isRight) {
      Map<String, dynamic> rightValue = response.right;
      CitiesModel authResponse = CitiesModel.fromJson(rightValue);
      return Right(authResponse);
    } else {
      return Left(response.left);
    }
  }

  
}

final countryRepositoryProvider = Provider<CountryRepository>((ref) {
  return CountryRepository(ref.read(countryServiceProvider));
});
