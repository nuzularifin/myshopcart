import 'package:myshopcart/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:myshopcart/core/usecase/usecases.dart';
import 'package:myshopcart/feature/cart/domain/entities/response_products.dart';
import 'package:myshopcart/feature/cart/domain/repositories/category_product_repositoy.dart';

class GetCachedListProductUseCase extends UseCase<ResponseProducts, NoParams> {
  final CategoryProductRepository categoryProductRepository;

  GetCachedListProductUseCase({required this.categoryProductRepository});
  @override
  Future<Either<Failure, ResponseProducts>> call(NoParams params) {
    return categoryProductRepository.getCachedProductList();
  }
}
