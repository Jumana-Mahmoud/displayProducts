
import 'package:flutter/material.dart';

import '../widgets/products_screen_body.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ProductsScreenBody(
      ),
    );
  }
}
