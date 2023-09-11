import 'package:afisha_market/core/bloc/like/like_bloc.dart';
import 'package:afisha_market/core/bloc/like/like_state.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductResponse.dart';
import 'package:afisha_market/core/utils/app_helpers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/bloc/like/like_event.dart';
import '../../core/bloc/productDetail/product_detail_bloc.dart';
import '../../core/data/models/locale_product.dart';
import '../../db/db_helper.dart';
import '../utils/const.dart';


class FilterProductItem extends StatefulWidget {
  final Product product;
  final bool? isFav;
  final VoidCallback toggle;

  const FilterProductItem({Key? key, required this.product, required this.isFav,required this.toggle}) : super(key: key);

  @override
  State<FilterProductItem> createState() => _FilterProductItemState();
}

class _FilterProductItemState extends State<FilterProductItem> {

  bool isAddedToCart = false;
  int discountPrice = 0;
  @override
  void initState() {
    // TODO: implement initState
    double discountPrice2 = 0.0;
    if(widget.product.discount.isNotEmpty){
      discountPrice2 = int.parse(widget.product.price) * int.parse(widget.product.discount) / 100;
      discountPrice = int.parse(widget.product.price) - discountPrice2.toInt();
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<LikeBloc,LikeState>(builder: (context, state){
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
                boxShadow:  [
                  BoxShadow(
                      color: Colors.black12.withOpacity(0.1),
                      blurRadius: 0.5
                  )
                ]
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.1 / 1,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(11)),
                        child: SizedBox(
                            width: double.infinity,
                            child: widget.product.photos.isNotEmpty
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: widget.product.photos[0],
                                placeholder: (context, url) => Image.asset("assets/images/placeholder_image.png", fit: BoxFit.cover),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            )
                                : Image.asset("assets/images/placeholder_image.png", fit: BoxFit.cover)),
                      ),
                    ),
                    discountPrice == 0? Container():Positioned(
                      left: 10,
                      child: Container(
                        width: 20,
                        // height: 40,
                        padding: EdgeInsets.symmetric(vertical: 4),
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            )
                        ),
                        child: Center(child: RotatedBox(
                          quarterTurns: -1,
                          child: Text(
                            '${widget.product.discount} %',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),),
                      ),
                    )
                  ],
                ),
                const Spacer(flex: 1),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Expanded(child: Text(widget.product.category.toUpperCase(), style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w500))),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: double.infinity,
                    child: Text(
                      "${AppHelpers.moneyFormat(widget.product.discount.isEmpty?widget.product.price.toString(): discountPrice.toString())} ${l10n?.productPrice}",
                      textAlign: TextAlign.start,
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    )
                ),
                widget.product.discount.isNotEmpty?  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: double.infinity,
                    child: Text(
                      "${AppHelpers.moneyFormat(widget.product.price.toString())} ${l10n?.productPrice}",
                      textAlign: TextAlign.start,
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.normal,decoration: TextDecoration.lineThrough),
                    )
                ): Container(),
                SizedBox(height: 5),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: double.infinity,
                    child: Text("${DateFormat('dd-MM-yyyy HH:mm').format(widget.product.updatedAt)}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7F7F7F),
                            fontSize: 12
                        )
                    )
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
          Positioned(
              top: 10,
              right: 10,
              child: InkWell(
                onTap:() async{
                  if(widget.isFav?? false){
                    context.read<LikeBloc>().add(UnLikedProductEvent(context: context, id: widget.product.id));
                  }else{
                    context.read<LikeBloc>().add(LikedProductEvent(context: context, id: widget.product.id));
                  }
                  widget.toggle();
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(24)
                  ),
                  child: Center(
                    child: Icon(
                      widget.isFav?? false
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
          ),
          Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap:() async {
                  final productList =await DbManager().getDataList();
                  for (var localProduct in productList) {
                    if(widget.product.id == localProduct.productId){
                      setState(() {
                        isAddedToCart = true;
                      });
                    }
                  }
                  if(isAddedToCart){
                    AppHelpers.showErrorSnackBar(context,'Product Already added');
                  }else{
                    context.read<ProductDetailBloc>().add(AddToCartEvent(LocaleProduct(productId:  widget.product.id, image: widget.product.photos[0], price: widget.product.price, productName: widget.product.category, quantity: 1, totalSum: 0)));
                    AppHelpers.showSuccessSnackBar(context,'Product Added to cart');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          color: greyColor
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: SvgPicture.asset('assets/icons/cart_add.svg', width: 24,height: 24,color: greyColor,)
                    ),
                  ),
                ),
              )
          )
        ],
      );
    });
  }
}
