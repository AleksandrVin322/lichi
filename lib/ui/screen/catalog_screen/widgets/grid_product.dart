import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/catalog/catalog_bloc.dart';
import '../../../../core/bloc/category/category_bloc.dart';
import '../../widgets/fail_widget.dart';
import 'body_grid_product.dart';

class GridProduct extends StatelessWidget {
  /// [BlocBuilder] для [CatalogBloc].
  const GridProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        return switch (state) {
          final CatalogLoadedState state => BodyGridProduct(state: state),
          CatalogLoadingFailState _ => FailWidget(
            func: () {
              context.read<CatalogBloc>().add(CatalogLoadedEvent());
              context.read<CategoryBloc>().add(CategoryLoadedEvent());
            },
          ),
          _ => const Center(
            child: CircularProgressIndicator(color: Colors.black),
          ),
        };
      },
    );
  }
}
