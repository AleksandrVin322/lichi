part of 'catalog_screen_bloc.dart';

@immutable
abstract class CatalogScreenEvent {}

class ProductsLoadedEvent extends CatalogScreenEvent {
  final String category;

  ProductsLoadedEvent({this.category = 'clothes'});
}
