import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../client/rest_client.dart';
import '../../dto/product.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

///[Bloc] для каталога.
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final RestClient restClient;

  CatalogBloc({required this.restClient}) : super(CatalogLoadedState()) {
    on<CatalogLoadedEvent>(_getCategoryProductList);
    add(CatalogLoadedEvent());
  }

  /// Получение списка продуктов по категории и по странице.
  Future<void> _getCategoryProductList(
    CatalogLoadedEvent event,
    Emitter<CatalogState> emit,
  ) async {
    emit(CatalogLoadingState());
    try {
      final clothes = await restClient.getCategoryProductList(
        category: event.category,
        page: event.page,
      );
      emit(CatalogLoadedState(products: clothes, currentPage: event.page));
    } catch (_) {
      emit(CatalogLoadingFailState());
    }
  }
}
