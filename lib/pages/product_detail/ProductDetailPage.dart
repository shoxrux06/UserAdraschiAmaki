import 'package:afisha_market/core/bloc/home/home_bloc.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductResponse.dart';
import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:afisha_market/pages/product_detail/image_carousel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/bloc/productDetail/product_detail_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final bloc = ProductDetailBloc(productRepository);

  @override
  void initState() {
    Future(() {
      final args = ModalRoute.of(context)!.settings.arguments as Product;
      // print("${args.id}");
      bloc.add(ProductDetailDataEvent(args.id));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider.value(
        value: bloc,
        child: BlocConsumer<ProductDetailBloc, ProductDetailState>(
          listener: (context, state) {
            // print("state: ${state.status}");
          },
          builder: (context, state) {
            return BlocBuilder<ProductDetailBloc, ProductDetailState>(
              builder: (context, state) {
                // print("builder state: ${state.status}");
                if (state.status == Status.loading || state.status == Status.initial) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      child: ImageCarousel(imageList: state.product[0].data.photos),
                    ),
                    Text(
                      "${state.product[0].data.price} ${"productPrice".tr()}",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      state.product[0].data.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 2,
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              "${state.product[0].data.views} ${"people".tr()}",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "seenProduct".tr(),
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          state.product[0].data.body,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "options".tr(),
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
                                "color".tr(),
                                textAlign: TextAlign.end,
                                style: const TextStyle(color: Colors.grey),
                              )),
                              const SizedBox(width: 20),
                              Expanded(child: Text(state.product[0].data.color))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "compatibility".tr(),
                                textAlign: TextAlign.end,
                                style: const TextStyle(color: Colors.grey),
                              )),
                              const SizedBox(width: 20),
                              Expanded(child: Text(state.product[0].data.compatibility))
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("seller".tr(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey)),
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
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), border: Border.all(color: Colors.grey)),
                                      child: Builder(builder: (context) {
                                        // print("profile avatar: ${state.product[0].data.owner.avatar}");
                                        if (state.product[0].data.owner.avatar!.isNotEmpty) {
                                          return ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: FadeInImage.assetNetwork(
                                                  placeholder: "assets/images/profile_placeholder.jpg", image: state.product[0].data.owner.avatar!, fit: BoxFit.cover,));
                                        } else {
                                          return ClipRRect(
                                              borderRadius: BorderRadius.circular(50), child: Image.asset("assets/images/profile_placeholder.jpg"));
                                        }
                                      }),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.product[0].data.owner.fullname,
                                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text("${"accountCreated".tr()}${DateFormat("yyyy").format(state.product[0].data.owner.createdAt)}",
                                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.grey)),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child:
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, "/userProfile", arguments: state.product[0].data.owner.id);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orangeAccent,
                                          shadowColor: Colors.deepOrangeAccent,
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12)
                                          )
                                        ),
                                        child: Text(
                                          "allProducts".tr(),
                                          style: const TextStyle(color: Colors.white),
                                        )),
                                ),
                                const SizedBox(height: 20)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text("${"address".tr()}:", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(state.product[0].data.region, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ));
              },
            );
          },
        ),
      ),
    );
  }
}
