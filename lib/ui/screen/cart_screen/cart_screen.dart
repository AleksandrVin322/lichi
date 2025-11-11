import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/cart/cart_bloc.dart';
import '../../widgets/fail_widget.dart';
import 'widgets/app_bar_title.dart';
import 'widgets/list_product_in_cart.dart';

/// Экран корзины.
class CartScreen extends StatelessWidget {
  /// Конструктор [CartScreen].
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: const AppBarTitle(),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return switch (state) {
            final CartInitialState state => ListProductInCart(state: state),
            CartFailState _ => FailWidget(
              func: () => context.read<CartBloc>().add(InitialEvent()),
            ),
            _ => const Center(
              child: CircularProgressIndicator(color: Colors.black),
            ),
          };
        },
      ),
    );
  }
}
