import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/products/product_cubit.dart';
import '../../cubits/products/product_state.dart';
import '../../domain/products.dart';
import 'favorite_icon.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500.0,
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is SuccessProductState) {
            List<Products> products =
                BlocProvider
                    .of<ProductCubit>(context)
                    .products;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return buildItemCard(context, products[index]);
              },
            );
          } else if (state is FailedProductState) {
            return const Center(
                child: Text('Error occurred while fetching products'));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildItemCard(BuildContext context, Products item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {},
          child: Card(
            elevation: 3,
            child: Stack(
              children: [
                item.images != null && item.images!.isNotEmpty
                    ? Image.network(
                  item.images![0],
                  width: 150,
                  height: 100,
                  fit: BoxFit.fill,
                )
                    : Image.asset(
                  'assets/images/macbook.png',
                  width: 150,
                  height: 100,
                  fit: BoxFit.fill,
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: FavoriteIcon(productId: item.id!,)
                ),
              ],
            ),
          ),
        ),
         _ItemInfoWidget(item),
      ],
    );
  }
}

class _ItemInfoWidget extends StatelessWidget {
  final Products item;

  const _ItemInfoWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 70.0,
          child: Text(
            maxLines: 2,
            item.title ?? '',
            style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                overflow: TextOverflow.ellipsis),
          ),
        ),
        Text(
          '\$${item.price}',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}