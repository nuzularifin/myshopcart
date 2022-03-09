import 'package:equatable/equatable.dart';
import 'package:myshopcart/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:myshopcart/core/usecase/usecases.dart';
import 'package:myshopcart/feature/cart/domain/entities/product.dart';
import 'package:myshopcart/feature/cart/domain/repositories/category_product_repositoy.dart';

class GetSearchProductUseCase
    extends UseCase<List<Product>, GetSearchProductParams> {
  final CategoryProductRepository categoryProductRepository;

  GetSearchProductUseCase({required this.categoryProductRepository});

  @override
  Future<Either<Failure, List<Product>>> call(GetSearchProductParams params) {
    return categoryProductRepository.searchProduct(params.query);
  }
}

class GetSearchProductParams extends Equatable {
  final String query;

  const GetSearchProductParams({required this.query});

  @override
  List<Object?> get props => [query];
}
