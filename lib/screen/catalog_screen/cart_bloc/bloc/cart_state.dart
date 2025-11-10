part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitialState extends CartState {
  final Cart cart;
  CartInitialState({this.cart = const Cart(productCount: [])});
}
