import 'package:display_products/products/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/products/product_cubit.dart';
import '../../cubits/products/product_state.dart';

class ProductsScreenBody extends StatelessWidget {
  const ProductsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
      if (state is LoadingProductState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is InitProductState) {
        BlocProvider.of<ProductCubit>(context).getProducts();
        return const Center(
          child: Text('Starting fetching products'),
        );
      } else if (state is FailedProductState) {
        return const Center(
          child: Text('Failed to load products'),
        );
      } else if (state is SuccessProductState) {
        return const ProductsList();
      } else {
        return const Center(
          child: Text('Not defined'),
        );
      }
    },
    );
  }
}
