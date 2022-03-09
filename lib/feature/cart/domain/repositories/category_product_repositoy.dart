import 'package:dartz/dartz.dart';
import 'package:myshopcart/core/error/failure.dart';
import 'package:myshopcart/feature/cart/domain/entities/cart_product.dart';
import 'package:myshopcart/feature/cart/domain/entities/response_products.dart';

import '../entities/product.dart';

abstract class CategoryProductRepository {
  Future<Either<Failure, ResponseProducts>> getProductList(int page);
  Future<Either<Failure, List<Product>>> searchProduct(String query);
  Future<Either<Failure, Product>> getDetailProduct(String prdNo);
  Future<Either<Failure, List<CartProduct>>> getCartList();
  //! From DB
  Future<Either<Failure, ResponseProducts>> getCachedProductList();
  Future<Either<Failure, List<CartProduct>>> addProductToCart(Product product);
  Future<Either<Failure, List<CartProduct>>> deleteProductFromCart(
      CartProduct product);
  Future<Either<Failure, List<CartProduct>>> updateQtyProductFromCart(
      String type, CartProduct product);
}
