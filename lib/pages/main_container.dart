import 'dart:async';

import 'package:afisha_market/core/bloc/auth/authBloc.dart';
import 'package:afisha_market/core/bloc/auth/authState.dart';
import 'package:afisha_market/core/bloc/category/category_bloc.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductCategoryResponse.dart';
import 'package:afisha_market/core/utils/local_storage.dart';
import 'package:afisha_market/pages/add/add_screen.dart';
import 'package:afisha_market/pages/auth/noAccount/NoAccountScreen.dart';
import 'package:afisha_market/pages/category/category_page.dart';
import 'package:afisha_market/pages/home/home_page.dart';
import 'package:afisha_market/pages/profile/profileScreen.dart';
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
  final token = LocalStorage.instance.getToken();

  late int _selectedIndex = widget.isFromProfile?? false? 3: 0;

  bool canback =false;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    if (canback == true) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }else{
      setState(() {
        _selectedIndex=0;
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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          color: Colors.lightBlueAccent.withOpacity(0.2),
          child: CircleNavBar(
            activeIcons: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset('assets/icons/home.svg', colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset('assets/icons/category.svg',
                    colorFilter: const ColorFilter.mode(
                        Colors.white, BlendMode.srcIn)),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset('assets/icons/add.svg',
                    colorFilter: const ColorFilter.mode(
                        Colors.white, BlendMode.srcIn)),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset('assets/icons/person.svg',
                    colorFilter: const ColorFilter.mode(
                        Colors.white, BlendMode.srcIn)),
              ),
            ],
            inactiveIcons: [
              SvgPicture.asset('assets/icons/home_i.svg',
                  colorFilter: const ColorFilter.mode(
                      Colors.white, BlendMode.srcIn)),
              SvgPicture.asset('assets/icons/category_i.svg',
                  colorFilter: const ColorFilter.mode(
                      Colors.white, BlendMode.srcIn)),
              SvgPicture.asset('assets/icons/add_i.svg',
                  colorFilter: const ColorFilter.mode(
                      Colors.white, BlendMode.srcIn)),
              SvgPicture.asset('assets/icons/person_i.svg',
                  colorFilter: const ColorFilter.mode(
                      Colors.white, BlendMode.srcIn)),
            ],
            color: mainColor,
            height: 48,
            circleWidth: 48,
            activeIndex: _selectedIndex,
            onTap: _onItemTapped,
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
            cornerRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            shadowColor: mainColor,
            elevation: 4,
          ),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            const HomePage(),
            const CategoryPage(),
            const AddScreen(),
            (token.isNotEmpty)
                ? ProfileScreen()
                : const NoAccountScreen()
          ],
        ),
      ),
    );
  }
}

// class HomeProvider extends ChangeNotifier {
//   var _index = 0;
//
//   void onChangedTab(int index) {
//     _index = index;
//     notifyListeners();
//   }
//
//   int get index => _index;
// }
