
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:display_products/cubits/products/product_state.dart';

import '../../domain/products.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(InitProductState());

  List<Products> products = [];
  Set<int> favoriteProductIds = {};

  void getProducts() async {
    emit(LoadingProductState());
    try {
      var response =
      await Dio().get("https://api.escuelajs.co/api/v1/products");

      if (response.statusCode! == 200 || response.statusCode! == 201) {
        for (var element in response.data) {
          products.add(Products.fromJson(element));
        }
        emit(SuccessProductState());
      } else {
        emit(FailedProductState());
      }
    } catch (error) {
      emit(FailedProductState());
    }
  }
}