import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshopcart/core/utils/theme.dart';
import 'package:myshopcart/feature/cart/domain/entities/cart_product.dart';
import 'package:myshopcart/feature/cart/presentation/bloc/cart_bloc.dart';

class CartListPage extends StatefulWidget {
  CartListPage({Key? key}) : super(key: key);

  @override
  State<CartListPage> createState() => CartListPageState();
}

class CartListPageState extends State<CartListPage> {
  List<CartProduct> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadedState) {
          cartItems = state.cartData;
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: cartItems.isEmpty
                ? const SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(child: Text('Empty cart')),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartItems.isEmpty ? 0 : cartItems.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/product_image_placeholder.jpeg',
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width: MediaQuery.of(context).size.height *
                                        0.07,
                                  ),
                                  const SizedBox(
                                    width: Margin.l,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '(${cartItems[index].prdNo}) ${cartItems[index].prdNm}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        BlocProvider.of<CartBloc>(context).add(
                                            DeletingItemFromCartEvent(
                                                selectedProduct:
                                                    cartItems[index]));
                                      },
                                      icon: const Icon(Icons.delete_rounded))
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        if (cartItems[index].qty > 0) {
                                          // calculateTotalAmount(cartItems);
                                          BlocProvider.of<CartBloc>(context)
                                              .add(
                                                  UpdateQtyProductFromCartEvent(
                                                      type: 'decrement',
                                                      selectedProduct:
                                                          cartItems[index]));
                                        }
                                      },
                                      icon: const Icon(Icons.remove)),
                                  Text('${cartItems[index].qty}'),
                                  IconButton(
                                      onPressed: () {
                                        if (cartItems[index].qty >= 0) {
                                          //   calculateTotalAmount(cartItems);
                                          BlocProvider.of<CartBloc>(context)
                                              .add(
                                                  UpdateQtyProductFromCartEvent(
                                                      type: 'increment',
                                                      selectedProduct:
                                                          cartItems[index]));
                                        }
                                      },
                                      icon: const Icon(Icons.add)),
                                  Expanded(
                                    child: Text(
                                      'Rp. ${int.parse(cartItems[index].selPrc) * cartItems[index].qty}',
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      );
                    }),
          ),
        );
      },
    );
  }
}
