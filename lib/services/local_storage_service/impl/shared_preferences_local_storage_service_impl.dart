import 'dart:async';

import 'package:foodexaminer/injector/injector.dart';
import 'package:foodexaminer/services/log_service/log_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../local_storage_service.dart';

class SharedPreferencesLocalStorageServiceImpl implements LocalStorageService {

  late final SharedPreferences _sharedPreferences;
  late final LogService _logService;

  SharedPreferencesLocalStorageServiceImpl({required LogService logService}) {
    _logService = logService;
    init();
  }

  @override
  FutureOr<void> init() async {
    _sharedPreferences =  await SharedPreferences.getInstance();
    Injector.instance.signalReady(this);
  }

  @override
  Object? getValue({required String key}) {
    return _sharedPreferences.get(key);
  }

  @override
  FutureOr<void> setValue({required String key, required value}) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      await _sharedPreferences.setStringList(key, value);
    } else  {
      await _sharedPreferences.setString(key, value.toString());
      _logService.w('SharedPreferences did not support this type,'
      ' will save to String by toString() function.',);
    }
  }

  @override
  bool? getBool({required String key}) {
    return _sharedPreferences.getBool(key);
  }

  @override
  double? getDouble({required String key}) {
    return _sharedPreferences.getDouble(key);
  }

  @override
  int? getInt({required String key}) {
    return _sharedPreferences.getInt(key);
  }

  @override
  String? getString({required String key}) {
    return _sharedPreferences.getString(key);
  }

  @override
  List<String>? getStringList({required String key}) {
    return _sharedPreferences.getStringList(key);
  }

  @override
  FutureOr<bool> removeEntry({required String key}) async {
    final bool result = await _sharedPreferences.remove(key);
    return result;
  }



}