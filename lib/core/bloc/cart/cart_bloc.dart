import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/database_client.dart';
import '../../dto/cart.dart';
import '../../dto/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final DatabaseClient sharedPreferencesApi;
  CartBloc({required this.sharedPreferencesApi}) : super(CartInitialState()) {
    on<AddProductEvent>(_addProduct);
    on<DeleteProductEvent>(_deleteProduct);
    on<IncrementCountProductEvent>(_incrementCountProduct);
    on<DecrementCountProductEvent>(_decrementCountProduct);
    on<InitialEvent>(_initCart);
    add(InitialEvent());
  }

  /// Загрузка списка товаров для корзины из базы данных.
  void _initCart(InitialEvent event, Emitter<CartState> emit) async {
    try {
      final Cart cart = await sharedPreferencesApi.loadCart();
      emit(CartInitialState(cart: cart));
    } catch (_) {
      emit(CartFailState());
    }
  }

  /// Добавить продукт в корзину.
  void _addProduct(AddProductEvent event, Emitter<CartState> emit) async {
    try {
      final currentState = state as CartInitialState;
      final products = Map<Product, int>.from(currentState.cart.products);

      if (products.containsKey(event.product)) {
        products[event.product] = products[event.product]! + 1;
      } else {
        products[event.product] = 1;
      }
      final (totalSum, itemCount) = _totalSumAndItemCount(products);

      sharedPreferencesApi.saveCart(
        Cart(products: products, itemCount: itemCount, totalSum: totalSum),
      );

      emit(
        CartInitialState(
          cart: Cart(
            products: products,
            itemCount: itemCount,
            totalSum: totalSum,
          ),
        ),
      );
    } catch (_) {
      emit(CartFailState());
    }
  }

  /// Удалить продукт из корзины.
  void _deleteProduct(DeleteProductEvent event, Emitter<CartState> emit) {
    try {
      final currentState = state as CartInitialState;
      final products = Map<Product, int>.from(currentState.cart.products);
      products.remove(event.product);
      final (totalSum, itemCount) = _totalSumAndItemCount(products);
      sharedPreferencesApi.saveCart(
        Cart(products: products, itemCount: itemCount, totalSum: totalSum),
      );
      emit(
        CartInitialState(
          cart: Cart(
            products: products,
            itemCount: itemCount,
            totalSum: totalSum,
          ),
        ),
      );
    } catch (_) {
      emit(CartFailState());
    }
  }

  /// Увеличить количество продукта на 1 в корзине.
  void _incrementCountProduct(
    IncrementCountProductEvent event,
    Emitter<CartState> emit,
  ) {
    try {
      final currentState = state as CartInitialState;
      final products = Map<Product, int>.from(currentState.cart.products);
      products[event.product] = products[event.product]! + 1;
      final (totalSum, itemCount) = _totalSumAndItemCount(products);
      sharedPreferencesApi.saveCart(
        Cart(products: products, itemCount: itemCount, totalSum: totalSum),
      );
      emit(
        CartInitialState(
          cart: Cart(
            products: products,
            itemCount: itemCount,
            totalSum: totalSum,
          ),
        ),
      );
    } catch (_) {
      emit(CartFailState());
    }
  }

  /// Уменьшить количество продукта на 1 в корзине.
  void _decrementCountProduct(
    DecrementCountProductEvent event,
    Emitter<CartState> emit,
  ) {
    try {
      final currentState = state as CartInitialState;
      final products = Map<Product, int>.from(currentState.cart.products);
      if (products[event.product]! > 1) {
        products[event.product] = products[event.product]! - 1;
        final (totalSum, itemCount) = _totalSumAndItemCount(products);
        sharedPreferencesApi.saveCart(
          Cart(products: products, itemCount: itemCount, totalSum: totalSum),
        );
        emit(
          CartInitialState(
            cart: Cart(
              products: products,
              itemCount: itemCount,
              totalSum: totalSum,
            ),
          ),
        );
      }
    } catch (_) {
      emit(CartFailState());
    }
  }
}

/// Функция для расчета суммы корзины и количества продуктов в корзине.
(int, int) _totalSumAndItemCount(Map<Product, int> products) {
  final itemCount = products.values.fold(
    0,
    (itemCount, count) => itemCount + count,
  );
  final totalSum = products.entries.fold(
    0,
    (totalSum, product) => totalSum + (product.value * product.key.price),
  );
  return (totalSum, itemCount);
}
