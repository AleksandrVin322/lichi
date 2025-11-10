import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/catalog_bloc/catalog_screen_bloc.dart';
import '../bloc/category_bloc/category_bloc.dart';

class FailWidget extends StatelessWidget {
  const FailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Произошла ошибка, пожалуйста, повторите позднее',
              style: GoogleFonts.openSans(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(100),
                ),
              ),
              onPressed: () {
                context.read<CatalogScreenBloc>().add(ProductsLoadedEvent());
                context.read<CategoryBloc>().add(CategoryLoadedEvent());
              },
              child: Text(
                'Повторить',
                style: GoogleFonts.openSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
