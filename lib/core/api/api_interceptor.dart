import 'package:dio/dio.dart';
import 'package:finderapp/core/utils/app_logger.dart';
import 'package:finderapp/core/utils/app_strings.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    appLogger.d(response.statusCode);
    appLogger.d(response.data);
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    appLogger.d(err);
    appLogger.d(err.message);
    appLogger.d(err.response);
    return super.onError(err, handler);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    appLogger.d(options.uri);
    appLogger.d(options.data.toString());

    options.headers['Authorization'] = 'Bearer ${dotenv.env[AppStrings.mockApiToken]}';

    return super.onRequest(options, handler);
  }
}
