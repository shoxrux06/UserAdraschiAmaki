import 'package:afisha_market/core/data/repository/category_repository.dart';
import 'package:afisha_market/core/data/source/remote/response/CategoryResponse.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/source/remote/response/ProductCategoryResponse.dart';
import '../../data/source/remote/response/UserCategoryResponse.dart';
import '../../data/source/remote/response/filtered_product_category_response.dart';
import '../home/home_bloc.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc(this._categoryRepository) : super(const CategoryState()) {
    on<CategoryInitEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading, isFetchingCategories: true));
      try {
        final productResponse = await _categoryRepository.getProductCategoryList();

        productResponse.when(
          success: (data) {
            emit(state.copyWith(
              status: Status.success,
              categoryResponse: data,
              isFetchingCategories: false,
            ));
          },
          failure: (failure) {
            emit(state.copyWith(
              status: Status.fail,
              isFetchingCategories: false,
            ));
          },
        );

      } catch (e) {
        emit(state.copyWith(status: Status.fail, isFetchingCategories: false));
      }
    });
  }
}
