part of 'catalog_bloc.dart';

@immutable
abstract class CatalogEvent {}

class CatalogLoadedEvent extends CatalogEvent {
  final String category;
  final int page;

  CatalogLoadedEvent({this.category = 'clothes', this.page = 1});
}
