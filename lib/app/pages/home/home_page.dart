import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:dw9_delivery_app/app/models/product_model.dart';
import 'package:dw9_delivery_app/app/pages/home/widgets/delivery_product_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (_, index) {
                return DeliveryProductTile(
                  product: ProductModel(
                    id: 0,
                    name: 'Sanduiche Natural',
                    description:
                        'Compre 2 deliciosos sanduiches pelo preço de 1, e aprecie o sabor',
                    price: 20.5,
                    image:
                        'https://www.minhareceita.com.br/app/uploads/2022/01/sanduiche-de-levissimo-no-pao-integral-2.jpg',
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
