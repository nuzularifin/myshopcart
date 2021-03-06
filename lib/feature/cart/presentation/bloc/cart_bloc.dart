import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myshopcart/core/usecase/usecases.dart';
import 'package:myshopcart/feature/cart/domain/entities/product.dart';
import 'package:myshopcart/feature/cart/domain/entities/response_products.dart';
import 'package:myshopcart/feature/cart/domain/usecases/add_product_to_cart.dart';
import 'package:myshopcart/feature/cart/domain/usecases/delete_product_from_cart.dart';
import 'package:myshopcart/feature/cart/domain/usecases/get_cached_list_product.dart';
import 'package:myshopcart/feature/cart/domain/usecases/get_cart_list.dart';
import 'package:myshopcart/feature/cart/domain/usecases/get_detail_product.dart';
import 'package:myshopcart/feature/cart/domain/usecases/get_product_list.dart';
import 'package:myshopcart/feature/cart/domain/usecases/get_search_product.dart';
import 'package:myshopcart/feature/cart/domain/usecases/update_qty_product_from_cart.dart';

import '../../domain/entities/cart_product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetProductListUsecase getProductListUsecase;
  final GetCartListUsecase getCartListUsecase;
  final AddProductToCartUseCase addProductToCartUseCase;
  final DeleteProductFromCartUsecase deleteProductFromCartUsecase;
  final UpdateQtyProductFromCartUseCase updateQtyProductFromCartUseCase;
  final GetDetailProductUseCase getDetailProductUseCase;
  final GetCachedListProductUseCase getCachedListProductUseCase;
  final GetSearchProductUseCase getSearchProductUseCase;

  List<Product> productData = [];
  List<CartProduct> cartData = [];

  CartBloc(
      {required this.getProductListUsecase,
      required this.getCartListUsecase,
      required this.addProductToCartUseCase,
      required this.deleteProductFromCartUsecase,
      required this.updateQtyProductFromCartUseCase,
      required this.getDetailProductUseCase,
      required this.getCachedListProductUseCase,
      required this.getSearchProductUseCase})
      : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is ItemLoadedEvent) {
        emit(CartLoadingState());
        var product =
            await getProductListUsecase(GetProductListParams(page: event.page));
        bool statusRequest = false;
        product.fold((failure) async {
          productData = [];
          statusRequest = true;
        }, (response) {
          if (response.products!.product!.isEmpty) {
            productData = [];
            emit(CartEmptyState());
          } else {
            if (response.products!.product!.length < 5) emit(LastPage());
            productData = [];
            productData.addAll(response.products!.product!);
          }
        });

        if (statusRequest) {
          var productCached = await getCachedListProductUseCase(NoParams());
          statusRequest = false;
          productCached.fold((l) {
            productData = [];
            emit(CartEmptyState());
          }, (r) {
            emit(LastPage());
            if (r.products != null) productData.addAll(r.products!.product!);
          });
        }
        await checkCartItems();
        await checkingCartWithProduct();
        emit(CartLoadedState(cartData: cartData, productData: productData));
      } else if (event is ItemLoadedMorePage) {
        var product =
            await getProductListUsecase(GetProductListParams(page: event.page));
        product.fold((failure) {
          productData = [];
        }, (response) {
          if (response.products != null) {
            if (response.products!.product!.isNotEmpty &&
                response.products!.product!.length > 5) {
              emit(NextPage());
            } else {
              emit(LastPage());
            }
            productData.addAll(response.products!.product!);
          } else {
            emit(LastPage());
          }
        });
        await checkCartItems();
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
                type: event.type, cartproduct: event.selectedProduct));
        cartDB.fold((f) {}, (s) {
          cartData = [];
          cartData.addAll(s);
        });
        emit(CartLoadedState(cartData: cartData, productData: productData));
      } else if (event is DetailProductLoadedEvent) {
        emit(DetailLoadingState());
        var detailProduct = await getDetailProductUseCase(
            GetDetailProductParams(prdNo: event.prdNo));
        detailProduct.fold((l) {
          emit(DetailLoadedFailedState(message: "Get detail product failed!"));
        }, (r) {
          emit(DetailLoadedState(product: r));
        });
        emit(CartLoadedState(cartData: cartData, productData: productData));
      } else if (event is SearchProductEvent) {
        var search = await getSearchProductUseCase(
            GetSearchProductParams(query: event.query));
        search.fold((l) {}, (r) {
          productData = [];
          productData.addAll(r);
        });
        await checkCartItems();
        await checkingCartWithProduct();
        emit(LastPage());
        emit(CartLoadedState(cartData: cartData, productData: productData));
      }
    });
  }

  checkCartItems() async {
    var cartItems = await getCartListUsecase(NoParams());
    cartItems.fold((failure) {
      cartData = [];
    }, (success) {
      cartData = [];
      cartData.addAll(success);
    });
  }

  checkingCartWithProduct() async {
    for (var element in productData) {
      for (final data in cartData) {
        if (element.prdNo!.contains(data.prdNo)) {
          element.isSelected = true;
          // print('set product ${element.prdNo} to true');
        }
      }
    }
  }
}
