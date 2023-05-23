import 'dart:io';
import 'package:afisha_market/const.dart';
import 'package:afisha_market/core/bloc/auth/authEvent.dart';
import 'package:afisha_market/core/bloc/auth/authState.dart';
import 'package:afisha_market/core/bloc/category/category_bloc.dart';
import 'package:afisha_market/core/data/source/remote/request/SignUpRequest.dart';
import 'package:afisha_market/core/handlers/network_exceptions.dart';
import 'package:afisha_market/core/utils/app_helpers.dart';
import 'package:afisha_market/core/utils/my_extensions.dart';
import 'package:afisha_market/pages/auth/otp/OTPScreen.dart';
import 'package:afisha_market/pages/auth/signUp/widgets/country_text_form_field.dart';
import 'package:afisha_market/pages/auth/signUp/widgets/masked_text_controller.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/bloc/auth/authBloc.dart';
import '../../../core/data/models/region.dart';
import '../../../core/data/source/remote/response/UserCategoryResponse.dart';
import '../../../core/utils/local_storage.dart';
import '../../utils/custom_button.dart';
import '../../utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class SignUpContainer extends StatefulWidget {
  const SignUpContainer({Key? key, this.userCategoryResponse})
      : super(key: key);

  final UserCategoryResponse? userCategoryResponse;

  @override
  State<SignUpContainer> createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _pass1Controller = TextEditingController();
  final _pass2Controller = TextEditingController();
  final _phoneController = MaskedTextController(
    mask: '+000 (00) 000-00-00',
  );

  final List<Map<String, dynamic>>? region = myData['REGION'];
  final List<Map<String, dynamic>>? district = myData['DISTRICT'];

  final langCode = LocalStorage.instance.getLanguage();

  String? selectedRegionName;
  String? selectedDistrictName;

  String? selectedRegionCode;

  List<Map<String, dynamic>>? sortedRegionList = [];
  List<Map<String, dynamic>>? sortedDistrictList = [];

  late Map<String, List<Map<String, dynamic>>>? dataset = {
    'REGION': region!,
    'DISTRICT': district!,
  };

  UserCategoryResponse? userCategoryResponse;

  List<String> regions = [];

  String dropdownCategoryValue = '';
  late String dropdownValue = (regions.isNotEmpty) ? regions.first : 'Toshkent';

  @override
  void initState() {
    print('LANG APP --> ${langCode}');
    userCategoryResponse = widget.userCategoryResponse;
    dropdownCategoryValue = userCategoryResponse?.userCategories[0].name ?? '';
    print('object $dropdownCategoryValue');
    print('object2 ${userCategoryResponse}');
    _phoneController.text = '+998';
    final val = TextSelection.collapsed(offset: _phoneController.text.length);
    _phoneController.selection = val;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _phoneController.dispose();
    _pass1Controller.dispose();
    _pass2Controller.dispose();
    super.dispose();
  }

  File? avatarFile;

  @override
  Widget build(BuildContext context) {
    print('userCategoryResponse --> ${widget.userCategoryResponse}');
    final l10n = AppLocalizations.of(context);
    final AuthBloc _bloc = BlocProvider.of<AuthBloc>(context);
    String regionsString = AppLocalizations.of(context)!.regions;
    regions = regionsString.split(':');
    print('regions : $regions');
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isErrorOccurred) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: MyText(
            "Something went wrong",
          )));
        }
        if (state.isAuthenticated) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => OTPScreen(
                    phoneNumber: _phoneController.text,
                  )));
        }
        if (state.networkExceptions ==
            const NetworkExceptions.unauthorisedRequest()) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Avtorizatsiya qilinmagan')));
        } else if (state.networkExceptions ==
            const NetworkExceptions.sendTimeout()) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Time out xatoligi')));
        } else if (state.networkExceptions ==
            const NetworkExceptions.unableToProcess()) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Proses xatoligi')));
        } else if (state.networkExceptions ==
            const NetworkExceptions.formatException()) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Format xatoligi')));
        }
      },
      builder: (context, state) {
        print('phone from sign up empty ${AppConst.pHONENUMBER}');
        if (state.isAuthenticated) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushNamed(context, '/otp',
                arguments: _phoneController.text);
          });
        }
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
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
                                      borderRadius: BorderRadius.circular(120)),
                                  width: 120,
                                  height: 120,
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(120),
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
                                      final pickedFile = await picker.pickImage(
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
                                      child: Icon(
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
                        _nameController,
                        validator: (val) {
                          if (val!.length < 3)
                            return 'Name must be at least 3 characters';
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFormField2(
                        l10n?.username ?? '',
                        const Icon(CupertinoIcons.person),
                        _userNameController,
                        validator: (val) {
                          if (val!.length < 3)
                            return 'UserName must be at least 3 characters';
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CountryTextFormField(
                        l10n?.phoneNumber ?? '',
                        const Icon(CupertinoIcons.phone),
                        _phoneController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                          value: selectedRegionName,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          dropdownColor: helperColor,
                          decoration: AppHelpers.decoration(
                              isHintText: true, text: '${l10n?.region}'),
                          items: dataset?['REGION']?.map((e) {
                            return DropdownMenuItem<String?>(
                              value: e['name'],
                              child: Text(
                                (langCode == 'ru')
                                    ? e['rus'].toString().toCapitalized()
                                    : e['uzl'].toString().toCapitalized(),
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != selectedRegionName) {
                              selectedDistrictName = null;
                            }
                            setState(() {
                              var l = dataset?['REGION']!.length.toInt() ?? 0;
                              for (int i = 0; i < l; i++) {
                                if (dataset?['REGION']?[i]['name'] == value) {
                                  selectedRegionCode =
                                      dataset?['REGION']?[i]['code'];
                                }
                              }
                              selectedRegionName = value!;
                              sortedDistrictList = dataset?['DISTRICT']
                                  ?.where((element) =>
                                      element['region'] == selectedRegionCode)
                                  .toList();
                            });
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                          value: (selectedDistrictName?.isNotEmpty ?? false)
                              ? selectedDistrictName
                              : null,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          dropdownColor: helperColor,
                          decoration: AppHelpers.decoration(
                              isHintText: true, text: '${l10n?.district}'),
                          items: (sortedDistrictList ?? []).map((e) {
                            return DropdownMenuItem<String?>(
                              value: e['name'],
                              child: Text(
                                (langCode == 'ru')
                                    ? e['rus'].toString().toCapitalized()
                                    : e['uzl'].toString().toCapitalized(),
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              var l = dataset?['DISTRICT']!.length.toInt() ?? 0;
                              for (int i = 0; i < l; i++) {
                                if (dataset?['DISTRICT']?[i]['name'] == val) {
                                  selectedRegionCode =
                                      dataset?['DISTRICT']?[i]['code'];
                                }
                              }
                              selectedDistrictName = val!;
                            });
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                        userCategoryResponse = state.userCategoryResponse;
                        String? item =
                            userCategoryResponse?.userCategories.first.name ??
                                '';
                        return DropdownButtonFormField(
                          value: item,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          isExpanded: true,
                          dropdownColor: helperColor,
                          decoration: AppHelpers.decoration(),
                          items: userCategoryResponse?.userCategories.map<DropdownMenuItem<String>>((UserCategory category) {
                            return DropdownMenuItem<String>(
                              value: category.name,
                              child: Expanded(
                                child: Text(
                                  category.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownCategoryValue = value!;
                            });
                          },
                        );
                      }),
                      // DropdownButtonFormField(
                      //   value: dropdownCategoryValue,
                      //   icon: const Icon(Icons.arrow_drop_down),
                      //   elevation: 16,
                      //   dropdownColor: helperColor,
                      //   decoration: AppHelpers.decoration(),
                      //   items: userCategoryResponse?.userCategories.map<DropdownMenuItem<String>>((UserCategory category) {
                      //     return DropdownMenuItem<String>(
                      //       value: category.name,
                      //       child: Text(category.name,
                      //         style: TextStyle(fontWeight: FontWeight.normal),
                      //       ),
                      //     );
                      //   }).toList(),
                      //   onChanged: (String? value) {
                      //     setState(() {
                      //       dropdownCategoryValue = value!;
                      //     });
                      //   },
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFormField2(
                        l10n?.password ?? '',
                        const Icon(CupertinoIcons.lock),
                        _pass1Controller,
                        validator: (val) {
                          if (val!.length < 5) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFormField2(
                        l10n?.confirmPassword ?? '',
                        const Icon(CupertinoIcons.lock),
                        _pass2Controller,
                        validator: (val) {
                          if (val!.length < 5)
                            return 'Password must be at least 6 characters';
                          return null;
                        },
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  CustomButton(
                    l10n?.signUpText ?? '',
                    isLoading: state.isAuthenticating,
                    onTap: () async {
                      print('Avatar --> ${state.avatar}');
                      final phone = _phoneController.text
                          .replaceAll(' ', '')
                          .replaceAll('(', '')
                          .replaceAll(')', '')
                          .replaceAll('-', '');
                      print('MyPHOne --> $phone');
                      print('dropdownValue --> $dropdownValue');
                      print('object $dropdownCategoryValue');

                      var fullName = _nameController.text;
                      var userName = _userNameController.text;
                      var categoryId = 0;

                      String selectedRegionUz = '';
                      String selectedRegionRus = '';
                      String selectedDistrictUz = '';
                      String selectedDistrictRus = '';

                      int l = userCategoryResponse?.userCategories.length ?? 0;
                      for (int i = 0; i < l; i++) {
                        if (dropdownCategoryValue ==
                            userCategoryResponse?.userCategories[i].name) {
                          categoryId =
                              userCategoryResponse?.userCategories[i].id ?? 0;
                        }
                      }

                      var lenDis = dataset?['DISTRICT']!.length.toInt() ?? 0;
                      var lenREG = dataset?['REGION']!.length.toInt() ?? 0;

                      for (int i = 0; i < lenREG; i++) {
                        if (selectedRegionName ==
                            dataset?['REGION']![i]['name']) {
                          selectedRegionRus = dataset?['REGION']![i]['rus']
                                  .toString()
                                  .toCapitalized() ??
                              '';
                          selectedRegionUz = dataset?['REGION']![i]['uzl']
                                  .toString()
                                  .toCapitalized() ??
                              '';
                        }
                      }

                      for (int i = 0; i < lenDis; i++) {
                        if (selectedDistrictName ==
                            dataset?['DISTRICT']![i]['name']) {
                          selectedDistrictRus = dataset?['DISTRICT']![i]['rus']
                                  .toString()
                                  .toCapitalized() ??
                              '';
                          selectedDistrictUz = dataset?['DISTRICT']![i]['uzl']
                                  .toString()
                                  .toCapitalized() ??
                              '';
                        }
                      }
                      var pass1 = _pass1Controller.text;
                      var pass2 = _pass2Controller.text;

                      if (pass1.isEmpty && pass1 != pass2) {
                        AppHelpers.showCheckFlash(
                            context, 'Parol bir xil emas');
                      } else {
                        AppConst.pHONENUMBER = phone;
                        _bloc.add(
                          SignUpEvent(
                              SignUpRequest(
                                fullname: fullName,
                                username: userName,
                                phone: phone,
                                viloyat: selectedRegionUz,
                                rusViloyat: selectedRegionRus,
                                tuman: selectedDistrictUz,
                                rusTuman: selectedDistrictRus,
                                adminUserCategoryId: categoryId.toString(),
                                avatar: avatarFile ??
                                    await getImageFileFromAssets(
                                        'images/afisha_logo.png'),
                                password: pass1,
                                passwordConfirmation: pass2,
                              ),
                              context),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
