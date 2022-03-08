import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshopcart/feature/cart/domain/entities/product.dart';
import 'package:myshopcart/feature/cart/domain/entities/response_products.dart';
import 'package:myshopcart/feature/cart/presentation/bloc/cart_bloc.dart';
import 'cart_list_page.dart';
import 'components/item_product_list.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> productData = [];
  List<Product> cartData = [];
  late ScrollController _scrollController;
  bool isLastPage = false;
  int page = 1;

  @override
  void initState() {
    BlocProvider.of<CartBloc>(context).add(ItemLoadedEvent(
        page: page,
        cartData: Products(product: cartData),
        productData: Products(product: productData)));
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void openCartPages() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                child: CartListPage(),
                value: BlocProvider.of<CartBloc>(context))));
  }

  _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!isLastPage) {
        page++;
        BlocProvider.of<CartBloc>(context).add(ItemLoadedMorePage(
            page: page,
            cartData: Products(product: cartData),
            productData: Products(product: productData)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartLoadedState) {
          productData = state.productData;
          cartData = state.cartData;
        }
        if (state is NextPage) {
          isLastPage = false;
        } else if (state is LastPage) {
          isLastPage = true;
        }
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Produk'),
              actions: [
                Center(
                  child: Stack(
                    children: [
                      IconButton(
                          onPressed: () {
                            openCartPages();
                          },
                          icon: const Icon(Icons.shopping_cart_outlined)),
                      Badge(
                        badgeContent: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            '${cartData.length}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 8),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            productData.isNotEmpty ? productData.length : 0,
                        itemBuilder: (context, index) {
                          return ItemProductList(
                            product: productData[index],
                            context: context,
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
