import 'package:afisha_market/pages/auth/forgotPassword/ForgotPasswordScreen.dart';
import 'package:afisha_market/pages/auth/signIn/SignInScreen.dart';
import 'package:afisha_market/pages/auth/signUp/SignUpScreen.dart';
import 'package:afisha_market/pages/filterCategoryPage/FilterCategoryPage.dart';
import 'package:afisha_market/pages/home/home_page.dart';
import 'package:afisha_market/pages/introduction/languageScreen.dart';
import 'package:afisha_market/pages/main_container.dart';
import 'package:afisha_market/pages/settings/editProfileScreen.dart';
import 'package:afisha_market/pages/settings/settingsScreen.dart';
import 'package:afisha_market/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import '../../pages/filterDetailPage/FilterProductDetailPage.dart';
import '../../pages/product_detail/ProductDetailPage.dart';
import 'app_routes.dart';

abstract class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case AppRoutes.signIn:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );
      case AppRoutes.signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );
      case AppRoutes.chooseLang:
        return MaterialPageRoute(
          builder: (_) => const ChooseLanguageScreen(),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case AppRoutes.main:
        return MaterialPageRoute(
          builder: (_) => const MainContainer(),
        );
      case AppRoutes.filterCategory:
        return MaterialPageRoute(
          builder: (_) => const FilterCategoryPage(),
        );
      case AppRoutes.settingsScreen:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
      case AppRoutes.updateProfile:
        return MaterialPageRoute(
          builder: (_) => const UpdateProfileScreen(),
        );
      case AppRoutes.productDetail:
        return MaterialPageRoute(
          builder: (_) => const ProductDetailPage(),
        );
      case AppRoutes.filterProductDetail:
        return MaterialPageRoute(
          builder: (_) => const FilterProductDetailPage(),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('Page not found'),
                  ),
                ));
    }
  }
}
