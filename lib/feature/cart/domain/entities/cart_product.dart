import 'package:hive/hive.dart';

part 'cart_product.g.dart';

@HiveType(typeId: 3)
class CartProduct extends HiveObject {
  @HiveField(0)
  final String prdNm;
  @HiveField(1)
  final String prdNo;
  @HiveField(2)
  final String selPrc;
  @HiveField(3)
  final String dispCtgrNm;
  @HiveField(4)
  int qty;

  CartProduct(
      {required this.prdNm,
      required this.prdNo,
      required this.selPrc,
      required this.dispCtgrNm,
      required this.qty});
}
