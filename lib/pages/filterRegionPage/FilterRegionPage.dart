import 'package:afisha_market/core/data/source/remote/response/RegionResponse.dart';
import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:afisha_market/pages/filterRegionPage/FilterProductItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/bloc/filterRegion/filter_region_bloc.dart';
import '../../core/bloc/home/home_bloc.dart';

class FilterRegionPage extends StatefulWidget {
  const FilterRegionPage({Key? key}) : super(key: key);

  @override
  State<FilterRegionPage> createState() => _FilterRegionPageState();
}

class _FilterRegionPageState extends State<FilterRegionPage> {
  final bloc = FilterRegionBloc(filterRepository);

  @override
  void initState() {
    Future(() {
      final args = ModalRoute.of(context)!.settings.arguments as Region;
      print("$args");
      bloc.add(FilterRegionDataEvent(args.id));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider.value(
          value: bloc,
        child: BlocBuilder<FilterRegionBloc, FilterRegionState>(
          builder: (context, state) {
            if (state.status == Status.loading || state.status == Status.initial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.productList.isNotEmpty) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
