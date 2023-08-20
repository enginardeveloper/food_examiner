import 'package:foodexaminer/configs/app_config.dart';
import 'package:foodexaminer/services/app_service/app_service.dart';

import '../../../core/keys/app_keys.dart';
import '../../local_storage_service/local_storage_service.dart';

class AppServiceImpl implements AppService {

  late final LocalStorageService _localStorageService;

  AppServiceImpl({required LocalStorageService localStorageService,}) : _localStorageService = localStorageService;

  @override
  bool get isDarkMode => 
      _localStorageService.getBool(key: AppKeys.isDarkModeKey) ?? false;

  @override
  bool get isFirstUse =>
      _localStorageService.getBool(key: AppKeys.isFirstUseKey) ?? true;

  @override
  String get locale => 
      _localStorageService.getString(key: AppKeys.localeKey) ?? AppConfig.defaultLocale;

  @override
  Future<void> setIsDarkMode({required bool isDarkMode}) async {
      return _localStorageService.setValue(key: AppKeys.isDarkModeKey, value: isDarkMode);
  }

  @override
  Future<void> setIsFirstUse({required bool isFirstUse}) async {
    return _localStorageService.setValue(key: AppKeys.isFirstUseKey, value: isFirstUse);
  }

  @override
  Future<void> setLocale({required String locale}) async {
    return _localStorageService.setValue(key: AppKeys.localeKey, value: locale);
  }
  
}