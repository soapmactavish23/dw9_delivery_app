import 'package:dw9_delivery_app/app/core/rest_client/custom_dio.dart';
import 'package:dw9_delivery_app/app/pages/home/home_page.dart';
import 'package:dw9_delivery_app/app/repositories/products/product_repository.dart';
import 'package:dw9_delivery_app/app/repositories/products/product_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ProductRepository>(
            create: (context) => ProductRepositoryImpl(
              dio: context.read<CustomDio>(),
            ),
          )
        ],
        child: const HomePage(),
      );
}
