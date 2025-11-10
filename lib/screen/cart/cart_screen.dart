import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/cart_bloc/cart_bloc.dart';
import '../../card_in_cart.dart';
import '../../style/text_style.dart';

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
                    SizedBox(height: 20),
                    const TextOpenSans(
                      text: 'К оплате',
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                    TextOpenSans(
                      text: formatPrice(state.cart.sum),
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 40),
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

String formatPrice(int price) {
  final formatter = NumberFormat.decimalPattern('ru');
  return '${formatter.format(price)} руб.';
}
