import 'package:afisha_market/core/data/repository/filter_repository.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductResponse.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/source/remote/response/GetProfileResponse.dart';
import '../home/home_bloc.dart';

part 'filter_category_event.dart';

part 'filter_category_state.dart';

class FilterCategoryBloc
    extends Bloc<FilterCategoryEvent, FilterCategoryState> {
  final FilterRepository _filterRepository;

  FilterCategoryBloc(this._filterRepository) : super(FilterCategoryState()) {
    on<FilterCategoryInitEvent>((event, emit) {});

    on<FilterCategoryDataEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      try {
        final response = await _filterRepository.getProductByCategory(event.id);
        response.when(
          success: (data) {
            emit(state.copyWith(status: Status.success, productList: data));
          },
          failure: (failure) {},
        );
      } catch (e) {}
    });
  }
}
