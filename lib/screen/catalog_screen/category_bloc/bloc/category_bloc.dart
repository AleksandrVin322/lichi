import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../entity/category.dart';
import '../../../../service/api_client.dart';

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
    final category = await apiClient.getCategoryDetail();
    category.insert(0, Category(name: 'Все', url: 'clothes'));
    emit(CategoryLoadedState(category: category));
  }

  void _switchCategory(CategorySwitchEvent event, Emitter<CategoryState> emit) {
    if (state is CategoryLoadedState) {
      final currentState = state as CategoryLoadedState;
      emit(
        CategoryLoadedState(
          category: currentState.category,
          index: event.index,
        ),
      );
    }
  }
}
