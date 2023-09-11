import 'dart:io';
import 'package:afisha_market/core/data/repository/auth_repository.dart';
import 'package:afisha_market/core/data/repository/cart_repository.dart';
import 'package:afisha_market/core/data/repository/category_repository.dart';
import 'package:afisha_market/core/data/repository/filter_repository.dart';
import 'package:afisha_market/core/data/repository/home_repository.dart';
import 'package:afisha_market/core/data/repository/impl/auth_repository_impl.dart';
import 'package:afisha_market/core/data/repository/impl/cart_repository_impl.dart';
import 'package:afisha_market/core/data/repository/impl/category_repository_impl.dart';
import 'package:afisha_market/core/data/repository/impl/filter_repository_impl.dart';
import 'package:afisha_market/core/data/repository/impl/home_repository_impl.dart';
import 'package:afisha_market/core/data/repository/impl/like_repository_impl.dart';
import 'package:afisha_market/core/data/repository/impl/order_repo_impl.dart';
import 'package:afisha_market/core/data/repository/impl/payment_repository_impl.dart';
import 'package:afisha_market/core/data/repository/impl/product_repository_impl.dart';
import 'package:afisha_market/core/data/repository/impl/profile_repository_impl.dart';
import 'package:afisha_market/core/data/repository/like_repository.dart';
import 'package:afisha_market/core/data/repository/order_repository.dart';
import 'package:afisha_market/core/data/repository/payment_repository.dart';
import 'package:afisha_market/core/data/repository/product_repository.dart';
import 'package:afisha_market/core/data/repository/profile_repository.dart';
import 'package:afisha_market/core/handlers/http_service.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../data/models/locale_product.dart';

final GetIt getIt = GetIt.instance;

late Box<LocaleProduct> productBox;



setUpDependencies(){
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl());
  getIt.registerLazySingleton<FilterRepository>(() => FilterRepositoryImpl());
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  getIt.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImpl());
  getIt.registerLazySingleton<OrderRepo>(() => OrderRepoImpl());
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl());
  getIt.registerLazySingleton<LikeRepository>(() => LikeRepositoryImpl());
  // getIt.registerLazySingleton<LocalProductsSource>(() => LocalProductsSource(productBox));
}

final authRepository = getIt.get<AuthRepository>();
final orderRepo = getIt.get<OrderRepo>();
final categoryRepository = getIt.get<CategoryRepository>();
final filterRepository = getIt.get<FilterRepository>();
final homeRepository = getIt.get<HomeRepository>();
final paymentRepository = getIt.get<PaymentRepository>();
final productRepository = getIt.get<ProductRepository>();
final profileRepository = getIt.get<ProfileRepository>();
final likeRepository = getIt.get<LikeRepository>();
// final localProductSource = getIt.get<LocalProductsSource>();
