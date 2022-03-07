import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myshopcart/core/error/failure.dart';
import 'package:myshopcart/core/usecase/usecases.dart';
import 'package:myshopcart/feature/cart/domain/entities/product.dart';
import 'package:myshopcart/feature/cart/domain/repositories/category_product_repositoy.dart';

class AddProductToCartUseCase
    extends UseCase<List<Product>, AddProductToCartParams> {
  final CategoryProductRepository categoryProductRepository;

  AddProductToCartUseCase({required this.categoryProductRepository});

  @override
  Future<Either<Failure, List<Product>>> call(AddProductToCartParams params) {
    return categoryProductRepository.addProductToCart(params.product);
  }
}

class AddProductToCartParams extends Equatable {
  final Product product;

  const AddProductToCartParams({required this.product});

  @override
  List<Object?> get props => throw UnimplementedError();
}
