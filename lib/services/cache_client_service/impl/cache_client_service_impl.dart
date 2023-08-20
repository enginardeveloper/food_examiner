import 'package:foodexaminer/services/cache_client_service/cache_client_service.dart';

class CacheClientServiceImpl implements CacheClientService {

  CacheClientServiceImpl() : _cache = <String, Object>{};
  final Map<String, Object> _cache;

  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}