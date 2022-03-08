import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshopcart/feature/cart/domain/entities/product.dart';
import 'package:myshopcart/feature/cart/presentation/bloc/cart_bloc.dart';

class DetailProductPage extends StatefulWidget {
  Product product;
  bool isAddToCart;
  DetailProductPage(this.product, this.isAddToCart, {Key? key})
      : super(key: key);

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  @override
  void initState() {
    BlocProvider.of<CartBloc>(context)
        .add(DetailProductLoadedEvent(prdNo: widget.product.prdNo!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartLoadedState) {}
        if (state is DetailLoadedState) {
          widget.product;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Produk'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          if (state is DetailLoadingState) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Center(child: CircularProgressIndicator()),
            );
          } else {
            return SizedBox(
              width: double.infinity,
              child: Column(children: [
                Image.asset(
                  'assets/images/product_image_placeholder.jpeg',
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product.prdNm!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 8,
                      ),
                      Text('Rp. ${widget.product.selPrc.toString()}',
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
                widget.product.isSelected
                    ? Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (widget.product.qty > 0) {
                                  BlocProvider.of<CartBloc>(context).add(
                                      UpdateQtyProductFromCartEvent(
                                          selectedProduct: widget.product,
                                          type: 'decrement'));
                                }
                              },
                              icon: const Icon(Icons.remove)),
                          Text(widget.product.qty.toString()),
                          IconButton(
                              onPressed: () {
                                if (widget.product.qty >= 0) {
                                  BlocProvider.of<CartBloc>(context).add(
                                      UpdateQtyProductFromCartEvent(
                                          selectedProduct: widget.product,
                                          type: 'increment'));
                                }
                              },
                              icon: const Icon(Icons.add)),
                          const Spacer(),
                          Text(
                              'Rp. ${int.parse(widget.product.selPrc!) * widget.product.qty}'),
                        ],
                      )
                    : Container(),
                !widget.product.isSelected
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        child: ElevatedButton.icon(
                            label: const Text(
                              'Add to cart',
                              style: TextStyle(color: Colors.white),
                            ),
                            icon: const Icon(
                              Icons.shopping_bag_rounded,
                              size: 20,
                            ),
                            onPressed: () {
                              BlocProvider.of<CartBloc>(context).add(
                                  AddingItemIntoCartEvent(
                                      selectedProduct: widget.product));
                            }),
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              // openCart();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue[800],
                            ),
                            child: const Text(
                              'See cart',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
              ]),
            );
          }
        }),
      ),
    );
  }
}
