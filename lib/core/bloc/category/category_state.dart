part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<Category> category;
  final String currentCategory;
  final int index;

  CategoryLoadedState({
    this.category = const [],
    this.currentCategory = 'clothes',
    this.index = 0,
  });
}

class CategoryLoadingFailState extends CategoryState {}
