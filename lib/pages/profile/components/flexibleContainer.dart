import 'package:afisha_market/core/bloc/profile/profile/profileBloc.dart';
import 'package:afisha_market/core/bloc/profile/profile/profileState.dart';
import 'package:afisha_market/core/utils/local_storage.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:afisha_market/pages/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class FlexibleContainer extends StatefulWidget {
  const FlexibleContainer({Key? key}) : super(key: key);

  @override
  State<FlexibleContainer> createState() => _FlexibleContainerState();
}

class _FlexibleContainerState extends State<FlexibleContainer> {
  bool isButton = true;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: ((context, state) {}),
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetProfileState) {
          return Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: mainColor,
                    child: ClipOval(
                      child: FadeInImage(
                        placeholder:
                            const AssetImage('assets/images/afisha_logo.png'),
                        image: NetworkImage(
                            '${state.profileResponse.user!.avatar}'),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/afisha_logo.png',
                              fit: BoxFit.fitWidth);
                        },
                        width: 156,
                        height: 156,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                MyText(
                  state.profileResponse.user!.fullname.toString(),
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      const MyText(
                        "Категория: ",
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      MyText(
                        state.profileResponse.user!.adminUserCategory
                            .toString(),
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      const MyText(
                        "Статус аккаунта: ",
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      MyText(
                        state.profileResponse.user!.status.toString(),
                        color: Colors.green,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      const MyText(
                        "Адрес: ",
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      MyText(
                        state.profileResponse.user!.address.toString(),
                        color: Colors.blue,
                        fontSize: 14,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                MyText(
                  "Просмотры профиля: ${state.profileResponse.user!.views.toString()} человек",
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                Container(
                    child: isButton
                        ? MyBigButton(
                            "Контакты",
                            onTap: () {
                              setState(() {
                                isButton = !isButton;
                              });
                            },
                          )
                        : MyWrappedText(
                            state.profileResponse.user!.phone.toString(),
                            onTap: () async {
                              final url = Uri.parse(
                                  'tel:${state.profileResponse.user!.phone.toString()}');
                              if (await canLaunchUrl(url)) {
                                launchUrl(url);
                              } else {
                                // ignore: avoid_print
                                throw 'Could not launch $url';
                              }
                            },
                            onTap2: () {
                              setState(() {
                                isButton = !isButton;
                              });
                            },
                          ))

                //       Column(
                //               children: [
                //                 GestureDetector(
                //                   child: MyText(
                //                     state.profileResponse.user!.phone.toString(),
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.w500,
                //                     fontSize: 20,
                //                   ),
                //                   onTap: () async {
                //                     final url = Uri.parse(
                //                         'tel:${state.profileResponse.user!.phone.toString()}');
                //                     if (await canLaunchUrl(url)) {
                //                       launchUrl(url);
                //                     } else {
                //                       // ignore: avoid_print
                //                       throw 'Could not launch $url';
                //                     }
                //                     // Clipboard.setData(ClipboardData(
                //                     //     text: state.profileResponse.user!.phone
                //                     //         .toString()));
                //                     // ScaffoldMessenger.of(context).showSnackBar(
                //                     //     const SnackBar(
                //                     //         content: MyText('Copied to ClipBoard')));
                //                   },
                //                   onDoubleTap: () {
                //                     setState(() {
                //                       isButton = !isButton;
                //                     });
                //                   },
                //                 ),
                //                 const SizedBox(
                //                   height: 24,
                //                 )
                //               ],
                //             ),
                //     )
              ],
            ),
          );
        }
        if (state is ProfileErrorState){
          LocalStorage.instance.setToken('');
          Navigator.pushNamed(
            context,
            '/noAccount',
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
