import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api_client.dart';
import '../../dto/product.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final ApiClient apiClient;

  CatalogBloc({required this.apiClient}) : super(CatalogLoadedState()) {
    on<CatalogLoadedEvent>(_getCategoryProductList);
    add(CatalogLoadedEvent());
  }

  Future<void> _getCategoryProductList(
    CatalogLoadedEvent event,
    Emitter<CatalogState> emit,
  ) async {
    emit(CatalogLoadingState());
    try {
      final clothes = await apiClient.getCategoryProductList(
        category: event.category,
        page: event.page,
      );
      emit(CatalogLoadedState(products: clothes, currentPage: event.page));
    } catch (_) {
      emit(CatalogLoadingFailState());
    }
  }
}
