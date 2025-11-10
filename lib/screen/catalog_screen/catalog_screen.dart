import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/catalog_app_bar.dart';
import 'widgets/catalog_list_product.dart';
import 'widgets/catalog_row_category.dart';
import 'widgets/catalog_theme_buttons.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CatalogAppBar()),
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
          const CatalogThemeButtons(),
          const SizedBox(height: 20),
          const CatalogRowCategory(),
          const SizedBox(height: 20),
          const CatalogListProduct(),
        ],
      ),
    );
  }
}
