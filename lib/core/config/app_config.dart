import 'package:dio/dio.dart';
import 'package:finderapp/core/api/api_interceptor.dart';
import 'package:finderapp/core/locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Import other configuration classes as needed
class AppConfig {
  final String baseUrl;
  final String dotenvFile;

  static AppConfig? _instance;

  // Factory constructor
  factory AppConfig({
    required String baseUrl,
    required String dotenvFile,
  }) {
    _instance ??= AppConfig._internal(
      baseUrl,
      dotenvFile
    );
    return _instance!;
  }

  // Private constructor
  AppConfig._internal(this.baseUrl, this.dotenvFile);

  // Singleton instance
  static AppConfig get instance => _instance!;

  // Dio instance
  Dio? _dio;

  // Other configuration instances can be declared here

  // Initialization method
  Future<void> init() async {

    await dotenv.load(fileName: AppConfig.instance.dotenvFile);

    // Initialize Dio
    _dio = Dio(BaseOptions(
        baseUrl: AppConfig.instance.baseUrl, 
        connectTimeout: const Duration(seconds: 30), 
        receiveTimeout: const Duration(seconds: 30),
        ),
      )
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
          enabled: !kReleaseMode /// show logger when not in release mode
        ),
      )
      ..interceptors.add(ApiInterceptor());

    // Initialize Service Locator
    await initServiceLocator();
  }

  // Getter for Dio instance
  Dio get dio {
    _dio ??= Dio(); // Lazy initialization
    return _dio!;
  }

}
