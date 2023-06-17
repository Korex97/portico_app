import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  dynamic tokenRead() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final readValue = prefs.getString(key) ?? 0;
    log('read: $readValue');
    return readValue;
  }

  Future<dynamic> tokenSave(token) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = token;
    prefs.setString(key, value);
    log('saved $value');
  }
}

SecureStorage secureStorage = SecureStorage();
