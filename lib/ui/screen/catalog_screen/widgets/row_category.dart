import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/catalog/catalog_bloc.dart';
import '../../../../core/bloc/category/category_bloc.dart';
import '../../../../core/bloc/theme/theme_bloc.dart';

/// [Row] с категориями товаров.
class RowCategory extends StatelessWidget {
  /// Конструктор [RowCategory].
  const RowCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, stateTheme) {
        return BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoadedState) {
              return SizedBox(
                height: 25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.category.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        const SizedBox(width: 5),
                        InkWell(
                          child: Column(
                            children: [
                              Text(state.category[index].name),
                              (state.index == index)
                                  ? Container(
                                      height: 2,
                                      color: (stateTheme is LightThemeState)
                                          ? Colors.black
                                          : Colors.white,
                                      width:
                                          state.category[index].name.length * 8,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          onTap: () {
                            context.read<CatalogBloc>().add(
                              CatalogLoadedEvent(
                                category: state.category[index].url,
                              ),
                            );
                            context.read<CategoryBloc>().add(
                              CategorySwitchEvent(
                                index: index,
                                currentCategory: state.category[index].url,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 5),
                      ],
                    );
                  },
                ),
              );
            } else if (state is CategoryLoadingFailState) {
              return const SizedBox();
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
          },
        );
      },
    );
  }
}
