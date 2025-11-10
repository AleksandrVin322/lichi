part of 'catalog_screen_bloc.dart';

@immutable
abstract class CatalogScreenState {}

class CatalogLoadedState extends CatalogScreenState {
  final List<Product> products;

  CatalogLoadedState({this.products = const []});
}

class CatalogLoadingState extends CatalogScreenState {}

class CatalogLoadingFailState extends CatalogScreenState {}
