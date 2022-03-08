import 'package:hive/hive.dart';
import 'package:myshopcart/feature/cart/domain/entities/response_products.dart';
import '../../domain/entities/product.dart';

abstract class CategoryProductsLocalDataSource {
  Future<List<Product>> getCartProduct();
  Future<List<Product>> addProductToCart(Product product);
  Future<List<Product>> deleteProductFromCart(Product product);
  Future<List<Product>> updateQtyProductFromCart(String type, Product product);
  Future<ResponseProducts> getCachedProduct();
  Future<void> saveProductToDatabase(List<Product> products);
}

class CategoryProductsLocalDataSourceImpl
    implements CategoryProductsLocalDataSource {
  CategoryProductsLocalDataSourceImpl();

  @override
  Future<ResponseProducts> getCachedProduct() async {
    List<Product> productList = [];
    // open Box for DB
    var box = await Hive.openBox<Product>('products');
    // set to Object ProductList;
    productList = box.values.toList();
    ResponseProducts responseProducts =
        ResponseProducts(products: Products(product: productList));
    return responseProducts;
  }

  @override
  Future<List<Product>> getCartProduct() async {
    List<Product> cartItems = [];
    var box = await Hive.openBox<Product>('cart_box');
    cartItems = box.values.toList();
    return cartItems;
  }

  @override
  Future<List<Product>> addProductToCart(Product product) async {
    List<Product> cartItems = [];
    var box = Hive.box<Product>('cart_box');
    box.add(product);
    cartItems = box.values.toList();
    return cartItems;
  }

  @override
  Future<List<Product>> deleteProductFromCart(Product product) async {
    List<Product> cartItems = [];
    var box = Hive.box<Product>('cart_box');
    cartItems = box.values.toList();
    int index =
        cartItems.indexWhere((element) => product.prdNo == element.prdNo);
    box.deleteAt(index);
    cartItems = box.values.toList();
    return cartItems;
  }

  @override
  Future<List<Product>> updateQtyProductFromCart(
      String type, Product product) async {
    List<Product> cartItems = [];
    var box = Hive.box<Product>('cart_box');
    cartItems = box.values.toList();
    int index =
        cartItems.indexWhere((element) => element.prdNo == product.prdNo);
    if (type == 'increment') {
      product.qty++;
      box.putAt(index, product);
    } else {
      product.qty--;
      box.putAt(index, product);
    }
    cartItems = box.values.toList();
    return cartItems;
  }

  @override
  Future<void> saveProductToDatabase(List<Product> products) async {
    var box = await Hive.openBox<Product>('products');
    for (final data in products) {
      List<Product> tempData = box.values.toList();
      int index = tempData.indexWhere((element) => data.prdNo == element.prdNo);
      if (index != -1) {
        print('Delete the Data in $index has same value ${data.prdNo}');
        box.deleteAt(index);
      }
      box.add(data);
      print('save to db Product number ${data.prdNo}');
    }
  }
}
