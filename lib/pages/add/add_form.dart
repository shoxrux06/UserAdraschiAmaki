import 'dart:io';
import 'dart:math';
import 'package:afisha_market/core/bloc/add/create_bloc.dart';
import 'package:afisha_market/core/bloc/add/create_event.dart';
import 'package:afisha_market/core/bloc/add/create_state.dart';
import 'package:afisha_market/core/bloc/home/home_bloc.dart';
import 'package:afisha_market/core/data/source/remote/request/addRequest.dart';
import 'package:afisha_market/core/data/source/remote/response/RegionResponse.dart';
import 'package:afisha_market/core/utils/app_helpers.dart';
import 'package:afisha_market/pages/add/select_from_map_page.dart';
import 'package:afisha_market/pages/add/video_widget.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:afisha_market/pages/utils/custom_button_two.dart';
import 'package:afisha_market/pages/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/data/source/remote/response/CategoryResponse.dart';
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
  List<District> districtList = [];
  List<SubCategory> subCategoryList = [];

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
  late final _compatibilityController = TextEditingController(text: widget.productDetail?.compatibility);
  late final locationController = TextEditingController(text: widget.productDetail?.district);

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

  Map<String,dynamic> myMap = {};
  LatLng? coordinates;

  void moveToSecondPage() async{
    myMap = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectFromMapPage()));
    coordinates = myMap['coordinates'];
    locationController.text = myMap['lane'].toString();
    print('Coordinates -- > $coordinates');
    print('Lane -- > ${locationController.text}');
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
    locationController.dispose();
    super.dispose();
  }

  String? dropdownValueCategory;
  String? dropdownValueSubCategory;
  String? dropdownValueRegion;
  String? dropdownValueDistrict;

  int? categoryId;
  int? selectedRegionId;
  int? selectedDistrictId;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: height / 3,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: selectedImages.length >= 8
                                        ? () {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rasmlar soni 8 tadan oshmasligi kerak')));
                                    } : () {
                                      if (selectedImages.length >= 8) {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rasmlar soni 8 tadan oshmasligi kerak')));
                                      }
                                      showModalBottomSheet(
                                          context: context, builder: (context) {
                                        return Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomButtonTwo('${l10n?.image}',onTap: (){ getImages();},),
                                              CustomButtonTwo('${l10n?.video}',onTap: (){ getVideos();},),
                                            ],
                                          ),
                                        );
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFd7dadd),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Color(0xFFd7dadd),
                                              width: 2)),
                                      child: Center(
                                        child: FittedBox(
                                          child: Text(
                                            l10n?.selectImageFromGallery ?? '',
                                            style: TextStyle(color: mainColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        customImageContainer(0, 1),
                                        customImageContainer(1, 2),
                                        customImageContainer(2, 3),
                                        customImageContainer(3, 4),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        customImageContainer(4, 5),
                                        customImageContainer(5, 6),
                                        customImageContainer(6, 7),
                                        customImageContainer(7, 8),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                          return DropdownButtonFormField(
                              value: dropdownValueCategory,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              isExpanded: true,
                              isDense: true,
                              dropdownColor: helperColor,
                              style: TextStyle(color: disableColor),
                              decoration: AppHelpers.decoration(
                                  isHintText: true,
                                  text:  l10n?.topCategory ?? '',
                              ),
                              items: state.categoryResponse?.categories.map<DropdownMenuItem<String>>((Category value) {
                                return DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(value.name),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                subCategoryList = [];
                                setState(() {
                                  dropdownValueCategory = value!;
                                  int length = state.categoryResponse?.categories.length??0;
                                  for(int i = 0;i< length;i++){
                                    if(dropdownValueCategory == state.categoryResponse?.categories[i].name){
                                      setState(() {
                                        subCategoryList.addAll(state.categoryResponse?.categories[i].subCategories??[]);
                                        dropdownValueSubCategory = subCategoryList.first.name;
                                        categoryId = subCategoryList.first.id;
                                      });
                                    }
                                  }
                                });
                              });
                        }),
                        const SizedBox(height: 20,),
                        DropdownButtonFormField(
                            value:dropdownValueSubCategory,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            isExpanded: true,
                            isDense: true,
                            dropdownColor: helperColor,
                            hint: Align(
                                alignment: Alignment.centerLeft,
                                child: Text( l10n?.subCategory ?? '', style: TextStyle(
                                    color: disableColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16
                                ),
                                )),
                            style: TextStyle(color: disableColor),
                            decoration: AppHelpers.decoration(
                                isHintText: true,
                                text:  l10n?.color ?? '',
                            ),
                            items: subCategoryList.map<DropdownMenuItem<String>>((SubCategory value) {
                              return DropdownMenuItem<String>(
                                value: value.name,
                                child: Text(value.name),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValueSubCategory = value!;
                                for (var element in subCategoryList) {
                                  if(element.name == dropdownValueSubCategory){
                                    categoryId = element.id;
                                  }
                                }
                              });
                            }),
                        const SizedBox(height: 20,),
                        BlocBuilder<HomeBloc, HomeState>(builder: (context,state){
                          return DropdownButtonFormField(
                              value:dropdownValueRegion,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              isExpanded: true,
                              isDense: true,
                              dropdownColor: helperColor,
                              style: TextStyle(color: disableColor),
                              decoration: AppHelpers.decoration(
                                  isHintText: true,
                                  text:  l10n?.region ?? '',
                              ),
                              items: state.regionList.map<DropdownMenuItem<String>>((Region value) {
                                return DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(value.name),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                districtList = [];
                                setState(() {
                                  dropdownValueRegion = value!;
                                  int l =  state.regionList.length;
                                  for(int i =0;i<l;i++){
                                    if(dropdownValueRegion == state.regionList[i].name){
                                      setState(() {
                                        districtList.addAll(state.regionList[i].districts);
                                        dropdownValueDistrict = districtList.first.name;
                                        selectedRegionId = state.regionList[i].id;
                                        selectedDistrictId = districtList.first.id;
                                      });
                                    }
                                  }
                                });
                              });
                        }),
                        const SizedBox(height: 20,),
                        DropdownButtonFormField(
                            value:dropdownValueDistrict,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            isExpanded: true,
                            isDense: true,
                            dropdownColor: helperColor,
                            hint: Align(
                                alignment: Alignment.centerLeft,
                                child: Text( l10n?.district ?? '', style: TextStyle(
                                    color: disableColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16
                                ),
                                )),
                            style: TextStyle(color: disableColor),
                            decoration: AppHelpers.decoration(
                                isHintText: true,
                                text: 'District'
                            ),
                            items: districtList.map<DropdownMenuItem<String>>((District value) {
                              return DropdownMenuItem<String>(
                                value: value.name,
                                child: Text(value.name),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValueDistrict = value!;
                                for (var element in districtList) {
                                  if(element.name == dropdownValueDistrict){
                                    selectedDistrictId = element.id;
                                  }
                                }
                              });
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFormField2(
                          l10n?.color ?? '',
                          null,
                          _colorController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'it is must be at least 1 characters';
                            }
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
                            if (val!.isEmpty) {
                              return 'it is must be at least 1 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: (){
                            moveToSecondPage();
                          },
                          child: MyTextFormField2(
                            l10n?.selectFromMap ?? '',
                            null,
                            locationController,
                            isEnabled: false,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'it is must be at least 1 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        CustomButton(
                          widget.productDetail == null
                              ? l10n?.publish ?? ''
                              : l10n?.edit ?? '',
                          isLoading:  widget.productDetail == null?state.isCreatingProduct: state.isUpdatingProduct,
                          onTap:widget.productDetail == null? () {
                            if (isFieldsEmpty()) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong')));
                            } else {
                              _createBloc.add(CreateSuccessEvent(
                                  context,
                                  CreateRequest(
                                    title: _nameController.text,
                                    price: int.parse(_costController.text),
                                    body: _aboutController.text,
                                    categoryId: categoryId,
                                    regionId: selectedRegionId,
                                    districtId: selectedDistrictId,
                                    latitude: coordinates?.latitude?? null,
                                    longitude: coordinates?.longitude ??null,
                                    color: _colorController.text,
                                    compatibility: _compatibilityController.text,
                                    photos: selectedImages,
                                  )
                              )
                              );
                            }
                          }:(){
                            if (isFieldsEmpty()
                            ) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong')));
                            }else {
                              _createBloc.add(UpdateSuccessEvent(
                                context,
                                CreateRequest(
                                  title: _nameController.text,
                                  price: int.parse(_costController.text),
                                  body: _aboutController.text,
                                  categoryId: categoryId,
                                  regionId: selectedRegionId,
                                  districtId: selectedDistrictId,
                                  latitude:coordinates?.latitude?? null,
                                  longitude: coordinates?.longitude??null,
                                  color: _colorController.text,
                                  compatibility: _compatibilityController.text,
                                  photos: selectedImages,
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
                  ),
                );
              }),
            ),
          ),
        ),
      );
    });

  }

  Widget customImageContainer(int index, int size) {
    return Container(
      width: MediaQuery.of(context).size.width / 5.5,
      height: 100,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 2),
          borderRadius: BorderRadius.circular(8)),
      child: (selectedImages.length >= size)
          ? Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: (
                    selectedImages[index].path.substring(
                        selectedImages[index].path.lastIndexOf('.') + 1,
                        selectedImages[index].path.length) == 'mp4' ||
                        selectedImages[index].path.substring(
                            selectedImages[index].path.lastIndexOf('.') + 1,
                            selectedImages[index].path.length) == 'm4p' ||
                        selectedImages[index].path.substring(
                            selectedImages[index].path.lastIndexOf('.') + 1,
                            selectedImages[index].path.length) == 'mov'
                ) ?
                VideoWidget(selectedImages[index]) : Image.file(
                  File(
                    selectedImages[index].path,
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
                      selectedImages.removeAt(index);
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
    );
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


  bool isFieldsEmpty() => (_nameController.text.isEmpty &&
      _costController.text.isEmpty &&
      _aboutController.text.isEmpty &&
      _compatibilityController.text.isEmpty &&
      _colorController.text.isEmpty
  );

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<File> filePick = pickedFile.map<File>((e) => File(e.path)).toList();
    setState(() {
      if (filePick.isNotEmpty) {
        for (var i = 0; i < filePick.length; i++) {
          selectedImages.add(filePick[i]);
        }
        Navigator.of(context).pop();
      }
      else {
        AppHelpers.showSnackBar(context,'Nothing is selected');
      }
    },
    );
  }

  Future getVideos() async {
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      if (pickedVideo?.path.isNotEmpty ?? false) {
        final myFile = File(pickedVideo?.path ?? '');
        selectedImages.add(myFile);
        Navigator.of(context).pop();
      }
      else {
        AppHelpers.showSnackBar(context,'Nothing is selected');
      }
    },
    );
  }

}
