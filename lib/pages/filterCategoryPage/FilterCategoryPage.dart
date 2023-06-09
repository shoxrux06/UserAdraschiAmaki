import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:afisha_market/pages/filterDetailPage/FilterProductDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/bloc/filterCategory/filter_category_bloc.dart';
import '../../core/bloc/home/home_bloc.dart';
import '../../core/data/source/remote/response/ProductCategoryResponse.dart';
import '../filterRegionPage/FilterProductItem.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilterCategoryPage extends StatefulWidget {
  const FilterCategoryPage({Key? key, this.categoryId}) : super(key: key);

  final int? categoryId;

  @override
  State<FilterCategoryPage> createState() => _FilterCategoryPageState();
}

class _FilterCategoryPageState extends State<FilterCategoryPage> {
  final bloc = FilterCategoryBloc(filterRepository);

  @override
  void initState() {
    Future(() {
      bloc.add(FilterCategoryDataEvent(widget.categoryId ?? 0));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<FilterCategoryBloc, FilterCategoryState>(
          builder: (context, state) {
            if (state.status == Status.loading ||
                state.status == Status.initial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.productList.isNotEmpty) {
              return Container(
                color: Colors.lightBlueAccent.withOpacity(0.2),
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.58),
                  itemCount: state.productList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => FilterProductDetailPage(productDetail: state.productList[i],)));
                        },
                        child: GestureDetector(child: FilterProductItem(product: state.productList[i])));
                  },
                ),
              );
            } else {
              return Container(
                color: Colors.lightBlueAccent.withOpacity(0.2),
                padding:  EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/empty_product.jpg',
                        width: MediaQuery.of(context).size.width - 96,
                        height: MediaQuery.of(context).size.height / 2,
                      ),
                      Text("${l10n?.noDataFound}"),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
