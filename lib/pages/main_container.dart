import 'dart:async';
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

  const MainContainer({Key? key, this.isFromProfile}) : super(key: key);

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  late String token = LocalStorage.instance.getToken();

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
    // TODO: implement initState
    pages = [
      const HomePage(),
      const CategoryPage(),
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
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF999999),
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
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF999999),
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
                  'assets/icons/person_i.svg',
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF999999),
                    BlendMode.srcIn,
                  ),
                ),
                label: l10n?.settings?? 'Account',
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
