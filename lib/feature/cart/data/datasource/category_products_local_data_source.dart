import 'package:hive/hive.dart';
import 'package:myshopcart/feature/cart/domain/entities/cart_product.dart';
import 'package:myshopcart/feature/cart/domain/entities/response_products.dart';
import '../../domain/entities/product.dart';

abstract class CategoryProductsLocalDataSource {
  Future<List<CartProduct>> getCartProduct();
  Future<List<Product>> searchProduct(String query);
  Future<List<CartProduct>> addProductToCart(Product product);
  Future<List<CartProduct>> deleteProductFromCart(CartProduct product);
  Future<List<CartProduct>> updateQtyProductFromCart(
      String type, CartProduct product);
  Future<ResponseProducts> getCachedProduct();
  Future<void> saveProductToDatabase(List<Product> products);
}

class CategoryProductsLocalDataSourceImpl
    implements CategoryProductsLocalDataSource {
  CategoryProductsLocalDataSourceImpl();

  @override
  Future<ResponseProducts> getCachedProduct() async {
    List<Product> productList = [];
    var box = await Hive.openBox('products');
    productList = List<Product>.from(box.values.toList());
    ResponseProducts responseProducts =
        ResponseProducts(products: Products(product: productList));
    return responseProducts;
  }

  @override
  Future<List<CartProduct>> getCartProduct() async {
    List<CartProduct> cartItems = [];
    var box = await Hive.openBox('cart');
    cartItems = List<CartProduct>.from(box.values.toList());
    return cartItems;
  }

  @override
  Future<List<CartProduct>> addProductToCart(Product product) async {
    List<CartProduct> cartItems = [];
    var box = Hive.box('cart');
    CartProduct cartProduct = CartProduct(
        prdNm: product.prdNm!,
        prdNo: product.prdNo!,
        selPrc: product.selPrc!,
        dispCtgrNm: product.dispCtgrNm!,
        qty: 1);
    box.add(cartProduct);
    cartItems = List<CartProduct>.from(box.values.toList());
    return cartItems;
  }

  @override
  Future<List<CartProduct>> deleteProductFromCart(CartProduct product) async {
    List<CartProduct> cartItems = [];
    var box = Hive.box('cart');
    cartItems = List<CartProduct>.from(box.values.toList());
    int index =
        cartItems.indexWhere((element) => product.prdNo == element.prdNo);
    box.deleteAt(index);
    cartItems = List<CartProduct>.from(box.values.toList());
    return cartItems;
  }

  @override
  Future<List<CartProduct>> updateQtyProductFromCart(
      String type, CartProduct product) async {
    List<CartProduct> cartItems = [];
    var box = Hive.box('cart');
    cartItems = List<CartProduct>.from(box.values.toList());
    int index =
        cartItems.indexWhere((element) => element.prdNo == product.prdNo);
    if (type == 'increment') {
      cartItems[index].qty++;
      box.putAt(index, cartItems[index]);
    } else {
      cartItems[index].qty--;
      box.putAt(index, cartItems[index]);
    }
    cartItems = List<CartProduct>.from(box.values.toList());
    return cartItems;
  }

  @override
  Future<void> saveProductToDatabase(List<Product> products) async {
    await Hive.openBox('products');
    var box = Hive.box('products');
    for (final data in products) {
      if (!box.containsKey(data.prdNo)) {
        await box.put(data.prdNo, data);
      }
    }
    // List<Product> totalData = List<Product>.from(box.values.toList());
    // print('total data in datbase ${totalData.length}');
  }

  @override
  Future<List<Product>> searchProduct(String query) async {
    List<Product> productList = [];
    await Hive.openBox('products');
    var box = Hive.box('products');
    var productDB = List<Product>.from(box.values.toList());
    productList = productDB.cast<Product>();
    List<Product> filteringData = [];
    filteringData = productList
        .where((element) => element.prdNm!.toLowerCase().contains(query))
        .toList();
    return filteringData;
  }
}
