// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw9_delivery_app/app/core/exceptions/repository_exception.dart';
import 'package:dw9_delivery_app/app/core/exceptions/unauthorized_exceptions.dart';
import 'package:dw9_delivery_app/app/core/rest_client/custom_dio.dart';
import 'package:dw9_delivery_app/app/models/auth_model.dart';
import 'package:dw9_delivery_app/app/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;

  AuthRepositoryImpl({required this.dio});

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await dio
          .unauth()
          .post('/auth', data: {'email': email, 'password': password});
      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      String msg = 'Erro ao relaizar login';

      if (e.response?.statusCode == 403) {
        log('Permissão negada', error: e, stackTrace: s);
        throw UnauthorizedExceptions();
      }

      log(msg, error: e, stackTrace: s);
      throw RepositoryException(message: msg);
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await dio.unauth().post('/users',
          data: {'name': name, 'email': email, 'password': password});
    } on DioError catch (e, s) {
      String msg = 'Erro ao registrar usuário';
      log(msg, error: e, stackTrace: s);
      throw RepositoryException(message: msg);
    }
  }
}
