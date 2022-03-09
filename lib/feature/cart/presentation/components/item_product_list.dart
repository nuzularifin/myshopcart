import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshopcart/core/utils/theme.dart';
import 'package:myshopcart/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:myshopcart/feature/cart/presentation/cart_list_page.dart';
import 'package:myshopcart/feature/cart/presentation/detail_product_page.dart';

import '../../domain/entities/product.dart';

class ItemProductList extends StatelessWidget {
  final Product product;
  const ItemProductList({Key? key, required this.product}) : super(key: key);

  openCart() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
          color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //       offset: const Offset(0, 30),
          //       blurRadius: 60,
          //       color: const Color(0xFF393939).withOpacity(.1))
          // ],
          borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                      child: DetailProductPage(product, product.isSelected),
                      value: BlocProvider.of<CartBloc>(context))));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/product_image_placeholder.jpeg',
                height: MediaQuery.of(context).size.height * 0.14),
            const SizedBox(
              height: Margin.l,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '(${product.prdNo}) ${product.prdNm!}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text('${product.dispCtgrNm}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 10)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text('Rp. ${product.selPrc}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 10)),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            !product.isSelected
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
                                  selectedProduct: product));
                        }),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                      child: CartListPage(),
                                      value:
                                          BlocProvider.of<CartBloc>(context))));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[800],
                        ),
                        child: const Text(
                          'See cart',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
          ],
        ),
      ),
    );
  }
}
