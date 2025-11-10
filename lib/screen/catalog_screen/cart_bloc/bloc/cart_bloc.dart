import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../entity/cart.dart';
import '../../../../entity/product.dart';
import '../../../../entity/product_count.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<AddProductEvent>(_addProduct);
    on<DeleteProductEvent>(_deleteProduct);
    on<IncrementCountProductEvent>(_incrementCountProduct);
    on<DecrementCountProductEvent>(_decrementCountProduct);
  }

  void _addProduct(AddProductEvent event, Emitter<CartState> emit) {
    final currentState = state as CartInitialState;
    final products = currentState.cart.productCount;
    var itemCount = currentState.cart.itemCount;
    var sum = currentState.cart.sum;
    final List<ProductCount> newList = [];
    bool productFound = false;

    for (final element in products) {
      if (element.product.name == event.product.name &&
          element.product.size == event.product.size) {
        final updateElement = ProductCount(
          product: element.product,
          count: element.count + 1,
        );
        newList.add(updateElement);
        itemCount += 1;
        sum += event.product.price;
        productFound = true;
      } else {
        newList.add(element);
      }
    }
    if (!productFound) {
      newList.add(ProductCount(product: event.product, count: 1));
      itemCount += 1;
      sum += event.product.price;
    }

    emit(
      CartInitialState(
        cart: Cart(productCount: newList, itemCount: itemCount, sum: sum),
      ),
    );
  }

  void _deleteProduct(DeleteProductEvent event, Emitter<CartState> emit) {
    final currentState = state as CartInitialState;
    final newList = currentState.cart.productCount;
    int itemCount = currentState.cart.itemCount;
    int sum = currentState.cart.sum;
    final deleteCount = newList[event.index].count;
    itemCount = itemCount - deleteCount;
    sum =
        sum -
        deleteCount * currentState.cart.productCount[event.index].product.price;
    newList.removeAt(event.index);
    emit(
      CartInitialState(
        cart: Cart(productCount: newList, itemCount: itemCount, sum: sum),
      ),
    );
  }

  void _incrementCountProduct(
    IncrementCountProductEvent event,
    Emitter<CartState> emit,
  ) {
    final currentState = state as CartInitialState;
    final newList = currentState.cart.productCount;
    newList[event.index].count = newList[event.index].count + 1;
    int itemCount = currentState.cart.itemCount + 1;
    int sum =
        currentState.cart.sum +
        currentState.cart.productCount[event.index].product.price;

    emit(
      CartInitialState(
        cart: Cart(productCount: newList, itemCount: itemCount, sum: sum),
      ),
    );
  }

  void _decrementCountProduct(
    DecrementCountProductEvent event,
    Emitter<CartState> emit,
  ) {
    final currentState = state as CartInitialState;
    final newList = currentState.cart.productCount;
    if (newList[event.index].count > 1) {
      newList[event.index].count = newList[event.index].count - 1;
      int itemCount = currentState.cart.itemCount - 1;
      int sum =
          currentState.cart.sum -
          currentState.cart.productCount[event.index].product.price;
      emit(
        CartInitialState(
          cart: Cart(productCount: newList, itemCount: itemCount, sum: sum),
        ),
      );
    }
  }
}
