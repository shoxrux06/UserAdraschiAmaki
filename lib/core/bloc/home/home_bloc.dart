import 'package:afisha_market/core/data/repository/home_repository.dart';
import 'package:afisha_market/core/data/source/remote/response/AdvertisementResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/RegionResponse.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;

  HomeBloc(this._homeRepository) : super(HomeState()) {
    on<HomeInitEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      try {
        final productResponse = await _homeRepository.getProductList();
        final categoryResponse = await _homeRepository.getAds();
        final viewResponse = await _homeRepository.getViews();
        var regionList = await _homeRepository.getRegionList();

        productResponse.when(
            success: (data) {
              emit(
                state.copyWith(
                  status: Status.success,
                  productList: data.data.item,
                  currentPage: data.data.meta.currentPage,
                  lastPage: data.data.meta.lastPage,
                ),
              );
            },
            failure: (failure) {});

        categoryResponse.when(
            success: (data) {
              emit(
                state.copyWith(
                  status: Status.success,
                  adList: data,
                ),
              );
            },
            failure: (failure) {});

        viewResponse.when(
            success: (data) {
              emit(
                state.copyWith(
                  status: Status.success,
                  viewCount: data,
                ),
              );
            },
            failure: (failure) {});

        regionList.when(
            success: (data) {
              emit(state.copyWith(
                status: Status.success,
                regionList: data.data,
              ));
            },
            failure: (failure) {});
      } catch (e) {}
    });

    on<HomeNextEvent>((event, emit) async {
      if (state.currentPage < state.lastPage) {
        emit(state.copyWith(status: Status.loading));
        try {
          final productResponse =
              await _homeRepository.getProductList(page: state.currentPage + 1);
          productResponse.when(
              success: (data) {
                emit(
                  state.copyWith(
                    status: Status.success,
                    productList: [...state.productList, ...data.data.item],
                    currentPage: data.data.meta.currentPage,
                  ),
                );
              },
              failure: (failure) {});
        } catch (e) {}
      } else {
        emit(state.copyWith(status: Status.success));
      }
    });

    on<HomeSearchEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading, search: event.text));
      try {
        final productResponse =
            await _homeRepository.getProductList(search: event.text);
        productResponse.when(
            success: (data) {
              emit(
                state.copyWith(
                  status: Status.success,
                  productList: data.data.item,
                  adList: state.adList,
                  currentPage: data.data.meta.currentPage,
                  lastPage: data.data.meta.lastPage,
                ),
              );
            },
            failure: (failure) {});
      } catch (e) {}
    });
  }
}
