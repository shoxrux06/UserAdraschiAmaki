import 'package:afisha_market/core/bloc/profile/profile/profileBloc.dart';
import 'package:afisha_market/core/bloc/profile/profile/profileEvent.dart';
import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:afisha_market/pages/profile/components/flexibleContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/drawerList.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List _gridItems = List.generate(8, (i) => "Item $i");
  bool isMenu = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(profileRepository)..add(GetProfileEvent()),
      child: const Scaffold(
        endDrawer: Drawer(
          child: DrawerList(),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 2),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: false,
                expandedHeight: 408,
                elevation: 1,
                flexibleSpace: FlexibleSpaceBar(
                  background: FlexibleContainer(),
                ),
              ),
              SliverPadding(padding: EdgeInsets.symmetric(vertical: 4)),
              // SliverGrid(
              //     delegate: SliverChildBuilderDelegate((context, index) {
              //       return ProductItem(product: productItems[index]);
              //     }, childCount: _gridItems.length),
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       mainAxisSpacing: 10,
              //       crossAxisSpacing: 10,
              //       childAspectRatio: 9 / 17,
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}


