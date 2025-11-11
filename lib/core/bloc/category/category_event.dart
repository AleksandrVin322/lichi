part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class CategoryLoadedEvent extends CategoryEvent {}

class CategorySwitchEvent extends CategoryEvent {
  final int index;
  final String currentCategory;

  CategorySwitchEvent({this.index = 0, required this.currentCategory});
}
