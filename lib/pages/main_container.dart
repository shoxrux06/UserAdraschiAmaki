import 'dart:async';
import 'package:afisha_market/pages/auth/noAccount/NoAccountScreen.dart';
import 'package:afisha_market/pages/cart/cart_page.dart';
import 'package:afisha_market/pages/profile/profileScreen.dart';
import 'package:afisha_market/pages/profile/profile_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:afisha_market/core/utils/local_storage.dart';
import 'package:afisha_market/pages/category/category_page.dart';
import 'package:afisha_market/pages/home/home_page.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MainContainer extends StatefulWidget {
  final bool? isFromProfile;
  final bool? isFromProductDetail;
  final bool? isFromCartPage;


  const MainContainer({Key? key, this.isFromProfile, this.isFromProductDetail, this.isFromCartPage}) : super(key: key);

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {

  late int _selectedIndex = widget.isFromProfile ?? false ? 3 : 0;

  bool canback = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    if (canback == true) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      setState(() {
        _selectedIndex = 0;
      });
    }

    Timer(Duration(seconds: 2), () {
      setState(() {
        canback = false;
      });
    });
    canback = true;
    return false;
  }

  late List<Widget> pages;

  @override
  void initState() {
    if(widget.isFromProductDetail?? false){
      _selectedIndex = 2;
    }
    if(widget.isFromCartPage?? false){
      _selectedIndex = 2;
    }
    pages = [
      const HomePage(),
      const CategoryPage(),
      const CartPage(),
      const ProfilePage()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
            elevation: 10,
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
            selectedItemColor: blueColor,
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/home_i.svg',
                  colorFilter:  ColorFilter.mode(
                    greyColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: l10n?.home??'Home',
                backgroundColor: mainColor,
                activeIcon:SvgPicture.asset(
                  'assets/icons/home.svg',
                  colorFilter: ColorFilter.mode(
                    blueColor,
                    BlendMode.srcIn,
                  ),
                )
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/category_i.svg',
                  colorFilter: ColorFilter.mode(
                    greyColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: l10n?.category ??'Category',
                backgroundColor: mainColor,
                activeIcon: SvgPicture.asset(
                  'assets/icons/category.svg',
                  colorFilter: ColorFilter.mode(
                    blueColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/cart_out.svg',
                    colorFilter: ColorFilter.mode(
                      greyColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: l10n?.cart??'Cart',
                  backgroundColor: mainColor,
                  activeIcon:SvgPicture.asset(
                    'assets/icons/cart_fill.svg',
                    colorFilter: ColorFilter.mode(
                      blueColor,
                      BlendMode.srcIn,
                    ),
                  )
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/person_i.svg',
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF999999),
                    BlendMode.srcIn,
                  ),
                ),
                label: l10n?.account?? 'Account',
                backgroundColor: mainColor,
                activeIcon: SvgPicture.asset(
                  'assets/icons/person.svg',
                  colorFilter: ColorFilter.mode(
                    blueColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          body: pages[_selectedIndex]),
    );
  }
}
