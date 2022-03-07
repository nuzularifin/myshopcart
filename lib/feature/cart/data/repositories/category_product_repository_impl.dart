import 'package:myshopcart/core/network/network_info.dart';
import 'package:myshopcart/feature/cart/data/datasource/category_products_local_data_source.dart';
import 'package:myshopcart/feature/cart/data/datasource/category_products_remote_data_source.dart';
import 'package:myshopcart/feature/cart/domain/entities/product.dart';
import 'package:myshopcart/feature/cart/domain/entities/response_products.dart';
import 'package:myshopcart/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:myshopcart/feature/cart/domain/repositories/category_product_repositoy.dart';

class CategoryProductRepositoryImpl extends CategoryProductRepository {
  final NetworkInfo networkInfo;
  final CategoryProductsLocalDataSource categoryProductsLocalDataSource;
  final CategoryProductRemoteDataSource categoryProductRemoteDataSource;

  CategoryProductRepositoryImpl(
      {required this.networkInfo,
      required this.categoryProductRemoteDataSource,
      required this.categoryProductsLocalDataSource});

  @override
  Future<Either<Failure, ResponseProducts>> getProductListByCategory(
      int dispCtgrNo) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> getCartList() async {
    return Right(await categoryProductsLocalDataSource.getCartProduct());
  }

  @override
  Future<Either<Failure, ResponseProducts>> getProductList(int page) async {
    if (await networkInfo.isConnected) {
      return Right(await categoryProductRemoteDataSource.getProductList(page));
    } else {
      return Right(await categoryProductsLocalDataSource.getCachedProduct());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> addProductToCart(
      Product product) async {
    return Right(
        await categoryProductsLocalDataSource.addProductToCart(product));
  }

  @override
  Future<Either<Failure, List<Product>>> deleteProductFromCart(
      Product product) async {
    return Right(
        await categoryProductsLocalDataSource.deleteProductFromCart(product));
  }

  @override
  Future<Either<Failure, List<Product>>> updateQtyProductFromCart(
      String type, Product product) async {
    return Right(await categoryProductsLocalDataSource.updateQtyProductFromCart(
        type, product));
  }
}
