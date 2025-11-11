import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/bloc/catalog/catalog_bloc.dart';
import '../../../../core/bloc/category/category_bloc.dart';

/// Виджет хранящий две кнопки для пагинации на странице каталога.
class PaginationButtons extends StatelessWidget {
  /// Конструктор [PaginationButtons].
  const PaginationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, catalogState) {
        return switch (catalogState) {
          final CatalogLoadedState catalogState =>
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, categoryState) {
                return switch (categoryState) {
                  final CategoryLoadedState categoryState => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: (catalogState.currentPage > 1)
                                ? Colors.black
                                : Colors.grey,
                          ),
                          onPressed: (catalogState.currentPage > 1)
                              ? () => context.read<CatalogBloc>().add(
                                  CatalogLoadedEvent(
                                    category: categoryState.currentCategory,
                                    page: catalogState.currentPage - 1,
                                  ),
                                )
                              : null,
                          child: Text(
                            'Предыдущая страница',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: (catalogState.products.isNotEmpty)
                                ? Colors.black
                                : Colors.grey,
                          ),
                          onPressed: (catalogState.products.isNotEmpty)
                              ? () => context.read<CatalogBloc>().add(
                                  CatalogLoadedEvent(
                                    category: categoryState.currentCategory,
                                    page: catalogState.currentPage + 1,
                                  ),
                                )
                              : null,
                          child: Text(
                            'Следующая страница',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  _ => const SizedBox(),
                };
              },
            ),
          _ => const SizedBox(),
        };
      },
    );
  }
}
