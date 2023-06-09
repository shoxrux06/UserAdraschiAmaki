import 'package:afisha_market/pages/add/select_from_map_page.dart';
import 'package:afisha_market/pages/auth/newPassword/NewPasswordScreen.dart';
import 'package:afisha_market/pages/auth/noAccount/NoAccountScreen.dart';
import 'package:afisha_market/pages/auth/signUp/SignUpScreen.dart';
import 'package:afisha_market/pages/filterCategoryPage/FilterCategoryPage.dart';
import 'package:afisha_market/pages/filterRegionPage/FilterRegionPage.dart';
import 'package:afisha_market/pages/home/home_page.dart';
import 'package:afisha_market/pages/introduction/languageScreen.dart';
import 'package:afisha_market/pages/main_container.dart';
import 'package:afisha_market/pages/profile/profileScreen.dart';
import 'package:afisha_market/pages/settings/editProfileScreen.dart';
import 'package:afisha_market/pages/settings/settingsScreen.dart';
import 'package:afisha_market/pages/splash/splash_screen.dart';
import 'package:afisha_market/pages/userProfile/UserProfilePage.dart';
import 'package:flutter/material.dart';

import '../../pages/auth/forgotPassword/ForgotPasswordScreen.dart';
import '../../pages/auth/otp/OTPScreen.dart';
import '../../pages/auth/signIn/SignInScreen.dart';
import '../../pages/filterDetailPage/FilterProductDetailPage.dart';
import '../../pages/product_detail/ProductDetailPage.dart';
import 'app_routes.dart';

abstract class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signIn:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case AppRoutes.signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );
      case AppRoutes.noAccount:
        return MaterialPageRoute(
          builder: (_) => const NoAccountScreen(),
        );
      case AppRoutes.chooseLang:
        return MaterialPageRoute(
          builder: (_) => const ChooseLanguageScreen(),
        );
      case AppRoutes.user:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );
      case AppRoutes.otp:
        return MaterialPageRoute(
          builder: (_) => const OTPScreen(),
        );
      case AppRoutes.newPassword:
        return MaterialPageRoute(
          builder: (_) => const NewPasswordScreen(),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case AppRoutes.main:
        return MaterialPageRoute(
          builder: (_) => const MainContainer(),
        );
      case AppRoutes.selectFromMap:
        return MaterialPageRoute(
          builder: (_) =>  SelectFromMapPage(),
        );
      case AppRoutes.filterRegion:
        return MaterialPageRoute(
          builder: (_) => const FilterRegionPage(),
        );
      case AppRoutes.filterCategory:
        return MaterialPageRoute(
          builder: (_) => const FilterCategoryPage(),
        );
      case AppRoutes.userProfile:
        return MaterialPageRoute(
          builder: (_) => const UserProfilePage(),
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
