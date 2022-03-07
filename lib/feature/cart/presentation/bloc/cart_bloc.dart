import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myshopcart/core/usecase/usecases.dart';
import 'package:myshopcart/feature/cart/domain/entities/product.dart';
import 'package:myshopcart/feature/cart/domain/entities/response_products.dart';
import 'package:myshopcart/feature/cart/domain/usecases/add_product_to_cart.dart';
import 'package:myshopcart/feature/cart/domain/usecases/delete_product_from_cart.dart';
import 'package:myshopcart/feature/cart/domain/usecases/get_cart_list.dart';
import 'package:myshopcart/feature/cart/domain/usecases/get_product_list.dart';
import 'package:myshopcart/feature/cart/domain/usecases/update_qty_product_from_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetProductListUsecase getProductListUsecase;
  final GetCartListUsecase getCartListUsecase;
  final AddProductToCartUseCase addProductToCartUseCase;
  final DeleteProductFromCartUsecase deleteProductFromCartUsecase;
  final UpdateQtyProductFromCartUseCase updateQtyProductFromCartUseCase;

  List<Product> productData = [];
  List<Product> cartData = [];

  CartBloc(
      {required this.getProductListUsecase,
      required this.getCartListUsecase,
      required this.addProductToCartUseCase,
      required this.deleteProductFromCartUsecase,
      required this.updateQtyProductFromCartUseCase})
      : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is ItemLoadedEvent) {
        var product =
            await getProductListUsecase(GetProductListParams(page: event.page));
        product.fold((failure) {
          productData = [];
        }, (response) {
          if (response.products!.product!.isEmpty) {
            productData = [];
          } else {
            productData = response.products!.product!;
          }
        });
        var cartItems = await getCartListUsecase(NoParams());
        cartItems.fold((failure) {
          cartData = [];
        }, (success) {
          cartData = [];
          cartData.addAll(success);
        });
        checkingCartWithProduct();
        emit(CartLoadedState(cartData: cartData, productData: productData));
      } else if (event is AddingItemIntoCartEvent) {
        event.selectedProduct.isSelected = true;
        event.selectedProduct.qty = 1;
        var cartDB = await addProductToCartUseCase(
            AddProductToCartParams(product: event.selectedProduct));
        cartDB.fold((l) {}, (r) {
          cartData = [];
          cartData.addAll(r);
        });
        emit(CartLoadedState(cartData: cartData, productData: productData));
      } else if (event is DeletingItemFromCartEvent) {
        var cartDB = await deleteProductFromCartUsecase(
            DeleteProductFromCartParams(product: event.selectedProduct));
        cartDB.fold((l) {}, (r) {
          cartData = [];
          int index = productData.indexWhere(
              (element) => event.selectedProduct.prdNo == element.prdNo);
          if (index != -1) {
            productData[index].isSelected = false;
            productData[index].qty = 1;
          }
          cartData.addAll(r);
        });
        emit(CartLoadedState(cartData: cartData, productData: productData));
      } else if (event is UpdateQtyProductFromCartEvent) {
        var cartDB = await updateQtyProductFromCartUseCase(
            UpdateQtyProductParams(
                type: event.type, product: event.selectedProduct));
        cartDB.fold((f) {}, (s) {
          cartData = [];
          cartData.addAll(s);
        });
        emit(CartLoadedState(cartData: cartData, productData: productData));
      }
    });
  }

  void checkingCartWithProduct() {
    for (int a = 0; a < cartData.length; a++) {
      bool sameProd = false;
      for (int b = 0; b < productData.length; b++) {
        if (cartData[a].prdNo == productData[b].prdNo) {
          sameProd = true;
        } else {
          sameProd = false;
        }
        if (sameProd) {
          print(
              'Data yang sama dengan cart ${productData[b].prdNo} - $sameProd');
          productData[b].isSelected = true;
          sameProd = false;
        }
      }
    }
  }
}