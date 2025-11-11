import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../client/rest_client.dart';
import '../../dto/category.dart';

part 'category_event.dart';
part 'category_state.dart';

/// [Bloc] для списка категорий товаров.
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final RestClient restClient;
  CategoryBloc({required this.restClient}) : super(CategoryInitial()) {
    on<CategoryLoadedEvent>(_getCategoryDetailList);
    on<CategorySwitchEvent>(_switchCategory);
    add(CategoryLoadedEvent());
  }

  /// Получение списка категорий.
  Future<void> _getCategoryDetailList(
    CategoryLoadedEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      emit(CategoryLoadingState());
      final category = await restClient.getCategoryDetail();

      category.insert(0, Category(name: 'Все', url: 'clothes'));

      emit(CategoryLoadedState(category: category));
    } catch (_) {
      emit(CategoryLoadingFailState());
    }
  }

  /// Смена категории.
  void _switchCategory(CategorySwitchEvent event, Emitter<CategoryState> emit) {
    if (state is! CategoryLoadedState) {
      return;
    }
    final currentState = state as CategoryLoadedState;
    emit(
      CategoryLoadedState(
        category: currentState.category,
        index: event.index,
        currentCategory: event.currentCategory,
      ),
    );
  }
}
