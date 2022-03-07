import 'package:dartz/dartz.dart';
import 'package:myshopcart/core/error/failure.dart';
import 'package:myshopcart/feature/cart/domain/entities/response_products.dart';

import '../entities/product.dart';

abstract class CategoryProductRepository {
  Future<Either<Failure, ResponseProducts>> getProductList(int page);
  Future<Either<Failure, List<Product>>> getCartList();
  //! From DB
  Future<Either<Failure, List<Product>>> addProductToCart(Product product);
  Future<Either<Failure, List<Product>>> deleteProductFromCart(Product product);
  Future<Either<Failure, List<Product>>> updateQtyProductFromCart(
      String type, Product product);

  Future<Either<Failure, ResponseProducts>> getProductListByCategory(
      int dispCtgrNo);
}
