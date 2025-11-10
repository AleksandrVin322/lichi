part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class InitialEvent extends CartEvent {}

class AddProductEvent extends CartEvent {
  final Product product;
  AddProductEvent({required this.product});
}

class DeleteProductEvent extends CartEvent {
  final Product product;
  DeleteProductEvent({required this.product});
}

class IncrementCountProductEvent extends CartEvent {
  final Product product;
  IncrementCountProductEvent({required this.product});
}

class DecrementCountProductEvent extends CartEvent {
  final Product product;
  DecrementCountProductEvent({required this.product});
}
