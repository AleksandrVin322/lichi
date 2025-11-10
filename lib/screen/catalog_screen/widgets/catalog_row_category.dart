import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/catalog_bloc/catalog_screen_bloc.dart';
import '../../../bloc/category_bloc/category_bloc.dart';

class CatalogRowCategory extends StatelessWidget {
  const CatalogRowCategory({super.key});

  @override
  Widget build(BuildContext context) {
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
                                  color: Theme.of(context).primaryColor,
                                  width: state.category[index].name.length * 8,
                                )
                              : const SizedBox(),
                        ],
                      ),
                      onTap: () {
                        context.read<CatalogScreenBloc>().add(
                          ProductsLoadedEvent(
                            category: state.category[index].url,
                          ),
                        );
                        context.read<CategoryBloc>().add(
                          CategorySwitchEvent(index: index),
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
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }
      },
    );
  }
}
