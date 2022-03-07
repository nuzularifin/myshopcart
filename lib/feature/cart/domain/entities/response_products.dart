import 'package:myshopcart/feature/cart/domain/entities/product.dart';

class ResponseProducts {
  Products? products;

  ResponseProducts({this.products});

  ResponseProducts.fromJson(Map<String, dynamic> json) {
    products =
        json['Products'] != null ? Products.fromJson(json['Products']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['Products'] = products!.toJson();
    }
    return data;
  }
}

class Products {
  List<Product>? product;

  Products({this.product});

  Products.fromJson(Map<String, dynamic> json) {
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductOptionDetails {
  String? addPrc;
  String? colCount;
  String? colOptPrice;
  String? optWght;
  String? selQty;
  String? sellerPrdOptCd;
  String? stckQty;
  String? stockNo;
  String? useYn;

  ProductOptionDetails(
      {this.addPrc,
      this.colCount,
      this.colOptPrice,
      this.optWght,
      this.selQty,
      this.sellerPrdOptCd,
      this.stckQty,
      this.stockNo,
      this.useYn});

  ProductOptionDetails.fromJson(Map<String, dynamic> json) {
    addPrc = json['addPrc'];
    colCount = json['colCount'];
    colOptPrice = json['colOptPrice'];
    optWght = json['optWght'];
    selQty = json['selQty'];
    sellerPrdOptCd = json['sellerPrdOptCd'];
    stckQty = json['stckQty'];
    stockNo = json['stockNo'];
    useYn = json['useYn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addPrc'] = addPrc;
    data['colCount'] = colCount;
    data['colOptPrice'] = colOptPrice;
    data['optWght'] = optWght;
    data['selQty'] = selQty;
    data['sellerPrdOptCd'] = sellerPrdOptCd;
    data['stckQty'] = stckQty;
    data['stockNo'] = stockNo;
    data['useYn'] = useYn;
    return data;
  }
}
