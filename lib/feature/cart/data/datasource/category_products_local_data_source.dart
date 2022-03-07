import 'package:hive/hive.dart';
import 'package:myshopcart/feature/cart/domain/entities/response_products.dart';
import '../../domain/entities/product.dart';

abstract class CategoryProductsLocalDataSource {
  Future<List<Product>> getCartProduct();
  Future<List<Product>> addProductToCart(Product product);
  Future<List<Product>> deleteProductFromCart(Product product);
  Future<List<Product>> updateQtyProductFromCart(String type, Product product);
  Future<ResponseProducts> getCachedProduct();
}

class CategoryProductsLocalDataSourceImpl
    implements CategoryProductsLocalDataSource {
  CategoryProductsLocalDataSourceImpl();

  @override
  Future<ResponseProducts> getCachedProduct() async {
    late ResponseProducts categoryProduct;
    List<Product> productList = [];
    // open Box for DB
    var box = await Hive.openBox<List<Product>>('products');
    // set to Object ProductList;
    productList = box.values.toList() as List<Product>;
    if (productList.isNotEmpty) {
      Products products = Products(product: productList);
      categoryProduct = ResponseProducts(products: products);
    } else {
      Products products = Products(product: []);
      categoryProduct = ResponseProducts(products: products);
    }
    return categoryProduct;
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
}
