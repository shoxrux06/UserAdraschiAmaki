import 'package:afisha_market/core/bloc/add/create_state.dart';
import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:afisha_market/pages/filterCategoryPage/FilterCategoryPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/bloc/category/category_bloc.dart';
import '../components/shimmers/categories_shimmer.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final bloc = CategoryBloc(categoryRepository);

  List<bool> myList = [];

  @override
  void initState() {
    print('Category page');
    context.read<CategoryBloc>().add(CategoryInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if ((state.isFetchingCategories ?? false)) {
          return const CategoriesShimmer();
        }
        if (state.status == Status.fail) {
          return Container(color: Colors.white, child: const Center(child: Text('Error')));
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: state.categoryResponse?.categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => FilterCategoryPage(categoryId: state.categoryResponse?.categories[index].id,)));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(11),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2
                            )
                          ]
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Text(
                            state.categoryResponse?.categories[index].name ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                          )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
