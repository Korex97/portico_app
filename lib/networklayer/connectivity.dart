import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class InternetConnectionChecker {

  static const int timeOutDuration = 60;

  // Function to check if device is connected to the internet
  static Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      try {
        var response = await http.get(Uri.parse('https://portico.com.ng/'))
            .timeout(const Duration(seconds: timeOutDuration));
        return response.statusCode == 200;
      } on TimeoutException catch (_) {
        return false;
      } catch (_) {
        return false;
      }
    }
  }

}