import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/bloc/cart/cart_bloc.dart';

/// title [AppBar] для страницы каталога.
class AppBarTitle extends StatelessWidget {
  /// Конструктор [AppBarTitle].
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Text(
            'Каталог товаров',
            style: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(100),
                  ),
                ),
                onPressed: () => Navigator.of(context).pushNamed('cart_screen'),
                child: Row(
                  children: [
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartInitialState) {
                          return Text(
                            '${state.cart.itemCount}',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
