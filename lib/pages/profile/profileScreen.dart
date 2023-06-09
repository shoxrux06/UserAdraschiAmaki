import 'package:afisha_market/core/bloc/profile/profile/profileBloc.dart';
import 'package:afisha_market/core/bloc/profile/profile/profileEvent.dart';
import 'package:afisha_market/core/bloc/profile/profile/profileState.dart';
import 'package:afisha_market/core/utils/local_storage.dart';
import 'package:afisha_market/pages/profile/components/flexibleContainer.dart';
import 'package:afisha_market/pages/profile/components/profile_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/shimmers/sliver_product_grid_list_shimmer.dart';
import '../filterDetailPage/FilterProductDetailPage.dart';
import 'components/drawerList.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int userId = LocalStorage.instance.getUserId();

  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            endDrawer: const Drawer(
              child: DrawerList(),
            ),
            body: Container(
              color: Colors.lightBlueAccent.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 2),
                child: CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      leading: null,
                      backgroundColor: Colors.white,
                      pinned: false,
                      expandedHeight: 350,
                      elevation: 1,
                      flexibleSpace: FlexibleSpaceBar(
                        background: FlexibleContainer(),
                      ),
                    ),
                    const SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                    ),
                    (state is ProfileLoadingState)? const SliverProductGridListShimmer(): const SliverPadding(padding: EdgeInsets.only(right: 12)),
                    (state is GetProfileState)?Builder(builder: (context) {
                      return SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 0.55,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => FilterProductDetailPage(productDetail: state.profileResponse.products[index],)
                                  ),);
                                },
                                child: ProfileProductItem(
                                  product: state.profileResponse.products[index],
                                )
                            );
                          },
                          childCount: state.profileResponse != null
                              ? state.profileResponse.products.length
                              : 0,
                        ),
                      );
                    }): const SliverPadding(padding: EdgeInsets.all(12)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
