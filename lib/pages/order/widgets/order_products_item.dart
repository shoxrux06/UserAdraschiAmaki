import 'package:afisha_market/core/utils/app_helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/data/models/locale_product.dart';
import '../../utils/const.dart';

class OrdersProductItem extends StatelessWidget {
  final LocaleProduct cartItem;
  const OrdersProductItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    double height = media.height;
    double width = media.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          SizedBox(height: 8,),
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
                    imageUrl:cartItem.image ?? '',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.productName,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  SizedBox(height: 8,),
                  Text('Price: ${AppHelpers.moneyFormat(cartItem.price)} som'),
                  SizedBox(height: 8,),
                  Text('Quantity: ${cartItem.quantity}'),
                ],
              ),
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
      ),
    );
  }
}
