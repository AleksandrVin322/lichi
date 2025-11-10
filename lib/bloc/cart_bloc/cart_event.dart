part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class InitialEvent extends CartEvent {}

class AddProductEvent extends CartEvent {
  final Product product;
  AddProductEvent({required this.product});
}

class DeleteProductEvent extends CartEvent {
  final int index;
  DeleteProductEvent({required this.index});
}

class IncrementCountProductEvent extends CartEvent {
  final int index;
  IncrementCountProductEvent({required this.index});
}

class DecrementCountProductEvent extends CartEvent {
  final int index;
  DecrementCountProductEvent({required this.index});
}
