// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dw9_delivery_app/app/core/extensions/formatter_extension.dart';
import 'package:dw9_delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_style.dart';
import 'package:flutter/material.dart';

import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingBagWidget extends StatelessWidget {
  final List<OrderProductDto> bag;
  const ShoppingBagWidget({
    Key? key,
    required this.bag,
  }) : super(key: key);

  Future<void> _goOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final sp = await SharedPreferences.getInstance();
    // sp.clear();
    if (!sp.containsKey('accessToken')) {
      final loginResult = await navigator.pushNamed('/auth/login');

      if (loginResult == null || loginResult == false) {
        return;
      }
    }

    await navigator.pushNamed('/order', arguments: bag);
  }

  @override
  Widget build(BuildContext context) {
    String totalBag = bag
        .fold<double>(0.0, (total, element) => total += element.totalPrice)
        .currencyPTBR;

    return Container(
      width: context.screenWidth,
      height: 90,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          _goOrder(context);
        },
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Ver sacola',
                style: context.textStyles.textExtraBold
                    .copyWith(fontSize: 14, color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                totalBag,
                style: context.textStyles.textExtraBold
                    .copyWith(fontSize: 11, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
