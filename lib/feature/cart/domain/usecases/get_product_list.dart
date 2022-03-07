import 'package:equatable/equatable.dart';
import 'package:myshopcart/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:myshopcart/core/usecase/usecases.dart';
import 'package:myshopcart/feature/cart/domain/entities/response_products.dart';
import 'package:myshopcart/feature/cart/domain/repositories/category_product_repositoy.dart';

class GetProductListUsecase
    extends UseCase<ResponseProducts, GetProductListParams> {
  final CategoryProductRepository categoryProductRepository;

  GetProductListUsecase({required this.categoryProductRepository});

  @override
  Future<Either<Failure, ResponseProducts>> call(GetProductListParams params) {
    return categoryProductRepository.getProductList(params.page);
  }
}

class GetProductListParams extends Equatable {
  final int page;

  const GetProductListParams({required this.page});

  @override
  List<Object?> get props => [page];
}
