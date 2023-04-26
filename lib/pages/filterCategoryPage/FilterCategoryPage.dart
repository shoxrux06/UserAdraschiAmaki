import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/bloc/filterCategory/filter_category_bloc.dart';
import '../../core/bloc/home/home_bloc.dart';
import '../../core/data/source/remote/response/ProductCategoryResponse.dart';
import '../filterRegionPage/FilterProductItem.dart';

class FilterCategoryPage extends StatefulWidget {
  const FilterCategoryPage({Key? key}) : super(key: key);

  @override
  State<FilterCategoryPage> createState() => _FilterCategoryPageState();
}

class _FilterCategoryPageState extends State<FilterCategoryPage> {
  final bloc = FilterCategoryBloc(filterRepository);

  @override
  void initState() {
    Future(() {
      final args = ModalRoute.of(context)!.settings.arguments as Category;
      print("$args");
      bloc.add(FilterCategoryDataEvent(args.id));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<FilterCategoryBloc, FilterCategoryState>(
          builder: (context, state) {
            if (state.status == Status.loading || state.status == Status.initial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.productList.isNotEmpty) {
              return Container(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 0.58),
                  itemCount: state.productList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/filterProductDetail", arguments: state.productList[i]);
                        },
                        child: GestureDetector(child: FilterProductItem(product: state.productList[i])));
                  },
                ),
              );
            }else {
              return const Center(
                child: Text("No Data Found"),
              );
            }
          },
        ),
      ),
    );
  }
}
