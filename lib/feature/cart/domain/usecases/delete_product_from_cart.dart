import 'package:equatable/equatable.dart';
import 'package:myshopcart/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:myshopcart/core/usecase/usecases.dart';
import 'package:myshopcart/feature/cart/domain/entities/cart_product.dart';
import 'package:myshopcart/feature/cart/domain/repositories/category_product_repositoy.dart';

class DeleteProductFromCartUsecase
    extends UseCase<List<CartProduct>, DeleteProductFromCartParams> {
  final CategoryProductRepository categoryProductRepository;

  DeleteProductFromCartUsecase({required this.categoryProductRepository});

  @override
  Future<Either<Failure, List<CartProduct>>> call(
      DeleteProductFromCartParams params) {
    return categoryProductRepository.deleteProductFromCart(params.product);
  }
}

class DeleteProductFromCartParams extends Equatable {
  final CartProduct product;

  const DeleteProductFromCartParams({required this.product});

  @override
  List<Object?> get props => throw UnimplementedError();
}
