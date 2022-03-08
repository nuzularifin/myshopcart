import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myshopcart/core/error/failure.dart';
import 'package:myshopcart/core/usecase/usecases.dart';
import 'package:myshopcart/feature/cart/domain/entities/response_products.dart';
import 'package:myshopcart/feature/cart/domain/repositories/category_product_repositoy.dart';

class GetDetailProductUseCase
    extends UseCase<ResponseProducts, GetDetailProductParams> {
  final CategoryProductRepository categoryProductRepository;

  GetDetailProductUseCase({required this.categoryProductRepository});

  @override
  Future<Either<Failure, ResponseProducts>> call(
      GetDetailProductParams params) {
    return categoryProductRepository.getDetailProduct(params.prdNo);
  }
}

class GetDetailProductParams extends Equatable {
  final int prdNo;

  const GetDetailProductParams({required this.prdNo});

  @override
  List<Object?> get props => [prdNo];
}
