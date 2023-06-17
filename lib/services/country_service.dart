import 'dart:convert';
import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/failure_model.dart';
import '../networklayer/connectivity.dart';
import '../storage/storage.dart';
import 'country_url.dart';

class CountryService extends CountryUrl {
  SecureStorage storage = SecureStorage();

  Future<Either<Failure, String>> generateToken() async {
    // check for connectivity before calling API

    bool connectionCheck =
        await InternetConnectionChecker.checkInternetConnectivity();

    if (connectionCheck) {
      try {
        http.Response response = await http.get(CountryUrl.getToken, headers: {
          "api-token": CountryUrl.accessToken,
          "user-email": CountryUrl.email,
        });

        var res = jsonDecode(response.body);

        log(response.body);
        return Right(res['auth_token']);
      } catch (e) {
        log(e.toString());
        Failure failure = Failure(e.toString(), false);
        return Left(failure);
      }
    } else {
      Failure failure = Failure("Unable to connect to the internet", false);
      return Left(failure);
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getAllCountry() async {
    //  get access token

    Either<Failure, String> access = await generateToken();

    if (access.isRight) {
      String token = access.right;

      try {
        http.Response response = await http.get(CountryUrl.getCountries,
            headers: {"Authorization": "Bearere $token"});

        log(response.body);
        

        var res = jsonDecode(response.body);

        var responseBody = jsonEncode({"countries": res});

        return Right(jsonDecode(responseBody));
      } catch (e) {
        log(e.toString());
        Failure failure = Failure(e.toString(), false);
        return Left(failure);
      }
    } else {
      return Left(access.left);
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getCountryStates(
      String state) async {
    //  get access token

    Either<Failure, String> access = await generateToken();

    if (access.isRight) {
      String token = access.right;

      try {
        http.Response response = await http.get(
            Uri.parse("${CountryUrl.getStates}/$state"),
            headers: {"Authorization": "Bearere $token"});

        log(response.body);
        

        var res = jsonDecode(response.body);

        var responseBody = jsonEncode({"states": res});

        return Right(jsonDecode(responseBody));
      } catch (e) {
        log(e.toString());
        Failure failure = Failure(e.toString(), false);
        return Left(failure);
      }
    } else {
      return Left(access.left);
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getStatesCities(
      String cities) async {
    //  get access token

    Either<Failure, String> access = await generateToken();

    if (access.isRight) {
      String token = access.right;

      try {
        http.Response response = await http.get(
            Uri.parse("${CountryUrl.getCities}/$cities"),
            headers: {"Authorization": "Bearere $token"});

        log(response.body);

        var res = jsonDecode(response.body);

        var responseBody = jsonEncode({"cities": res});

        return Right(jsonDecode(responseBody));
      } catch (e) {
        log(e.toString());
        Failure failure = Failure(e.toString(), false);
        return Left(failure);
      }
    } else {
      return Left(access.left);
    }
  }
}

final countryServiceProvider =
    Provider<CountryService>((ref) => CountryService());
