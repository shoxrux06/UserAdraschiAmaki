part of 'category_bloc.dart';

@immutable
class CategoryState {
  final Status status;
  final bool? isFetchingCategories;
  final bool? isFetchingSelectedCategories;
  final List<FilteredCategory> filteredProductCategoryList;
  final CategoryResponse? categoryResponse;

  const CategoryState(
      {this.status = Status.initial,
        this.filteredProductCategoryList = const [],
        this.isFetchingCategories = false,
        this.isFetchingSelectedCategories = false,
        this.categoryResponse});

  CategoryState copyWith({
    Status? status,
    bool? isFetchingCategories,
    bool? isFetchingSelectedCategories,
    List<FilteredCategory>? filteredProductCategoryList,
    CategoryResponse? categoryResponse,
  }) {
    return CategoryState(
        status: status ?? this.status,
        filteredProductCategoryList: filteredProductCategoryList ?? this.filteredProductCategoryList,
        isFetchingCategories: this.isFetchingCategories ?? isFetchingCategories,
        isFetchingSelectedCategories: this.isFetchingSelectedCategories ?? isFetchingSelectedCategories,
        categoryResponse: categoryResponse?? this.categoryResponse
    );
  }
}
