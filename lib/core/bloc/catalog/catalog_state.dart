part of 'catalog_bloc.dart';

@immutable
abstract class CatalogState {}

class CatalogLoadedState extends CatalogState {
  final List<Product> products;
  final int currentPage;

  CatalogLoadedState({this.products = const [], this.currentPage = 1});
}

class CatalogLoadingState extends CatalogState {}

class CatalogLoadingFailState extends CatalogState {}
