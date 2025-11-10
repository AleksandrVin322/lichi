import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/bloc/cart/cart_bloc.dart';
import 'card_in_cart.dart';

class ListProductInCart extends StatelessWidget {
  final CartInitialState state;
  const ListProductInCart({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    if (state.cart.itemCount > 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.cart.products.keys.length,
                itemBuilder: (context, index) {
                  return CardInCart(
                    products: state.cart.products,
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
              _formatPrice(state.cart.totalSum),
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
  }
}

String _formatPrice(int price) {
  final formatter = NumberFormat.decimalPattern('ru');
  return '${formatter.format(price)} руб.';
}
