part of 'category_bloc.dart';

@immutable
class CategoryState {
  final Status status;
  final List<Category> list;

  CategoryState({this.status = Status.initial, this.list = const []});

  CategoryState copyWith({
    Status? status,
    List<Category>? list,
  }) {
    return CategoryState(status: status ?? this.status, list: list ?? this.list);
  }
}
