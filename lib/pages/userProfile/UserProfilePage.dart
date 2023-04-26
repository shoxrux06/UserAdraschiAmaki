import 'package:afisha_market/core/bloc/userProfile/user_profile_bloc.dart';
import 'package:afisha_market/pages/filterRegionPage/FilterProductItem.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/bloc/home/home_bloc.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    Future(() {
      var userId = ModalRoute.of(context)!.settings.arguments as int;
      context.read<UserProfileBloc>().add(UserProfileDataEvent(userId));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
          value: context.read<UserProfileBloc>(),
          child: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
              // print("state: ${state.status}");
              // print("state: ${state.status == Status.initial}");
              // print("state: ${state.status == Status.loading}");
              if (state.status == Status.initial || state.status == Status.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      var user = state.list[0].user;
                      return Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: Card(
                          color: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          height: 120,
                                          child: Builder(builder: (context) {
                                            if (user.avatar!.isNotEmpty) {
                                              return ClipRRect(
                                                  borderRadius: BorderRadius.circular(70),
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: "assets/images/profile_placeholder.jpg",
                                                    image: user.avatar!,
                                                    fit: BoxFit.cover,
                                                  ));
                                            } else {
                                              return ClipRRect(
                                                  borderRadius: BorderRadius.circular(70),
                                                  child: Image.asset("assets/images/profile_placeholder.jpg"));
                                            }
                                          }),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Text(user.fullname, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("enterpriseCategory:".tr(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                                        Text(" ${user.adminUserCategory}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("accountStatus".tr(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                                        Text(" ${user.status}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("address".tr(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                                        Text(": ${user.address}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("profileViews".tr(),
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey)),
                                        Text("${user.views}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text("contacts".tr(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                                        Text(": ${user.phone}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    Builder(
                        builder: (context) {
                          if (state.list[0].products.isEmpty) {
                            return Container(padding: const EdgeInsets.only(top: 50), child: const Center(child: Text("No data found")));
                          }
                          return Container(
                            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.list[0].products.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.6, crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, "/filterProductDetail", arguments: state.list[0].products[index]);
                                    },
                                    child: FilterProductItem(product: state.list[0].products[index]));
                              },
                            ),
                          );
                        }
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
