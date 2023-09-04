import 'package:afisha_market/core/bloc/cart/cart_bloc.dart';
import 'package:afisha_market/core/bloc/cart/cart_event.dart';
import 'package:afisha_market/core/bloc/cart/cart_state.dart';
import 'package:afisha_market/core/bloc/home/home_bloc.dart';
import 'package:afisha_market/core/data/models/locale_product.dart';
import 'package:afisha_market/core/data/source/remote/request/cart_product.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductResponse.dart';
import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:afisha_market/core/utils/app_helpers.dart';
import 'package:afisha_market/core/utils/local_storage.dart';
import 'package:afisha_market/pages/cart/cart_page.dart';
import 'package:afisha_market/pages/cart/widgets/plus_minus_button.dart';
import 'package:afisha_market/pages/product_detail/image_carousel.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:afisha_market/pages/utils/custom_button_two.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../core/bloc/productDetail/product_detail_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetailPage extends StatefulWidget {
  final Product? product;

  const ProductDetailPage({Key? key, this.product}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final bloc = ProductDetailBloc(productRepository);
  final userId = LocalStorage.instance.getUserId();

  int discountPrice = 0;
  @override
  void initState() {
    // TODO: implement initState
    context.read<CartBloc>().add(CartInitEvent());
    double discountPrice2 = 0.0;
    if(widget.product?.discount.isNotEmpty??false){
      discountPrice2 = int.parse(widget.product?.price??'') * int.parse(widget.product?.discount??'') / 100;
      discountPrice = int.parse(widget.product?.price??'') - discountPrice2.toInt();
    }
    print('Discount ==> $discountPrice');
    print('Product Discount ==> ${widget.product?.discount??''}');
    Future(() {
      bloc.add(ProductDetailDataEvent(widget.product?.id ?? 0));
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: BlocProvider.value(
        value: bloc,
        child: BlocConsumer<ProductDetailBloc, ProductDetailState>(
          listener: (context, state) {
            ///do something
          },
          builder: (context, state) {
            return BlocBuilder<ProductDetailBloc, ProductDetailState>(
              builder: (context, state) {
                if (state.status == Status.loading ||
                    state.status == Status.initial) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                          child: Container(
                          color: Colors.white, child: Column(
                          children: [
                            ImageCarousel(imageList: state.product[0].photos, numberOfLikes: state.product[0].likes,),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.black12, blurRadius: 4)
                                  ]
                              ),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Text(
                                    "${AppHelpers.moneyFormat(discountPrice == 0? state.product[0].price.toString():discountPrice.toString())} ${l10n?.productPrice ?? ''}",
                                    style: const TextStyle(
                                        fontSize: 24, fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.product[0].category,
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.black12, blurRadius: 4)
                                  ]
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    l10n?.options ?? '',
                                    style: const TextStyle(
                                        fontSize: 24, fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 24),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  l10n?.color ?? '',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(color: Colors.grey),
                                                )),
                                            const SizedBox(width: 20),
                                            Expanded(child: Text(state.product[0].color))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  l10n?.productionType ?? '',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(color: Colors.grey),
                                                )),
                                            const SizedBox(width: 20),
                                            Expanded(
                                                child: Text(state.product[0].ishlabChiqarishTuri))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                          (state.product[0].eni.isEmpty)? Container():Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  l10n?.width ?? '',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(color: Colors.grey),
                                                )),
                                            const SizedBox(width: 20),
                                            Expanded(
                                                child: Text('${state.product[0].eni} ${l10n?.sm}'))
                                          ],
                                        ),
                                        SizedBox(
                                          height:state.product[0].eni.isEmpty?0: 10,
                                        ),
                                        (state.product[0].boyi.isEmpty)? Container():Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  l10n?.height ?? '',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(color: Colors.grey),
                                                )),
                                            const SizedBox(width: 20),
                                            Expanded(
                                                child: Text('${state.product[0].boyi} ${l10n?.metr}'))
                                          ],
                                        ),
                                        SizedBox(
                                          height: state.product[0].boyi.isEmpty ? 0:10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  l10n?.brand ?? '',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(color: Colors.grey),
                                                )),
                                            const SizedBox(width: 20),
                                            Expanded(
                                                child: Text(state.product[0].brand))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  l10n?.productFiber ?? '',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(color: Colors.grey),
                                                )
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                                child: Text(state.product[0].mahsulotTola))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  '${l10n?.discount}' ?? '',
                                                  textAlign: TextAlign.end,
                                                  style:
                                                  const TextStyle(color: Colors.grey),
                                                )),
                                            const SizedBox(width: 20),
                                            Expanded(
                                                child: discountPrice == 0? Text('0 %'): Text('${state.product[0].discount} %',
                                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.black12, blurRadius: 4)
                                  ]
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(l10n?.seller ?? '',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.grey)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.info_outline_rounded,
                                        size: 18,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.product[0].owner.username,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                              "${l10n?.accountCreated ?? ''}${DateFormat("yyyy").format(state.product[0].createdAt)}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                  color: Colors.grey
                                              )
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                                "${l10n?.lastViewedProducts}:",
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                      ),
                    ),
                    BlocBuilder<CartBloc, CartState>(builder: (context,state){
                      return Container(
                        padding: EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 4)
                            ]
                        ),
                        width: double.infinity,
                        child: Column(
                          children: [
                            // Row(
                            //   mainAxisSize: MainAxisSize.max,
                            //   children: [
                            //     BlocBuilder<CartBloc, CartState>(builder: (context,state){
                            //       LocaleProduct? localeProduct;
                            //       if(state.productList?.isNotEmpty?? false){
                            //         localeProduct = state.productList?.firstWhere((element) => element.productId == widget.product?.id);
                            //       }
                            //       return PlusMinusButton(
                            //         addQuantity: () {
                            //           context.read<CartBloc>().add(
                            //               CartProductIncreaseEvent(
                            //                   productId: widget.product!.id,
                            //                   isIcnDec: true,
                            //                   index:0
                            //               )
                            //           );
                            //         },
                            //         deleteQuantity: () {
                            //           context.read<CartBloc>().add(
                            //               CartProductIncreaseEvent(
                            //                   productId: widget.product!.id,
                            //                   isIcnDec: false,
                            //                   index: 0
                            //               )
                            //           );
                            //         },
                            //         text: (state.productList?.firstWhere((element) => element.productId == widget.product?.id).quantity??1).toString(),
                            //       );
                            //     }),
                            //     const Spacer(),
                            //     Text('20 som')
                            //   ],
                            // ),
                            CustomButtonTwo(
                                'Add',
                              onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => CartPage()));
                              },
                            )
                          ],
                        ),
                      );
                    }),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
