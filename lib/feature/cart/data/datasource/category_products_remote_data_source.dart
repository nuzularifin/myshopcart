import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:myshopcart/core/error/exception.dart';
import 'package:myshopcart/core/network/dio_handling_response.dart';
import 'package:myshopcart/core/network/dio_service.dart';
import 'package:myshopcart/feature/cart/data/datasource/category_products_local_data_source.dart';
import 'package:myshopcart/feature/cart/domain/entities/product.dart';
import 'package:myshopcart/feature/cart/domain/entities/response_products.dart';
import 'package:xml2json/xml2json.dart';

abstract class CategoryProductRemoteDataSource {
  Future<ResponseProducts> getProductList(int page);
  Future<Product> getDetailProduct(String prdNo);
}

class CategoryProductRemoteDataSourceImpl
    implements CategoryProductRemoteDataSource {
  final DioService dioService;
  final CategoryProductsLocalDataSource categoryProductsLocalDataSource;

  CategoryProductRemoteDataSourceImpl(
      {required this.dioService,
      required this.categoryProductsLocalDataSource});

  @override
  Future<ResponseProducts> getProductList(int page) async {
    try {
      dioService.settingLog();
      var response = await dioService.dio
          .get('prodservices/product/listing', queryParameters: {"page": page});
      if (response.statusCode == 200) {
        Xml2Json xml2json = Xml2Json();
        xml2json.parse(response.data.toString());
        var json = xml2json.toParker();
        print(json);
        ResponseProducts categoryProduct =
            ResponseProducts.fromJson(jsonDecode(json));
        for (var element in categoryProduct.products!.product!) {
          element.qty = 1;
        }
        return categoryProduct;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw DioHandlingResponse(e).setThrow();
    }
  }

  @override
  Future<Product> getDetailProduct(String prdNo) async {
    try {
      dioService.settingLog();
      var response = await dioService.dio.get(
          'http://api.elevenia.co.id/rest/prodservices/product/details/$prdNo');
      if (response.statusCode == 200) {
        Xml2Json xml2json = Xml2Json();
        xml2json.parse(response.data.toString());
        var json = xml2json.toParker();
        print(json);
        final body = jsonDecode(json);
        Product categoryProduct = Product.fromJson(body['Product']);
        return categoryProduct;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw DioHandlingResponse(e).setThrow();
    }
  }
}
