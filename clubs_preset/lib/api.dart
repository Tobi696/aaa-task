import 'package:clubs_preset/app_config.dart';
import 'package:clubs_preset/models/club.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';

class Api {
  // Singleton
  static final Api instance = Api();

  Dio? _dio;
  bool initialized = false;
  final List<LoggerService> loggers = [];

  Api() {
    initialize();
  }

  void addLogger(LoggerService logger) {
    loggers.add(logger);
  }

  Future<void> initialize() async {
    if (initialized) return;
    _dio = Dio();
    final path = await getApplicationDocumentsDirectory();
    _dio!.interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: HiveCacheStore(path.path),
          policy: CachePolicy.refreshForceCache,
        ),
      ),
    );
    initialized = true;
  }

  Future<List<Club>> getClubs() async {
    await initialize();
    try {
      final response =
          await _dio!.get('${AppConfig.instance.baseUrl}/clubs.json');
      return (response.data as List)
          .map((club) => Club.fromJson(club))
          .toList();
    } on Exception catch (e) {
      for (var logger in loggers) {
        logger.log(e.toString());
      }
      rethrow;
    }
  }
}

class LoggerService {
  void log(String message) {}
}
