import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/data/source/remote/response/ProductResponse.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black.withOpacity(0.5), width: 1), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(11)),
              child: SizedBox(
                  width: double.infinity,
                  child: product.photos.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: product.photos[0],
                            placeholder: (context, url) => Image.asset("assets/images/placeholder_image.png", fit: BoxFit.cover),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        )
                      : Image.asset("assets/images/placeholder_image.png", fit: BoxFit.cover)),
            ),
          ),
          Spacer(flex: 1),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Expanded(child: Text(product.title.toUpperCase(), style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w500))),
              ],
            ),
          ),
          // Row(children: [Container(margin: const EdgeInsets.symmetric(horizontal: 5), width: 80, height: 1, color: Colors.black)]),
          SizedBox(height: 5),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: double.infinity,
              child: Text(
                "${product.price} ${l10n?.productPrice}",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              )),
          SizedBox(height: 5),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: double.infinity,
              child: Row(
                children: [
                  const Icon(Icons.remove_red_eye_sharp, size: 16,),
                  const SizedBox(width: 4,),
                  Text("${product.views}", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                ],
              )),
          SizedBox(height: 5),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: double.infinity,
              child: Text("${DateFormat('dd-MM-yyyy HH:mm').format(product.updatedAt)}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7F7F7F),
                    fontSize: 12
                  ))),
          Spacer(flex: 3),
        ],
      ),
    );
  }
}
