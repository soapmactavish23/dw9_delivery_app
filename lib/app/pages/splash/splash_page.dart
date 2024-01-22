import 'package:dw9_delivery_app/app/core/config/env/env.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash'),
      ),
      body: Column(
        children: [
          Container(),
          DeliveryButton(label: Env.i['backend_base_url'] ?? ''),
          TextFormField()
        ],
      ),
    );
  }
}
