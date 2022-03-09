import 'package:myshopcart/core/network/network_info.dart';
import 'package:myshopcart/feature/cart/data/datasource/category_products_local_data_source.dart';
import 'package:myshopcart/feature/cart/data/datasource/category_products_remote_data_source.dart';
import 'package:myshopcart/feature/cart/domain/entities/cart_product.dart';
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
  Future<Either<Failure, List<CartProduct>>> getCartList() async {
    return Right(await categoryProductsLocalDataSource.getCartProduct());
  }

  //? List Product from API
  @override
  Future<Either<Failure, ResponseProducts>> getProductList(int page) async {
    if (await networkInfo.isConnected) {
      return Right(await categoryProductRemoteDataSource.getProductList(page));
    } else {
      return Left(ServerFailure());
    }
  }

  //? List Product from DB
  @override
  Future<Either<Failure, ResponseProducts>> getCachedProductList() async {
    return Right(await categoryProductsLocalDataSource.getCachedProduct());
  }

  //? Detail Product
  @override
  Future<Either<Failure, Product>> getDetailProduct(String prdNo) async {
    if (await networkInfo.isConnected) {
      return Right(
          await categoryProductRemoteDataSource.getDetailProduct(prdNo));
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CartProduct>>> addProductToCart(
      Product product) async {
    return Right(
        await categoryProductsLocalDataSource.addProductToCart(product));
  }

  @override
  Future<Either<Failure, List<CartProduct>>> deleteProductFromCart(
      CartProduct product) async {
    return Right(
        await categoryProductsLocalDataSource.deleteProductFromCart(product));
  }

  @override
  Future<Either<Failure, List<CartProduct>>> updateQtyProductFromCart(
      String type, CartProduct product) async {
    return Right(await categoryProductsLocalDataSource.updateQtyProductFromCart(
        type, product));
  }

  @override
  Future<Either<Failure, List<Product>>> searchProduct(String query) async {
    return Right(await categoryProductsLocalDataSource.searchProduct(query));
  }
}
