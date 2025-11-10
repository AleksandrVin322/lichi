import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/app_bar_title.dart';
import 'widgets/grid_product.dart';
import 'widgets/pagination_buttons.dart';
import 'widgets/row_category.dart';
import 'widgets/theme_buttons.dart';

class CatalogScreen extends StatelessWidget {
  /// Главная страница с каталогом.
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppBarTitle(), scrolledUnderElevation: 0),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            child: Text(
              'Каждый день тысячи девушек распаковывают пакеты с новинками Lichi и становятся счастливее, ведь очевидно, что новое платье может изменить день, а с ним и всю жизнь!',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const ThemeButtons(),
          const SizedBox(height: 20),
          const RowCategory(),
          const SizedBox(height: 20),
          const GridProduct(),
          const PaginationButtons(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
