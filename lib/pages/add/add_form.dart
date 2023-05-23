import 'dart:io';
import 'dart:math';
import 'package:afisha_market/core/bloc/add/create_bloc.dart';
import 'package:afisha_market/core/bloc/add/create_event.dart';
import 'package:afisha_market/core/bloc/add/create_state.dart';
import 'package:afisha_market/core/bloc/home/home_bloc.dart';
import 'package:afisha_market/core/data/source/remote/request/addRequest.dart';
import 'package:afisha_market/core/data/source/remote/response/RegionResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/filtered_product_category_response.dart';
import 'package:afisha_market/core/utils/app_helpers.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:afisha_market/pages/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/data/models/region.dart';
import '../../core/data/source/remote/response/GetProfileResponse.dart';
import '../main_container.dart';
import '../utils/custom_border_button.dart';
import '../utils/custom_button.dart';
import 'package:http/http.dart' as http;
import 'package:afisha_market/core/bloc/category/category_bloc.dart';

class AddScreenForm extends StatefulWidget {
  final ProductDetail? productDetail;

  const AddScreenForm({Key? key, this.productDetail}) : super(key: key);

  @override
  State<AddScreenForm> createState() => _AddScreenFormState();
}
class _AddScreenFormState extends State<AddScreenForm> {
  late CreateBloc _createBloc;
  List<File> selectedImages = [];
  List<FilteredCategory> categoryList = [];
  List<Region> regionList = [];
  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final _nameController =
      TextEditingController(text: widget.productDetail?.title);
  late final _costController =
      TextEditingController(text: widget.productDetail?.price.toString());
  late final _aboutController =
      TextEditingController(text: widget.productDetail?.body);
  late final _colorController =
      TextEditingController(text: widget.productDetail?.color);
  late final _compatibilityController =
      TextEditingController(text: widget.productDetail?.compatibility);

  Future<List<File>> urlToFile() async {
    final List<File> tempList = [];
    int l = widget.productDetail?.photos.length??0;
    for(int i = 0;i<l;i++){
      var rng =  Random();
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File file =  File('$tempPath${rng.nextInt(100)}.png');
      http.Response response = await http.get(Uri.parse('${widget.productDetail?.photos[i]}'));
      await file.writeAsBytes(response.bodyBytes);
      tempList.add(file);
    }
    return tempList;
  }
  getImages2()async{
    selectedImages = await urlToFile();
    setState(() {});
    print('SEL IMAGES --> $selectedImages');
  }
  @override
  void initState() {
    context.read<HomeBloc>().add(HomeInitEvent());
    context.read<CategoryBloc>().add(CategoryFilteredEvent());
    super.initState();
    setState(() {
      getImages2();
    });
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
  String dropdownValueCategory = '';
  String dropdownValueRegion = '';

  int? selectedRegionId;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final l10n = AppLocalizations.of(context);
    String categoryString = AppLocalizations.of(context)!.categories;
    List<String> categories = categoryString.split(':');
    print('categorise : $categories');
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: BlocConsumer<CreateBloc, CreateState>(listener: (context, state) {
                if (state.isUploaded ) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tovar muaffaqiyatli qo\'shildi')));
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainContainer()));
                }
                if (state.isUpdated) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tovar muaffaqiyatli yangilandi')));
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => MainContainer(isFromProfile: true,)));
                }
                if (state.isDeleted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tovar muaffaqiyatli o\'chirildi')));
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MainContainer(isFromProfile: true,)));
                }
              }, builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: selectedImages.length >= 4
                                    ? () {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rasmlar soni 4 tadan oshmasligi kerak')));
                                      }
                                    : () {
                                        if (selectedImages.length >= 4) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rasmlar soni 4 tadan oshmasligi kerak')));
                                        }
                                        getImages();
                                      },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFd7dadd),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Color(0xFFd7dadd), width: 2)),
                                  child: Center(
                                    child: FittedBox(
                                      child: Text(
                                        l10n?.selectImageFromGallery??'',
                                        style: TextStyle(color: mainColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: width / 5.5,
                                      height: 100,
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black12, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: (selectedImages.length >= 1)
                                          ? Stack(
                                              children: [
                                                Positioned(
                                                  top: 0,
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(8),
                                                      child: Image.file(
                                                        File(
                                                          selectedImages[0].path,
                                                        ),
                                                        fit: BoxFit.fill,
                                                      )),
                                                ),
                                                Positioned(
                                                    right: -5,
                                                    top: -10,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            selectedImages.removeAt(0);
                                                          });
                                                        },
                                                        icon: const Icon(
                                                          Icons.cancel,
                                                          color: Colors.white,
                                                        ))
                                                )
                                              ],
                                            )
                                          : Container(),
                                    ),
                                    Container(
                                      width: width / 5.5,
                                      height: 100,
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.black12, width: 2)),
                                      child: (selectedImages.length >= 2)
                                          ? Stack(children: [
                                              Positioned(
                                                top: 0,
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.file(
                                                    File(
                                                      selectedImages[1].path,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  right: -5,
                                                  top: -10,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          selectedImages.removeAt(1);
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.cancel,
                                                        color: Colors.white,
                                                      )))
                                            ])
                                          : Container(),
                                    ),
                                    Container(
                                      width: width / 5.5,
                                      height: 100,
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        // color: Colors.black,
                                        border: Border.all(
                                            color: Colors.black12, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                      child: (selectedImages.length >= 3)
                                          ? Stack(
                                              children: [
                                                Positioned(
                                                  top: 0,
                                                  bottom: 0,
                                                  right: 0,
                                                  left: 0,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(8),
                                                    child: Image.file(
                                                      File(
                                                        selectedImages[2]
                                                            .path,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                    right: -5,
                                                    top: -10,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            selectedImages
                                                                .removeAt(2);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.cancel,
                                                          color: Colors.white,
                                                        )))
                                              ],
                                            )
                                          : Container(),
                                    ),
                                    Container(
                                      width: width / 5.5,
                                      height: 100,
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: 2)),
                                      child: (selectedImages.length >= 4)
                                          ? Stack(
                                              children: [
                                                Positioned(
                                                  top: 0,
                                                  bottom: 0,
                                                  right: 0,
                                                  left: 0,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.file(
                                                      File(
                                                        selectedImages[3]
                                                            .path,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                    right: -5,
                                                    top: -10,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            selectedImages.removeAt(3);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.cancel,
                                                          color: Colors.white,
                                                        )))
                                              ],
                                            )
                                          : Container(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      MyTextFormField2(
                        l10n?.productName ?? '',
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
                        l10n?.price ?? '',
                        null,
                        _costController,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Amount must be at least 1 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFormField2(
                        l10n?.description ?? '',
                        null,
                        _aboutController,
                        validator: (val) {
                          if (val!.length < 10) {
                            return 'it is must be at least 10 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CategoryBloc, CategoryState>(builder: (context,state){
                        Future.delayed(Duration.zero,(){
                          dropdownValueCategory = state.filteredProductCategoryList.first.name??'';
                        });
                        if(state.filteredProductCategoryList.isNotEmpty){
                          categoryList = state.filteredProductCategoryList;
                          return DropdownButtonFormField(
                              value: state.filteredProductCategoryList[0].name,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              dropdownColor: helperColor,
                              style: TextStyle(color: disableColor),
                              decoration: AppHelpers.decoration(),
                              items: state.filteredProductCategoryList.map<DropdownMenuItem<String>>((FilteredCategory value) {
                                return DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(value.name),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValueCategory = value!;
                                });
                              });
                        }
                        else{
                          return DropdownButtonFormField(
                              value: dropdownValueCategory.isNotEmpty? dropdownValueCategory:null,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              dropdownColor: helperColor,
                              style: TextStyle(color: disableColor),
                              decoration: AppHelpers.decoration(),
                              items: state.filteredProductCategoryList.map<DropdownMenuItem<String>>((FilteredCategory value) {
                                return DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(value.name),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValueCategory = value!;
                                });
                              });
                        }
                      }),
                      SizedBox(height: 20,),
                      BlocBuilder<HomeBloc, HomeState>(builder: (context,state){
                        Future.delayed(Duration.zero,(){
                          dropdownValueRegion = state.regionList.first.name;
                        });
                        if(state.regionList.isNotEmpty){
                          regionList = state.regionList;
                          int l =  regionList.length;
                          for(int i =0;i<l;i++){
                            if(dropdownValueRegion == state.regionList[i].name){
                              selectedRegionId = state.regionList[i].id;
                            }
                          }
                          return DropdownButtonFormField(
                              value:state.regionList[0].name,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              dropdownColor: helperColor,
                              style: TextStyle(color: disableColor),
                              decoration: AppHelpers.decoration(),
                              items: state.regionList.map<DropdownMenuItem<String>>((Region value) {
                                return DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(value.name),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValueRegion = value!;
                                  int l =  state.regionList.length;
                                  for(int i =0;i<l;i++){
                                    if(dropdownValueRegion == state.regionList[i].name){
                                      selectedRegionId = state.regionList[i].id;
                                    }
                                  }
                                });
                              });
                        }else{
                          return DropdownButtonFormField(
                              value: dropdownValueRegion.isNotEmpty
                                  ? dropdownValueRegion
                                  : null,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              dropdownColor: helperColor,
                              style: TextStyle(color: disableColor),
                              decoration: AppHelpers.decoration(),
                              items: state.regionList.map<DropdownMenuItem<String>>((Region value) {
                                return DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(value.name),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValueRegion = value!;
                                  int l =  state.regionList.length;
                                  for(int i =0;i<l;i++){
                                    if(dropdownValueRegion == state.regionList[i].name){
                                      selectedRegionId = state.regionList[i].id;
                                    }
                                  }
                                });
                              });
                        }
                      }),

                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFormField2(
                        l10n?.color ?? '',
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
                        l10n?.compatibility ?? '',
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
                      CustomButton(
                        widget.productDetail == null
                            ? l10n?.publish ?? ''
                            : l10n?.edit ?? '',
                        isLoading:  widget.productDetail == null?state.isCreatingProduct: state.isUpdatingProduct,
                        onTap:widget.productDetail == null? () {
                          print('dropdownValueCategory : $dropdownValueCategory');
                          int productCategoryId = 0;
                          print('cat <$categoryList>');
                          for(int i = 0;i< categoryList.length; i++){
                            if(dropdownValueCategory == categoryList[i].name){
                              productCategoryId = categoryList[i].id;
                              print('category id $productCategoryId');
                            }
                          }
                          print('isUploaded1 : ${state.isUploaded}');
                          print('REgionID : $selectedRegionId');
                          if (_nameController.text.isEmpty &&
                              _costController.text.isEmpty &&
                              _aboutController.text.isEmpty &&
                              _compatibilityController.text.isEmpty &&
                              _colorController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong')));
                          } else {
                            _createBloc.add(CreateSuccessEvent(
                                context,
                                CreateRequest(
                                  title: _nameController.text,
                                  categoryId: productCategoryId,
                                  price: int.parse(_costController.text),
                                  body: _aboutController.text,
                                  compatibility: _compatibilityController.text,
                                  color: _colorController.text,
                                  photos: selectedImages,
                                  regionId: selectedRegionId,
                                )
                            )
                            );
                          }
                        }:(){
                          print('dropdownValueCategory : $dropdownValueCategory');
                          print('cat <$categoryList>');

                          int productCategoryId = 0;
                          for(int i = 0;i< categoryList.length; i++){
                            if(dropdownValueCategory == categoryList[i].name){
                              productCategoryId = categoryList[i].id;
                              print('category id $productCategoryId');
                            }
                          }
                          print('isUploaded1 : ${state.isUploaded}');
                          if (_nameController.text.isEmpty &&
                              _costController.text.isEmpty &&
                              _aboutController.text.isEmpty &&
                              _compatibilityController.text.isEmpty &&
                              _colorController.text.isEmpty
                          ) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Something went wrong')));
                          }else {
                            _createBloc.add(UpdateSuccessEvent(
                              context,
                              CreateRequest(
                                title: _nameController.text,
                                categoryId: productCategoryId,
                                price: int.parse(_costController.text),
                                body: _aboutController.text,
                                compatibility: _compatibilityController.text,
                                color: _colorController.text,
                                photos: selectedImages,
                                regionId: selectedRegionId,
                              ),
                              widget.productDetail?.id??0
                            ));
                          }
                        },
                      ),
                      widget.productDetail == null? Container():CustomBorderButton(
                        '${l10n?.delete}',
                        onTap: () {
                          _delete(context, widget.productDetail?.id??0);
                        },
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      );
    });

  }

  void _delete(BuildContext context, int id) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('${l10n?.pleaseConfirm}'),
          content: Text('${l10n?.areYouSureDeleteThisProduct}'),
          actions: [
            // The "Yes" button
            TextButton(
              onPressed: () {
                context.read<CreateBloc>().add(DeleteSuccessEvent(context, id));
                Navigator.of(context).pop();
              },
              child: Text('${l10n?.yes}'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('${l10n?.no}'))
          ],
        );
      },
    );
  }


  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<File> filePick = pickedFile.map<File>((e) => File(e.path)).toList();
    setState(
      () {
        if (filePick.isNotEmpty) {
          for (var i = 0; i < filePick.length; i++) {
            selectedImages.add(filePick[i]);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
