import 'package:afisha_market/core/data/models/cart_item.dart';
import 'package:afisha_market/core/data/source/remote/request/cart_product.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductResponse.dart';
import 'package:afisha_market/core/utils/local_storage.dart';
import 'package:afisha_market/pages/cart/widgets/plus_minus_button.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/cart/cart_bloc.dart';
import '../../../core/bloc/cart/cart_event.dart';
import '../../../core/data/models/locale_product.dart';

class CartItemWidget extends StatefulWidget {
  final LocaleProduct cartItem;
  final int index;

  const CartItemWidget({required this.cartItem, required this.index,super.key});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {

  int? counter;
  @override
  void initState() {
    counter = LocalStorage.instance.getCounterValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 100,
              height: 150,
              child: CachedNetworkImage(imageUrl: widget.cartItem.image??''),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.cartItem.productName??'', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          context.read<CartBloc>().add(CartProductDeleteEvent(widget.index));
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('${widget.cartItem.price} som'),
                      const SizedBox(width: 24,),
                      const Spacer(),
                      PlusMinusButton(
                        addQuantity: () {
                          context.read<CartBloc>().add(CartProductIncreaseEvent(productId: widget.cartItem.productId, isIcnDec: true, index: widget.index));
                      },
                        deleteQuantity: () {
                          context.read<CartBloc>().add(CartProductIncreaseEvent(productId: widget.cartItem.productId, isIcnDec: false,index: widget.index));
                        },
                        text: widget.cartItem.quantity.toString(),
                      ),
                    ],
                  ),
                  Text('${widget.cartItem.totalSum} som'),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Divider(
          height: 1,
          color: greyColor,
        )
      ],
    );
  }
}
