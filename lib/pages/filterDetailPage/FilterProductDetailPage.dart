import 'package:afisha_market/core/data/source/remote/response/ProductResponse.dart';
import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:afisha_market/core/utils/app_helpers.dart';
import 'package:afisha_market/core/utils/local_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/bloc/home/home_bloc.dart';
import '../../core/bloc/productDetail/product_detail_bloc.dart';
import '../../core/data/models/locale_product.dart';
import '../../db/db_helper.dart';
import '../cart/widgets/plus_minus_button.dart';
import '../main_container.dart';
import '../product_detail/image_carousel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/custom_button_two.dart';

class FilterProductDetailPage extends StatefulWidget {
  final Product? productDetail;

  const FilterProductDetailPage({Key? key, this.productDetail})
      : super(key: key);

  @override
  State<FilterProductDetailPage> createState() =>
      _FilterProductDetailPageState();
}

class _FilterProductDetailPageState extends State<FilterProductDetailPage> {
  final bloc = ProductDetailBloc(productRepository);

  final userId = LocalStorage.instance.getUserId();
  int discountPrice = 0;
  bool isAddedToCart = false;
  int counter = 1;

  @override
  void initState() {
    // TODO: implement initState
    double discountPrice2 = 0.0;
    if(widget.productDetail?.discount.isNotEmpty??false){
      discountPrice2 = int.parse(widget.productDetail?.price??'') * int.parse(widget.productDetail?.discount??'') / 100;
      discountPrice = int.parse(widget.productDetail?.price??'') - discountPrice2.toInt();
    }
    initID();
    Future(() {
      bloc.add(ProductDetailDataEvent(widget.productDetail?.id ?? 0));
    });
    super.initState();
  }

  initID() async{
    final localProducts = await DbManager().getDataList();
    for (var localProduct in localProducts) {
      if(widget.productDetail?.id == localProduct.productId){
        setState(() {
          isAddedToCart = true;
          counter = localProduct.quantity;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: BlocProvider.value(
        value: bloc,
        child: BlocConsumer<ProductDetailBloc, ProductDetailState>(
          listener: (context, state) {
            ///listener
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
                          color: Colors.white,
                          child: Column(
                            children: [
                              ImageCarousel(imageList: state.product[0].photos),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(color: Colors.black12, blurRadius: 4)
                                    ]
                                ),
                                padding: const EdgeInsets.all(10),
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
                                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
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
                                          SizedBox(
                                            height:state.product[0].eni.isEmpty?0: 10,
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
                                            height:state.product[0].boyi.isEmpty?0: 10,
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
                                            height: 10,
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
                                          SizedBox(
                                            height: discountPrice == 0? 0: 10,
                                          ),
                                          discountPrice == 0? Container(): Row(
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
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(color: Colors.black12, blurRadius: 4)
                                    ]
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                            l10n?.seller??'',
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
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.product[0].owner.username,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                                "${l10n?.accountCreated}${DateFormat("yyyy").format(state.product[0].createdAt)}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12,
                                                    color: Colors.grey)),
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
                              Text(l10n?.lastViewedProducts ?? '',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              PlusMinusButton(
                                addQuantity: () async{
                                  setState(() {
                                    counter++;
                                  });
                                },
                                deleteQuantity: () {
                                  setState(() {
                                    if(counter>1) {
                                      counter--;
                                    }
                                  });
                                },
                                text: counter.toString(),
                              ),
                              const Spacer(),
                              Text('${AppHelpers.moneyFormat('${int.parse(widget.productDetail?.price??'') * counter}')} ${l10n?.sum}')
                            ],
                          ),
                          CustomButtonTwo(
                            isAddedToCart ?'${l10n?.toCart}':'${l10n?.add}',
                            onTap: () {
                              DbManager().updateData(LocaleProduct(productId: widget.productDetail?.id??0, image: widget.productDetail?.photos[0]??'', quantity: counter, productName: widget.productDetail?.category??'', totalSum: 1, price: widget.productDetail?.price??''));
                              if(!isAddedToCart){
                                DbManager().insertData(LocaleProduct(productId: widget.productDetail?.id??0, image: widget.productDetail?.photos[0]??'', quantity: counter, productName: widget.productDetail?.category??'', totalSum: 1, price: widget.productDetail?.price??''));
                              }
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainContainer(isFromProductDetail: true)));
                            },
                          )
                        ],
                      ),
                    )
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
