import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/shared_preverence_api.dart';
import '../../entity/cart.dart';
import '../../entity/product.dart';
import '../../entity/product_with_count.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final SharedPreferencesApi sharedPreferencesApi;
  CartBloc({required this.sharedPreferencesApi}) : super(CartInitialState()) {
    on<AddProductEvent>(_addProduct);
    on<DeleteProductEvent>(_deleteProduct);
    on<IncrementCountProductEvent>(_incrementCountProduct);
    on<DecrementCountProductEvent>(_decrementCountProduct);
    on<InitialEvent>(_initCart);
    add(InitialEvent());
  }

  void _initCart(InitialEvent event, Emitter<CartState> emit) async {
    final Cart? cart = await sharedPreferencesApi.loadCart();
    emit(CartInitialState(cart: cart!));
  }

  void _addProduct(AddProductEvent event, Emitter<CartState> emit) async {
    final currentState = state as CartInitialState;
    final products = currentState.cart.productCount;
    var itemCount = currentState.cart.itemCount;
    var sum = currentState.cart.sum;
    final List<ProductWithCount> newList = [];
    bool productFound = false;

    for (final element in products) {
      if (element.product.name == event.product.name &&
          element.product.size == event.product.size) {
        final updateElement = ProductWithCount(
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
      newList.add(ProductWithCount(product: event.product, count: 1));
      itemCount += 1;
      sum += event.product.price;
    }
    sharedPreferencesApi.saveCart(
      Cart(productCount: newList, itemCount: itemCount, sum: sum),
    );
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
    sharedPreferencesApi.saveCart(
      Cart(productCount: newList, itemCount: itemCount, sum: sum),
    );
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
    sharedPreferencesApi.saveCart(
      Cart(productCount: newList, itemCount: itemCount, sum: sum),
    );
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
      sharedPreferencesApi.saveCart(
        Cart(productCount: newList, itemCount: itemCount, sum: sum),
      );
      emit(
        CartInitialState(
          cart: Cart(productCount: newList, itemCount: itemCount, sum: sum),
        ),
      );
    }
  }
}
