import 'package:myshopcart/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:myshopcart/core/usecase/usecases.dart';
import 'package:myshopcart/feature/cart/domain/entities/cart_product.dart';
import 'package:myshopcart/feature/cart/domain/repositories/category_product_repositoy.dart';

class GetCartListUsecase extends UseCase<List<CartProduct>, NoParams> {
  final CategoryProductRepository categoryProductRepository;

  GetCartListUsecase({required this.categoryProductRepository});

  @override
  Future<Either<Failure, List<CartProduct>>> call(NoParams params) {
    return categoryProductRepository.getCartList();
  }
}
