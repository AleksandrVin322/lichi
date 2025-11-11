import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/bloc/catalog/catalog_bloc.dart';
import 'card_product.dart';

/// [GridView] для списка продуктов по категориям.
class BodyGridProduct extends StatelessWidget {
  final CatalogLoadedState state;

  /// [GridView] для карточек товара в каталоге.
  const BodyGridProduct({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    if (state.products.isNotEmpty) {
      return Expanded(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.42,
          mainAxisSpacing: 20,
          children: List.generate(state.products.length, (index) {
            return CardProduct(product: state.products[index]);
          }),
        ),
      );
    } else {
      return Expanded(
        child: Center(
          child: Text(
            'Товары в данной категории отсутствую, пожалуйста выберите другую : (',
            style: GoogleFonts.openSans(
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
