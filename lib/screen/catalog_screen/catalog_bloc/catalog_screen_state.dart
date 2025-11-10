part of 'catalog_screen_bloc.dart';

@immutable
abstract class CatalogScreenState {}

class CatalogLoadedState extends CatalogScreenState {
  final List<Clothes> clothes;
  CatalogLoadedState({this.clothes = const []});
}

class CatalogLoadingState extends CatalogScreenState {}
