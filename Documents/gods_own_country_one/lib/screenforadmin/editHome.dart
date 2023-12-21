// ignore_for_file: file_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:keralatraveller/db_functions/admin_db_function.dart';
import 'package:keralatraveller/modal/addtohomeadmin.dart';
import 'package:keralatraveller/refacteredclasses/app_button.dart';
import 'package:keralatraveller/refacteredclasses/app_textfieldone.dart';
import 'package:keralatraveller/refacteredclasses/app_toolbarsearch.dart';
import 'package:keralatraveller/refacteredclasses/app_widget1.dart';
import 'package:keralatraveller/refacteredclasses/leanir.dart';
import 'package:keralatraveller/refacteredfunctions/app_regexsfunc.dart';
import 'package:keralatraveller/refacteredfunctions/allfunc.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textfeildborders.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:image_picker/image_picker.dart';

class EditHome extends StatefulWidget {
  final int index;
  final AddToHomeAdmin editAreas;
  const EditHome({
    super.key,
    required this.index,
    required this.editAreas,
  });

  @override
  State<EditHome> createState() => _EditHomeState();
}

class _EditHomeState extends State<EditHome> {
  XFile? _image;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _placeController;
  late TextEditingController _locationController;
  late TextEditingController _detailsController;
  late double _ratingValue;
  late String selectedCategories;
  String? addToHomeImage;

  @override
  void initState() {
    super.initState();
    _placeController = TextEditingController(text: widget.editAreas.place);
    _locationController =
        TextEditingController(text: widget.editAreas.location);
    _detailsController = TextEditingController(text: widget.editAreas.details);
    _image = XFile(widget.editAreas.image);
    _ratingValue = widget.editAreas.rating;
    selectedCategories = widget.editAreas.categories;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusNode currentfocus = FocusScope.of(context);
        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppToolBar(
          title: AppStrings.edithome,
        ),
        body: BackgroundWrapper(
          child: AppWidgetsOne(
              mainwidget: Form(
            key: _formKey,
            child: Column(
              children: [
                AppSizedBoxes.box2,
                const Text(
                  AppStrings.youcanedithomehere,
                  style: Apptext.text8,
                ),
                AppSizedBoxes.box5,
                Container(
                  decoration: AppTextFieldBorders.border4,
                  child: GestureDetector(
                    onTap: () async {
                      // bottomsheet(context);
                      bottomsheet(context);
                    },
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.file(
                              File(_image!.path),
                              fit: BoxFit.cover,
                            ))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              File(widget.editAreas.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                AppSizedBoxes.box5,
                AppTextFieldOne(
                  hint: AppStrings.nameofplace,
                  validators: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.name,
                  controller: _placeController,
                  validator: validatePlaceAddToHome,
                ),
                AppSizedBoxes.box5,
                AppTextFieldOne(
                  hint: AppStrings.location,
                  validators: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.name,
                  controller: _locationController,
                  validator: validateLocationAddToHome,
                ),
                AppSizedBoxes.box5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            AppStrings.categories,
                            style: Apptext.text2,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .35,
                          height: MediaQuery.of(context).size.width * .13,
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: AppColor.whiteOpacity,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton<String>(
                            value: selectedCategories,
                            icon: const Icon(Icons.arrow_drop_down),
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                            items: <String>[
                              AppStrings.all,
                              AppStrings.beachs,
                              AppStrings.lacks,
                              AppStrings.mountain,
                              AppStrings.forest,
                              AppStrings.river,
                            ].map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                            onChanged: (String? newVlues) {
                              setState(() {
                                selectedCategories = newVlues.toString();
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            AppStrings.rating,
                            style: Apptext.text2,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .30,
                          height: MediaQuery.of(context).size.width * .13,
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: AppColor.whiteOpacity,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20,bottom: 20),
                            child: RatingBar(
                                itemPadding: const EdgeInsets.symmetric(
                                  horizontal: 1,
                                ),
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 18,
                                initialRating: _ratingValue,
                                allowHalfRating: true,
                                ratingWidget: RatingWidget(
                                  full: const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  half: const Icon(
                                    Icons.star_half,
                                    color: Colors.amber,
                                  ),
                                  empty: const Icon(
                                    Icons.star_border,
                                    color: Colors.amber,
                                  ),
                                ),
                                onRatingUpdate: (rating) {
                                  _ratingValue = rating;
                                }),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                AppSizedBoxes.box5,
                AppTextFieldOne(
                  hint: AppStrings.details,
                  validators: AutovalidateMode.onUserInteraction,
                  minLiness: 3,
                  maxLiness: 6,
                  keyboard: TextInputType.text,
                  controller: _detailsController,
                  validator: validateDetailsAddToHome,
                ),
                AppSizedBoxes.box5,
                Appbutton(
                  bottonText: AppStrings.savechanges,
                  bottonnavigator: () async {
                    final key = DateTime.now().millisecondsSinceEpoch;
                    if (_formKey.currentState!.validate()) {
                      await addminEditDetailsFromHome(
                        AddToHomeAdmin(
                          image: _image!.path,
                          place: _placeController.text.trim(),
                          location: _locationController.text.trim(),
                          details: _detailsController.text.trim(),
                          categories: selectedCategories,
                          rating: _ratingValue, 
                          key: key.toString(),
                        ),
                        widget.index,
                      );
                      // ignore: use_build_context_synchronously
                      editAdminSnackBar(context);
                      setState(() {
                        _image = null;
                      });
                      _placeController.clear();
                      _locationController.clear();
                      _detailsController.clear();
                      //  editDatum();
                    }
                  },
                ),
                AppSizedBoxes.box2,
              ],
            ),
          )),
        ),
      ),
    );
  }
  bottomsheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                  color: AppColor.black, style: BorderStyle.solid, width: 2),
              borderRadius: BorderRadius.circular(5),
              color: AppColor.buttoncolor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppSizedBoxes.box5,
                const Text(
                  AppStrings.youcanchooseanyimagesource,
                  style: Apptext.text8,
                ),
                AppSizedBoxes.box5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        XFile? img = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (img != null) {
                          setState(() {
                            image = img;
                            addToHomeImage = image!.path;
                          });
                        }
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.greenAccent,
                      ),
                      label: const Text(
                        AppStrings.camera,
                        style: Apptext.text12,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        XFile? img = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (img != null) {
                          setState(() {
                            image = img;
                          });
                          addToHomeImage = image!.path;
                        }
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.image_outlined,
                        color: Colors.redAccent,
                      ),
                      label: const Text(
                        AppStrings.gallery,
                        style: Apptext.text12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
