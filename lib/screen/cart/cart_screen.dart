import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../card_in_cart.dart';
import '../../style/text_style.dart';
import '../catalog_screen/cart_bloc/bloc/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Корзина'))),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartInitialState) {
            if (state.cart.itemCount > 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.cart.productCount.length,
                        itemBuilder: (context, index) {
                          return CardInCart(
                            productCount: state.cart.productCount[index],
                            index: index,
                          );
                        },
                      ),
                    ),
                    const Text('К оплате'),
                    Text('${state.cart.sum}'),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextOpenSans(
                      text: 'Корзина пустая',
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                    TextOpenSans(
                      text: 'Добавьте все что вы хотите.',
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
