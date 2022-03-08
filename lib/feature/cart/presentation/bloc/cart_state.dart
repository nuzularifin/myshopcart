part of 'cart_bloc.dart';

abstract class CartState {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartEmptyState extends CartState {}

class CartLoadedState extends CartState {
  final List<Product> productData;
  final List<Product> cartData;

  const CartLoadedState({required this.productData, required this.cartData});
}

class DetailLoadingState extends CartState {}

class DetailLoadedState extends CartState {
  final Product product;

  DetailLoadedState({required this.product});
}

class DetailLoadedFailedState extends CartState {
  final String message;

  DetailLoadedFailedState({required this.message});
}
