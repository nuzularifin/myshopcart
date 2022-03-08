import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:myshopcart/feature/cart/data/datasource/category_products_local_data_source.dart';
import 'package:myshopcart/feature/cart/data/datasource/category_products_remote_data_source.dart';
import 'package:myshopcart/feature/cart/data/repositories/category_product_repository_impl.dart';
import 'package:myshopcart/feature/cart/domain/repositories/category_product_repositoy.dart';
import 'package:myshopcart/feature/cart/domain/usecases/add_product_to_cart.dart';
import 'package:myshopcart/feature/cart/domain/usecases/delete_product_from_cart.dart';
import 'package:myshopcart/feature/cart/domain/usecases/get_cart_list.dart';
import 'package:myshopcart/feature/cart/domain/usecases/get_detail_product.dart';
import 'package:myshopcart/feature/cart/domain/usecases/get_product_list.dart';
import 'package:myshopcart/feature/cart/domain/usecases/update_qty_product_from_cart.dart';
import 'package:myshopcart/feature/cart/presentation/bloc/cart_bloc.dart';

import 'core/network/dio_service.dart';
import 'core/network/network_info.dart';
import 'core/utils/global_variables.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //!! Bloc Stuff
  sl.registerLazySingleton(() => CartBloc(
      getProductListUsecase: sl(),
      getCartListUsecase: sl(),
      addProductToCartUseCase: sl(),
      deleteProductFromCartUsecase: sl(),
      updateQtyProductFromCartUseCase: sl(), getDetailProductUseCase: sl()));

  //!! Data Source Stuff
  sl.registerLazySingleton<CategoryProductRemoteDataSource>(() =>
      CategoryProductRemoteDataSourceImpl(
          categoryProductsLocalDataSource: sl(), dioService: sl()));
  sl.registerLazySingleton<CategoryProductsLocalDataSource>(
      () => CategoryProductsLocalDataSourceImpl());

  //!! Repository Stuff
  sl.registerLazySingleton<CategoryProductRepository>(() =>
      CategoryProductRepositoryImpl(
          categoryProductRemoteDataSource: sl(),
          categoryProductsLocalDataSource: sl(),
          networkInfo: sl()));

  //! Usecase Stuff
  sl.registerLazySingleton(
      () => GetProductListUsecase(categoryProductRepository: sl()));
  sl.registerLazySingleton(
      () => GetDetailProductUseCase(categoryProductRepository: sl()));
  sl.registerLazySingleton(
      () => GetCartListUsecase(categoryProductRepository: sl()));
  sl.registerLazySingleton(
      () => AddProductToCartUseCase(categoryProductRepository: sl()));
  sl.registerLazySingleton(
      () => DeleteProductFromCartUsecase(categoryProductRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateQtyProductFromCartUseCase(categoryProductRepository: sl()));

  //! Core Stuff
  sl.registerLazySingleton(() => GlobalVariables());
  sl.registerLazySingleton(() => DioService());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));

  //!! External Lib
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
