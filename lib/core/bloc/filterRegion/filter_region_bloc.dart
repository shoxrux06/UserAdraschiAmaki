import 'package:afisha_market/core/data/repository/filter_repository.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductResponse.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/source/remote/response/GetProfileResponse.dart';
import '../home/home_bloc.dart';

part 'filter_region_event.dart';

part 'filter_region_state.dart';

class FilterRegionBloc extends Bloc<FilterRegionEvent, FilterRegionState> {
  final FilterRepository _filterRepository;

  FilterRegionBloc(this._filterRepository) : super(FilterRegionState()) {
    on<FilterRegionInitEvent>((event, emit) {});

    // on<FilterRegionDataEvent>((event, emit) async {
    //   emit(state.copyWith(status: Status.loading));
    //   try {
    //     final response = await _filterRepository.getProductByRegion(event.id);
    //     response.when(
    //         success: (data) {
    //           emit(state.copyWith(status: Status.success, productList: data));
    //         },
    //         failure: (failure) {});
    //   } catch (e) {
    //
    //   }
    // });
  }
}
