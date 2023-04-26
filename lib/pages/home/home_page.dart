import 'package:afisha_market/core/bloc/home/home_bloc.dart';
import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:afisha_market/pages/home/widget/app_bar.dart';
import 'package:afisha_market/pages/home/widget/carousel_slider.dart';
import 'package:afisha_market/pages/home/widget/product_item.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = HomeBloc(homeRepository);
  final controller = RefreshController();

  @override
  void initState() {
    bloc.add(HomeInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            // print("listener eshityapdi");
            controller.loadComplete();
            controller.refreshCompleted();
          }
        },
        builder: (context, state) {
          // print("builder state 1: ${state.status}");
          if (state.adList.isEmpty && state.productList.isEmpty) {
            return Container(color: Colors.white, child: const Center(child: CircularProgressIndicator()));
          }
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Builder(builder: (context) {
                return Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: SearchBar(search: (searchText) {
                              EasyDebounce.debounce("my_search_debounce", const Duration(seconds: 2), () {
                                // print("search text: $searchText");
                                bloc.add(HomeSearchEvent(searchText));
                              });
                            })),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.white,
                                        ),
                                        margin: const EdgeInsets.all(24),
                                        padding: const EdgeInsets.only(top: 15, right: 10, left: 10, bottom: 15),
                                        height: 400,
                                        child: GridView.builder(
                                          // physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: state.regionList.length,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 3, crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(context, "/filterRegion", arguments: state.regionList[index]);
                                              },
                                              child: Container(
                                                  height: 70,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.deepOrangeAccent),
                                                  child: Column(
                                                    children: [
                                                      const Spacer(),
                                                      Text(
                                                        state.regionList[index].name,
                                                        textAlign: TextAlign.center,
                                                        style: const TextStyle(color: Colors.white),
                                                      ),
                                                      const Spacer(),
                                                    ],
                                                  )),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(15)),
                                  child: SvgPicture.asset("assets/icons/filter_inside.svg")),
                            )
                          ],
                        ),
                        Container(width: double.infinity, alignment: Alignment.center, child: Text("${"viewCounts".tr()}${state.viewCount}"))
                      ],
                    ),
                    Expanded(
                      child: SmartRefresher(
                        controller: controller,
                        enablePullDown: true,
                        enablePullUp: true,
                        onRefresh: () async {
                          bloc.add(HomeInitEvent());
                        },
                        onLoading: () async {
                          bloc.add(HomeNextEvent());
                        },
                        footer: const ClassicFooter(loadStyle: LoadStyle.ShowWhenLoading),
                        child: ListView.builder(
                          itemCount: 1,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        Builder(builder: (context) {
                                          // print("adlist: ${state.adList}");
                                          if (state.adList.isNotEmpty) {
                                            return CustomCarouselSlider(carouselItems: state.adList[index]);
                                          }else{
                                            return Container();
                                          }
                                        }),
                                      ],
                                    ),
                                  ],
                                ),
                                Builder(builder: (context) {
                                  if (state.productList.isNotEmpty) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      child: GridView.builder(
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 0.58),
                                        itemCount: state.productList.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(context, "/productDetail", arguments: state.productList[i]);
                                              },
                                              child: ProductItem(product: state.productList[i]));
                                        },
                                      ),
                                    );
                                  } else {
                                    return Container(padding: const EdgeInsets.only(top: 50), child: const Center(child: Text("No data found")));
                                  }
                                })
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
