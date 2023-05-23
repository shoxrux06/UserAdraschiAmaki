part of 'category_bloc.dart';

@immutable
class CategoryState {
  final Status status;
  final bool? isFetchingCategories;
  final bool? isFetchingSelectedCategories;
  final List<Category> list;
  final List<FilteredCategory> filteredProductCategoryList;
  final UserCategoryResponse? userCategoryResponse;

  CategoryState({
    this.status = Status.initial,
    this.list = const [],
    this.filteredProductCategoryList = const [],
    this.userCategoryResponse,
    this.isFetchingCategories = false,
    this.isFetchingSelectedCategories = false,
  });

  CategoryState copyWith({
    Status? status,
    bool? isFetchingCategories,
    bool? isFetchingSelectedCategories,
    UserCategoryResponse? userCategoryResponse,
    List<FilteredCategory>? filteredProductCategoryList,
    List<Category>? list,
  }) {
    return CategoryState(
        status: status ?? this.status,
        list: list ?? this.list,
        filteredProductCategoryList: filteredProductCategoryList?? this.filteredProductCategoryList,
        userCategoryResponse: userCategoryResponse ?? this.userCategoryResponse,
        isFetchingCategories: this.isFetchingCategories ?? isFetchingCategories,
        isFetchingSelectedCategories: this.isFetchingSelectedCategories ?? isFetchingSelectedCategories);
  }
}
