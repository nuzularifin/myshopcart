import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myshopcart/core/error/failure.dart';
import 'package:myshopcart/core/usecase/usecases.dart';
import 'package:myshopcart/feature/cart/domain/entities/product.dart';
import 'package:myshopcart/feature/cart/domain/repositories/category_product_repositoy.dart';

class UpdateQtyProductFromCartUseCase
    extends UseCase<List<Product>, UpdateQtyProductParams> {
  final CategoryProductRepository categoryProductRepository;

  UpdateQtyProductFromCartUseCase({required this.categoryProductRepository});

  @override
  Future<Either<Failure, List<Product>>> call(UpdateQtyProductParams params) {
    return categoryProductRepository.updateQtyProductFromCart(
        params.type, params.product);
  }
}

class UpdateQtyProductParams extends Equatable {
  final Product product;
  final String type;

  const UpdateQtyProductParams({required this.type, required this.product});

  @override
  List<Object?> get props => [product, type];
}
