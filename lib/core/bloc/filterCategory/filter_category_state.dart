part of 'filter_category_bloc.dart';

@immutable
class FilterCategoryState {
  final Status status;
  final List<ProductDetail> productList;

  FilterCategoryState({this.status = Status.initial, this.productList = const []});

  FilterCategoryState copyWith({Status? status, List<ProductDetail>? productList}) {
    return FilterCategoryState(status: status ?? this.status, productList: productList ?? this.productList);
  }
}

