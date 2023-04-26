import 'package:afisha_market/core/bloc/auth/authBloc.dart';
import 'package:afisha_market/core/bloc/category/category_bloc.dart';
import 'package:afisha_market/core/bloc/language/language_bloc.dart';
import 'package:afisha_market/core/constants/app_pages.dart';
import 'package:afisha_market/core/constants/app_routes.dart';
import 'package:afisha_market/core/data/models/language_model.dart';
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
import 'core/bloc/userProfile/user_profile_bloc.dart';
import 'core/di/dependency_manager.dart';
import 'core/utils/local_storage.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => HomeBloc(homeRepository)),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepository)),

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
        BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(categoryRepository)),
        BlocProvider<LanguageBloc>(create:(_)=> LanguageBloc())
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state){
          // if(state is LanguageLoaded){
          //   return MaterialApp(
          //     debugShowCheckedModeBanner: false,
          //     localizationsDelegates: context.localizationDelegates,
          //     supportedLocales: Languages.languages.map((lang) => Locale(lang.code)).toList(),
          //     locale: state.locale,
          //     onGenerateRoute: AppPages.generateRoute,
          //     initialRoute: AppRoutes.main,
          //     theme: ThemeData(
          //       useMaterial3: true,
          //       appBarTheme: Theme.of(context).appBarTheme.copyWith(
          //         color: mainColor,
          //       ),
          //     ),
          //     home: ChangeNotifierProvider(
          //       create: (context) => HomeProvider(),
          //       child: const MainContainer(),
          //     ),
          //   );
          // }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: Languages.languages.map((lang) => Locale(lang.code)).toList(),
            locale: context.locale,
            onGenerateRoute: AppPages.generateRoute,
            initialRoute: AppRoutes.main,
            theme: ThemeData(
              useMaterial3: true,
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                color: mainColor,
              ),
            ),
            // home: ChangeNotifierProvider(
            //   create: (context) => HomeProvider(),
            //   child: const MainContainer(),
            // ),
          );
        },
      )

    );
  }
}
