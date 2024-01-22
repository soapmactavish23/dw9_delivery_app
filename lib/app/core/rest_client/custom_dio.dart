import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dw9_delivery_app/app/core/config/env/env.dart';

class CustomDio extends DioForNative {
  CustomDio()
      : super(
          BaseOptions(
            baseUrl: Env.i['backend_base_url'] ?? '',
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 6),
          ),
        ) {
    interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ),
    );
  }

  CustomDio auth() {
    return this;
  }

  CustomDio unauth() {
    return this;
  }
}
