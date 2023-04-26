import 'dart:io';

import 'package:afisha_market/core/bloc/add/create_bloc.dart';
import 'package:afisha_market/core/bloc/add/create_event.dart';
import 'package:afisha_market/core/bloc/add/create_state.dart';
import 'package:afisha_market/core/data/source/remote/request/addRequest.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:afisha_market/pages/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddScreenForm extends StatefulWidget {
  const AddScreenForm({Key? key}) : super(key: key);

  @override
  State<AddScreenForm> createState() => _AddScreenFormState();
}

const List<String> stateList = <String>[
  'Новое',
  'Идеальное',
  'Очень хорошее',
  'Удовлетворительное',
];

const List<String> categoryList = <String>[
  "Телефоны и аксессуары",
  "Бытовая электроника",
  "Авто и мототовары",
  "Бытовая техника",
  "Одежда",
  "Обувь",
  "Красота и здоровье",
  "Строительное оборудование",
  "Спортивные товары",
  "Наручные часы",
  "Мебель",
  "Детские товары",
  "Хобби и творчество",
  "Канцтовары",
  "Товары для животных",
  "Книги",
  "Сад и поместье"
];

class _AddScreenFormState extends State<AddScreenForm> {
  late CreateBloc _createBloc;
  List<File> selectedImages = [];
  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _costController = TextEditingController();
  final _aboutController = TextEditingController();
  final _colorController = TextEditingController();
  final _compatibilityController = TextEditingController();
  String dropdownValue = stateList.first;
  String dropdownValueCategory = categoryList.first;

  @override
  void initState() {
    super.initState();
    _createBloc = BlocProvider.of<CreateBloc>(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
    _aboutController.dispose();
    _colorController.dispose();
    _compatibilityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: BlocBuilder<CreateBloc, CreateState>(
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            height: 250,
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    getImages();
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    size: 80,
                                    color: mainColor,
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: selectedImages.isEmpty
                                        ? Center(
                                            child:
                                                Text('selectImageFromGallery'.tr()))
                                        : GridView.builder(
                                            itemCount: selectedImages.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4),
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return Center(
                                                  child: kIsWeb
                                                      ? Image.network(
                                                          selectedImages[index]
                                                              .path)
                                                      : Image.file(File(
                                                          selectedImages[index]
                                                              .path)));
                                            },
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFormField2(
                          'productName',
                          null,
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
                          'price',
                          null,
                          _costController,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val!.length < 1)
                              return 'Amount must be at least 1 characters';
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFormField2(
                          'description',
                          null,
                          _aboutController,
                          validator: (val) {
                            if (val!.length < 10)
                              return 'it is must be at least 10 characters';
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                            value: dropdownValueCategory.isNotEmpty
                                ? dropdownValueCategory
                                : null,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            dropdownColor: helperColor,
                            style: TextStyle(color: disableColor),
                            decoration: InputDecoration(
                              fillColor: helperColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: mainColor, width: 0.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: mainColor, width: 0.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: mainColor, width: 0.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: mainColor, width: 0.5),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: mainColor, width: 0.5),
                              ),
                            ),
                            items: categoryList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValueCategory = value!;
                              });
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFormField2(
                          'color',
                          null,
                          _colorController,
                          validator: (val) {
                            if (val!.isEmpty)
                              return 'it is must be at least 1 characters';
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFormField2(
                          'compatibility',
                          null,
                          _compatibilityController,
                          validator: (val) {
                            if (val!.isEmpty)
                              return 'it is must be at least 1 characters';
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // DropdownButtonFormField(
                        //     value: dropdownValue,
                        //     icon: const Icon(Icons.arrow_drop_down),
                        //     elevation: 16,
                        //     dropdownColor: helperColor,
                        //     style: TextStyle(color: disableColor),
                        //     decoration: InputDecoration(
                        //       fillColor: helperColor,
                        //       filled: true,
                        //       border: OutlineInputBorder(
                        //         borderRadius:
                        //             const BorderRadius.all(Radius.circular(16)),
                        //         borderSide:
                        //             BorderSide(color: mainColor, width: 0.5),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius:
                        //             const BorderRadius.all(Radius.circular(16)),
                        //         borderSide:
                        //             BorderSide(color: mainColor, width: 0.5),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius:
                        //             const BorderRadius.all(Radius.circular(16)),
                        //         borderSide:
                        //             BorderSide(color: mainColor, width: 0.5),
                        //       ),
                        //       errorBorder: OutlineInputBorder(
                        //         borderRadius:
                        //             const BorderRadius.all(Radius.circular(16)),
                        //         borderSide:
                        //             BorderSide(color: mainColor, width: 0.5),
                        //       ),
                        //       focusedErrorBorder: OutlineInputBorder(
                        //         borderRadius:
                        //             const BorderRadius.all(Radius.circular(16)),
                        //         borderSide:
                        //             BorderSide(color: mainColor, width: 0.5),
                        //       ),
                        //     ),
                        //     items: stateList
                        //         .map<DropdownMenuItem<String>>((String value) {
                        //       return DropdownMenuItem<String>(
                        //         value: value,
                        //         child: Text(value),
                        //       );
                        //     }).toList(),
                        //     onChanged: (String? value) {
                        //       setState(() {
                        //         dropdownValue = value!;
                        //       });
                        //     }),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        MyBigButton(
                          'publish',
                          onTap: () {
                            if (_nameController.text.isEmpty &&
                                _costController.text.isEmpty &&
                                _aboutController.text.isEmpty &&
                                _compatibilityController.text.isEmpty &&
                                _colorController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Something went wrong')));
                            } else {
                              _createBloc.add(CreateSuccessEvent(CreateRequest(
                                  title: _nameController.text,
                                  categoryId: 8,
                                  price: int.parse(_costController.text),
                                  body: _aboutController.text,
                                  compatibility: _compatibilityController.text,
                                  color: _colorController.text,
                                  photos: selectedImages,
                                  regionId: 1)));
                            }
                            // var fullName = _nameController.text;
                            // var userName = _userNameController.text;
                            // var phoneNumber = _phoneController.text;
                            // var pass1 = _pass1Controller.text;
                            // var pass2 = _pass2Controller.text;
                            // if (pass1.isEmpty && pass1 != pass2) {
                            // } else {
                            //   _bloc.add(SignUpEvent(SignUpRequest(
                            //       fullname: fullName,
                            //       username: userName,
                            //       phone: phoneNumber,
                            //       password: pass1,
                            //       passwordConfirmation: pass2)));
                          },
                        )
                      ],
                    ),
                  );
                }
              ),
            ),
          ),
        ),
      );
    });
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<File> filePick = pickedFile.map<File>((e) => File(e.path)).toList();

    setState(
      () {
        if (filePick.isNotEmpty) {
          for (var i = 0; i < filePick.length; i++) {
            selectedImages.add(filePick[i]);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
