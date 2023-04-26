part of 'home_bloc.dart';

@immutable
class HomeState {
  final Status status;
  final String message;
  final String search;
  final List<Product> productList;
  final List<Region> regionList;
  final List<AdvertisementItem> adList;
  final int currentPage;
  final int lastPage;
  final int viewCount;

  HomeState(
      {this.productList = const [],
      this.adList = const [],
      this.regionList = const [],
      this.search = "",
      this.status = Status.initial,
      this.message = "",
      this.currentPage = 0,
      this.lastPage = 0,
      this.viewCount = 0});

  HomeState copyWith(
      {Status? status,
      String? message,
      String? search,
      List<Product>? productList,
      List<Region>? regionList,
      List<AdvertisementItem>? adList,
      int? currentPage,
      int? lastPage,
      int? viewCount}) {
    return HomeState(
        status: status ?? this.status,
        message: message ?? this.message,
        search: search ?? this.search,
        productList: productList ?? this.productList,
        regionList: regionList ?? this.regionList,
        adList: adList ?? this.adList,
        currentPage: currentPage ?? this.currentPage,
        lastPage: lastPage ?? this.lastPage,
        viewCount: viewCount ?? this.viewCount);
  }
}

enum Status { initial, loading, success, fail }
