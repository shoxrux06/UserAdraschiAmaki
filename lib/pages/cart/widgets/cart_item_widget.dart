import 'package:afisha_market/core/bloc/cart/cart_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:afisha_market/core/utils/app_helpers.dart';
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

  const CartItemWidget(
      {required this.cartItem, required this.index, super.key});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  void initState() {
    print('widget.cartItem ${widget.cartItem}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final media = MediaQuery.of(context).size;
    double height = media.height;
    double width = media.width;
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            SizedBox(
              width: height/6,
              height: width/3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  width: height/6,
                  height: width/3,
                  imageUrl: widget.cartItem.image ?? '',
                  fit: BoxFit.fill,
                ),
              ),
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
                      Expanded(
                          flex: 3,
                          child: Text(
                            widget.cartItem.productName ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                      const Spacer(),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () async {
                            context
                                .read<CartBloc>()
                                .add(CartProductDeleteEvent(widget.cartItem));
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('${AppHelpers.moneyFormat(widget.cartItem.price)} ${l10n?.sum}'),
                      const SizedBox(
                        width: 12,
                      ),
                      // const Spacer(),
                      Expanded(
                        child: BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) {
                          return PlusMinusButton(
                            addQuantity: () {
                              context.read<CartBloc>().add(
                                  CartProductIncreaseDecreaseEvent(
                                      productId: widget.cartItem.productId,
                                      isIcnDec: true,
                                      index: widget.index));
                            },
                            deleteQuantity: () {
                              context.read<CartBloc>().add(
                                  CartProductIncreaseDecreaseEvent(
                                      productId: widget.cartItem.productId,
                                      isIcnDec: false,
                                      index: widget.index));
                            },
                            text: widget.cartItem.quantity.toString(),
                          );
                        }),
                      ),
                    ],
                  ),
                  // Text('${widget.cartItem.totalSum} som'),
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
