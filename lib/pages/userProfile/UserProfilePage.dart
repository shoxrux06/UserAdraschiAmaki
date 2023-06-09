import 'package:afisha_market/core/bloc/userProfile/user_profile_bloc.dart';
import 'package:afisha_market/pages/filterRegionPage/FilterProductItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/bloc/home/home_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../filterDetailPage/FilterProductDetailPage.dart';
import '../utils/const.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key, this.userId}) : super(key: key);

  final int? userId;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    Future(() {
      context.read<UserProfileBloc>().add(UserProfileDataEvent(widget.userId??0));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state.status == Status.initial || state.status == Status.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text('${state.list?.products[0].owner.fullname}'),),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Builder(builder: (context) {
                  var user = state.list?.products[0].owner;
                  return Container(
                    child: Card(
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: CircleAvatar(
                                    radius: 65,
                                    backgroundColor: mainColor,
                                    child: ClipOval(
                                      child: FadeInImage(
                                        placeholder: const AssetImage('assets/images/afisha_logo.png'),
                                        image: NetworkImage(user?.avatar??''),
                                        imageErrorBuilder: (context, error, stackTrace) {
                                          return Image.asset('assets/images/afisha_logo.png', fit: BoxFit.fitWidth);
                                        },
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(user?.fullname??'', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("${l10n?.accountStatus}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                                    Text("${state.list?.user.status}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("${l10n?.profileViews}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey)),
                                    Text(" ${user?.views}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("${l10n?.contacts}:", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                                    InkWell(
                                        onTap: ()async{
                                          final url = Uri.parse('tel:${user!.phone.toString()}');
                                          if (await canLaunchUrl(url)) {
                                          launchUrl(url);
                                          } else {
                                          throw 'Could not launch $url';
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${user?.phone}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.blueAccent)),
                                        )),
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
                      if (state.list!.products.isEmpty) {
                        return Container(padding: const EdgeInsets.only(top: 50), child: Center(child: Column(
                          children: [
                            Image.asset('assets/images/empty_product.jpg', width: 100,height: 100,),
                            Text("${l10n?.noDataFound}"),
                          ],
                        )));
                      }
                      return Container(
                        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.list!.products.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.6, crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => FilterProductDetailPage(productDetail: state.list!.products[index],)));
                                },
                                child: FilterProductItem(product: state.list!.products[index]));
                          },
                        ),
                      );
                    }
                )
              ],
            ),
          ),
        );
      },
    );

  }
}
