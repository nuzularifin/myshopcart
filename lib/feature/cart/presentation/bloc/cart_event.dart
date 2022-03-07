part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class ItemLoadedEvent extends CartEvent {
  final int page;
  final Products productData;
  final Products cartData;

  const ItemLoadedEvent(
      {required this.page, required this.productData, required this.cartData});
}

class AddingItemIntoCartEvent extends CartEvent {
  final Product selectedProduct;

  const AddingItemIntoCartEvent({required this.selectedProduct});
}

class DeletingItemFromCartEvent extends CartEvent {
  final Product selectedProduct;

  const DeletingItemFromCartEvent({required this.selectedProduct});
}

class UpdateQtyProductFromCartEvent extends CartEvent {
  final Product selectedProduct;
  final String type;

  const UpdateQtyProductFromCartEvent(
      {required this.type, required this.selectedProduct});
}
