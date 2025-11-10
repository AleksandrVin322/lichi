import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api_client.dart';
import '../../entity/product.dart';

part 'catalog_screen_event.dart';
part 'catalog_screen_state.dart';

class CatalogScreenBloc extends Bloc<CatalogScreenEvent, CatalogScreenState> {
  final ApiClient apiClient;

  CatalogScreenBloc({required this.apiClient}) : super(CatalogLoadedState()) {
    on<ProductsLoadedEvent>(_getCategoryProductList);
    add(ProductsLoadedEvent());
  }

  Future<void> _getCategoryProductList(
    ProductsLoadedEvent event,
    Emitter<CatalogScreenState> emit,
  ) async {
    emit(CatalogLoadingState());
    final clothes = await apiClient.getCategoryProductList(event.category);
    emit(CatalogLoadedState(products: clothes));
  }
}
