// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dw9_delivery_app/app/core/exceptions/repository_exception.dart';
import 'package:dw9_delivery_app/app/core/rest_client/custom_dio.dart';
import 'package:dw9_delivery_app/app/models/product_model.dart';
import 'package:dw9_delivery_app/app/repositories/products/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final CustomDio dio;

  ProductRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<ProductModel>> findAllProducts() async {
    try {
      final result = await dio.unauth().get('/products');
      return result.data
          .map<ProductModel>((p) => ProductModel.fromMap(p))
          .toList();
    } catch (e, s) {
      String msgErr = 'Erro ao buscar produtos';
      log(msgErr, error: e, stackTrace: s);
      throw RepositoryException(message: msgErr);
    }
  }
}
