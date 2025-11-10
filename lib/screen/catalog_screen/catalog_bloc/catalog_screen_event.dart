part of 'catalog_screen_bloc.dart';

@immutable
abstract class CatalogScreenEvent {}

class CatalogScreenLoadingEvent extends CatalogScreenEvent {}

class CatalogScreenLoadedEvent extends CatalogScreenEvent {}
