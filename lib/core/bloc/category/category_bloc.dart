import 'package:afisha_market/core/data/repository/category_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/source/remote/response/ProductCategoryResponse.dart';
import '../home/home_bloc.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc(this._categoryRepository) : super(CategoryState()) {
    on<CategoryInitEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      try {
        final productResponse = await _categoryRepository.getProductCategoryList();
        productResponse.when(
          success: (data) {
            emit(state.copyWith(status: Status.success, list: data.categories));
          },
          failure: (failure) {
            emit(state.copyWith(status: Status.fail,));
          },
        );
      } catch (e) {
        emit(state.copyWith(status: Status.fail,));
      }
    });
  }
}
