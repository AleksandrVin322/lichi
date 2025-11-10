import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../entity/clothes.dart';
import '../../../service/api_client.dart';

part 'catalog_screen_event.dart';
part 'catalog_screen_state.dart';

class CatalogScreenBloc extends Bloc<CatalogScreenEvent, CatalogScreenState> {
  final ApiClient apiClient;

  CatalogScreenBloc({required this.apiClient}) : super(CatalogLoadedState()) {
    on<CatalogScreenLoadedEvent>(_getCategoryProductList);
  }

  Future<void> _getCategoryProductList(
    CatalogScreenLoadedEvent event,
    Emitter<CatalogScreenState> emit,
  ) async {
    emit(CatalogLoadingState());
    final clothes = await apiClient.getCategoryProductList();
    emit(CatalogLoadedState(clothes: clothes));
  }
}
