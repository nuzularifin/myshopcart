import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myshopcart/core/error/failure.dart';
import 'package:myshopcart/core/usecase/usecases.dart';
import 'package:myshopcart/feature/cart/domain/entities/cart_product.dart';
import 'package:myshopcart/feature/cart/domain/repositories/category_product_repositoy.dart';

class UpdateQtyProductFromCartUseCase
    extends UseCase<List<CartProduct>, UpdateQtyProductParams> {
  final CategoryProductRepository categoryProductRepository;

  UpdateQtyProductFromCartUseCase({required this.categoryProductRepository});

  @override
  Future<Either<Failure, List<CartProduct>>> call(
      UpdateQtyProductParams params) {
    return categoryProductRepository.updateQtyProductFromCart(
        params.type, params.cartproduct);
  }
}

class UpdateQtyProductParams extends Equatable {
  final CartProduct cartproduct;
  final String type;

  const UpdateQtyProductParams({required this.type, required this.cartproduct});

  @override
  List<Object?> get props => [cartproduct, type];
}
