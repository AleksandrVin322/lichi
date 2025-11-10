import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../bloc/cart_bloc/cart_bloc.dart';
import 'card_in_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            const Center(child: Text('Корзина')),
          ],
        ),
      ),
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
                    const SizedBox(height: 20),
                    Text(
                      'К оплате',
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      formatPrice(state.cart.sum),
                      style: GoogleFonts.openSans(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Корзина пустая'),
                    Text('Добавьте все что вы хотите.'),
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
