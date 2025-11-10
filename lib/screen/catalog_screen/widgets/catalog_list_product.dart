import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/catalog_bloc/catalog_screen_bloc.dart';
import '../../../widgets/fail_widget.dart';
import 'catalog_card_product.dart';

class CatalogListProduct extends StatelessWidget {
  const CatalogListProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogScreenBloc, CatalogScreenState>(
      builder: (context, state) {
        if (state is CatalogLoadedState) {
          return Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.45,
              children: List.generate(state.products.length, (index) {
                return CardProduct(product: state.products[index]);
              }),
            ),
          );
        } else if (state is CatalogLoadingFailState) {
          return const FailWidget();
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }
      },
    );
  }
}
