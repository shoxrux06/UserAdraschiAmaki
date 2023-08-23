import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:afisha_market/pages/filterDetailPage/FilterProductDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/bloc/filterCategory/filter_category_bloc.dart';
import '../../core/bloc/home/home_bloc.dart';
import '../../core/data/source/remote/response/ProductCategoryResponse.dart';
import '../../core/utils/local_storage.dart';
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

  List<String> _favoriteProducts = [];

  void _loadFavoriteProducts() {
    final favorites = LocalStorage.instance.getFavProductIds();
    setState(() {
      _favoriteProducts = favorites;
    });
  }

  void _toggleFavorite(String productId) async {
    if (_favoriteProducts.contains(productId)) {
      await LocalStorage.instance.removeFavoriteProduct(productId);
    } else {
      await LocalStorage.instance.addFavoriteProduct(productId);
    }
    _loadFavoriteProducts();
  }

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
      appBar: AppBar(
        elevation: 10,
      ),
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
                color: Colors.white,
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.58),
                  itemCount: state.productList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, i) {
                    int productId = state.productList[i].id;
                    bool isFav = _favoriteProducts.contains(productId.toString());
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => FilterProductDetailPage(productDetail: state.productList[i],)));
                        },
                        child: GestureDetector(child: FilterProductItem(product: state.productList[i], isFav: isFav,toggle: () => _toggleFavorite(productId.toString()),)));
                  },
                ),
              );
            } else {
              return Container(
                color: Colors.white,
                padding:  EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
