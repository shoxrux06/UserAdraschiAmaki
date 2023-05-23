part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class CategoryInitEvent extends CategoryEvent {}
class CategoryFilteredEvent extends CategoryEvent {}
