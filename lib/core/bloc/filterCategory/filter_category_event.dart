part of 'filter_category_bloc.dart';

@immutable
abstract class FilterCategoryEvent {}

class FilterCategoryInitEvent extends FilterCategoryEvent{}

class FilterCategoryDataEvent extends FilterCategoryEvent{
  final int id;

  FilterCategoryDataEvent(this.id);

}