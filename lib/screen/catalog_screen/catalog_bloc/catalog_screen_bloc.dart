import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../entity/product.dart';
import '../../../service/api_client.dart';

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
