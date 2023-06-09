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

  bool isFirst = true;
  int selectedItemIndex = -1;

  List<bool> myList = [];

  @override
  void initState() {
    context.read<CategoryBloc>().add(CategoryFilteredEvent());
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
              color: Colors.lightBlueAccent.withOpacity(0.2),
              child: ListView.builder(
                itemCount: state.categoryResponse?.categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedItemIndex = index;
                        isFirst = !isFirst;
                      });
                    },
                    child: AnimatedCrossFade(
                      firstChild: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Expanded(child: Text(
                              state.categoryResponse?.categories[index].name ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                            )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedItemIndex = index;
                                    isFirst = !isFirst;
                                  });
                                },
                                icon: const Icon(Icons.arrow_drop_down))
                          ],
                        ),
                      ),
                      secondChild: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(
                                  state.categoryResponse?.categories[index].name ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                )),
                                IconButton(onPressed: () {
                                  setState(() {
                                    selectedItemIndex = index;
                                    isFirst = !isFirst;
                                  });
                                },
                                    icon: const Icon(Icons.arrow_drop_up))
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            ...?state.categoryResponse?.categories[index]
                                .subCategories
                                .map((subCategory) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => FilterCategoryPage(categoryId: subCategory.id)));
                              },
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.only(top: 8),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.black26, width: 1)),
                                  child: Text(subCategory.name)
                              ),
                            ))
                          ],
                        ),
                      ),
                      crossFadeState: (isFirst || selectedItemIndex != index)
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 300),
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
