import 'dart:async';
import 'dart:io';

import 'package:afisha_market/core/bloc/auth/authBloc.dart';
import 'package:afisha_market/core/bloc/cart/cart_bloc.dart';
import 'package:afisha_market/core/bloc/category/category_bloc.dart';
import 'package:afisha_market/core/bloc/gallery/gallery_bloc.dart';
import 'package:afisha_market/core/bloc/language/language_bloc.dart';
import 'package:afisha_market/core/bloc/language/language_event.dart';
import 'package:afisha_market/core/bloc/like/like_bloc.dart';
import 'package:afisha_market/core/bloc/payment/payment_bloc.dart';
import 'package:afisha_market/core/constants/app_pages.dart';
import 'package:afisha_market/core/constants/app_routes.dart';
import 'package:afisha_market/core/data/models/language_model.dart';
import 'package:afisha_market/core/data/repository/like_repository.dart';
import 'package:afisha_market/generated/codegen_loader.g.dart';
import 'package:afisha_market/pages/main_container.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'core/bloc/filterRegion/filter_region_bloc.dart';
import 'core/bloc/home/home_bloc.dart';
import 'core/bloc/productDetail/product_detail_bloc.dart';
import 'core/bloc/profile/profile/profileBloc.dart';
import 'core/bloc/userProfile/user_profile_bloc.dart';
import 'core/constants/app_constants.dart';
import 'core/di/dependency_manager.dart';
import 'core/utils/local_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


Timer? _rootTimer;

changeBaseUrl(){
  AppConstants.baseUrl = 'https://some.url';
  _rootTimer?.cancel();
}

void initializeTimer() {
  if (_rootTimer != null) _rootTimer?.cancel();
  const time = Duration(minutes:  5 );
  _rootTimer = Timer(time, () {
    changeBaseUrl();
  });
}
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: mainColor, // navigation bar color
      statusBarColor: mainColor, // status bar color
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  setUpDependencies();
  await LocalStorage.getInstance();

  // initializeTimer();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale("uz"),
        Locale("ru"),
        Locale("en"),
      ],
      path: 'assets/tr',
      fallbackLocale: const Locale("en"),
      assetLoader: const CodegenLoader(),
      startLocale: const Locale("en"),
      child: const MyApp(),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: mainColor,
    systemNavigationBarColor: mainColor,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    String appLang = LocalStorage.instance.getLanguage();

    print('UserID --> ${LocalStorage.instance.getUserId()??0}');
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => HomeBloc(homeRepository, filterRepository)),
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
        BlocProvider<PaymentBloc>(create: (context) => PaymentBloc(paymentRepository)),
        BlocProvider<GalleryBloc>(create: (context) => GalleryBloc()),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepository)),
        BlocProvider<ProfileBloc>(create: (context) => ProfileBloc(profileRepository)),
        BlocProvider<FilterRegionBloc>(
            create: (context) => FilterRegionBloc(filterRepository)),
        BlocProvider<FilterRegionBloc>(
            create: (context) => FilterRegionBloc(filterRepository)),
        BlocProvider<UserProfileBloc>(
            create: (context) => UserProfileBloc(profileRepository)),
        BlocProvider<UserProfileBloc>(
            create: (context) => UserProfileBloc(profileRepository)),
        BlocProvider<ProductDetailBloc>(
            create: (context) => ProductDetailBloc(productRepository)),
        BlocProvider<CategoryBloc>(create: (context) => CategoryBloc(categoryRepository)),
        BlocProvider<LikeBloc>(create: (context) => LikeBloc(likeRepository: likeRepository)),
        BlocProvider<LanguageBloc>(create:(_)=> LanguageBloc()..add(GetLanguage()))
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates:const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: Languages.languages.map((lang) => Locale(lang.code)).toList(),
            locale: state.locale,
            onGenerateRoute: AppPages.generateRoute,
            initialRoute: appLang.isNotEmpty? AppRoutes.main: AppRoutes.splash,
            theme: ThemeData(
              useMaterial3: true,
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                color: mainColor,
              ),
            ),
          );
        },
      )
    );
  }
}
