import 'dart:io';
import 'package:afisha_market/core/bloc/profile/profile/profileBloc.dart';
import 'package:afisha_market/core/bloc/profile/profile/profileEvent.dart';
import 'package:afisha_market/core/bloc/profile/profile/profileState.dart';
import 'package:afisha_market/pages/main_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/const.dart';
import '../../utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditList extends StatefulWidget {
  const EditList({Key? key}) : super(key: key);

  @override
  State<EditList> createState() => _EditListState();
}

class _EditListState extends State<EditList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? avatarFile;
  final _fullnameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullnameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    var fullname = _fullnameController.text;
    var password = _passwordController.text;
    if (fullname.isEmpty && password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Malumotlarni toldiring')));
    } else {
      context.read<ProfileBloc>().add(UpdateProfileEvent(context, fullname, password, avatarFile));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if(state is UpdateProfileState){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MainContainer()));
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: mainColor, width: 2),
                                      borderRadius: BorderRadius.circular(120),
                                    ),
                                    width: 120,
                                    height: 120,
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(120),
                                        child: avatarFile != null
                                            ? Image.file(
                                                avatarFile ?? File('path'),
                                                fit: BoxFit.cover,
                                                width: 120,
                                                height: 120,
                                              )
                                            : Image.asset(
                                                'assets/images/afisha_logo.png',
                                                fit: BoxFit.cover,
                                                width: 120,
                                                height: 120,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 12,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () async {
                                        final picker = ImagePicker();
                                        final pickedFile =
                                            await picker.pickImage(
                                                source: ImageSource.gallery);
                                        if (pickedFile != null) {
                                          setState(() {
                                            avatarFile = File(pickedFile.path);
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(32),
                                            color: mainColor),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          onTap: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(
                                source: ImageSource.gallery);

                            if (pickedFile != null) {
                              setState(() {
                                avatarFile = File(pickedFile.path);
                              });
                            }
                          }, //gallerydan rasm tanlashga otishi kere
                        ),
                        MyTextFormField2(
                          l10n?.fullName2 ?? '',
                          const Icon(CupertinoIcons.person),
                          _fullnameController,
                          validator: (val) {
                            if (val!.length < 3) {
                              return 'Name must be at least 3 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFormField2(
                          l10n?.password ?? '',
                          const Icon(CupertinoIcons.person),
                          _passwordController,
                          validator: (val) {
                            if (val!.length < 3) {
                              return 'UserName must be at least 3 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        Spacer(),
                        MyBigButton(
                          '${l10n?.save ?? ''}',
                          onTap: () {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                _submitForm();
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
