import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api_client.dart';
import '../../entity/category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ApiClient apiClient;
  CategoryBloc({required this.apiClient}) : super(CategoryInitial()) {
    on<CategoryLoadedEvent>(_getCategoryDetailList);
    on<CategorySwitchEvent>(_switchCategory);
    add(CategoryLoadedEvent());
  }

  Future<void> _getCategoryDetailList(
    CategoryLoadedEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final category = await apiClient.getCategoryDetail();
      category.insert(0, Category(name: 'Все', url: 'clothes'));
      emit(CategoryLoadedState(category: category));
    } catch (_) {
      emit(CategoryLoadingFailState());
    }
  }

  void _switchCategory(CategorySwitchEvent event, Emitter<CategoryState> emit) {
    try {
      if (state is CategoryLoadedState) {
        final currentState = state as CategoryLoadedState;
        emit(
          CategoryLoadedState(
            category: currentState.category,
            index: event.index,
          ),
        );
      }
    } catch (_) {
      emit(CategoryLoadingFailState());
    }
  }
}
