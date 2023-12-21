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
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textfeildborders.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:image_picker/image_picker.dart';

class AddToHome extends StatefulWidget {
  const AddToHome({super.key});

  @override
  State<AddToHome> createState() => _AddToHomeState();
}

class _AddToHomeState extends State<AddToHome> {
  final _formKey = GlobalKey<FormState>();
  final _placeController = TextEditingController();
  final _locationController = TextEditingController();
  final _detailsController = TextEditingController();
  String? selectedCategories = AppStrings.all;
  double? ratingValue = 0;
  String? _addToHomeImage;
  XFile? _image;

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
          title: AppStrings.addToHomes,
        ),
        body: BackgroundWrapper(
          child: AppWidgetsOne(
              mainwidget: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizedBoxes.box2,
                const Padding(
                  padding: EdgeInsets.only(left: 50, bottom: 20),
                  child: Text(
                    AppStrings.addsomethingtohome,
                    style: Apptext.text8,
                  ),
                ),
                AppSizedBoxes.box5,
                Container(
                  decoration: AppTextFieldBorders.border4,
                  child: GestureDetector(
                    onTap: () async {
                      bottomsheet(context);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.buttoncolor,
                          image: _addToHomeImage != null
                              ? DecorationImage(
                                  image: FileImage(File(_addToHomeImage!)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _addToHomeImage == null
                            ? const Icon(
                                Icons.add_a_photo_outlined,
                                weight: 100,
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                AppSizedBoxes.box5,
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    AppStrings.place,
                    style: Apptext.text2,
                  ),
                ),
                AppTextFieldOne(
                  hint: AppStrings.nameofplace,
                  validators: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.name,
                  controller: _placeController,
                  validator: validatePlaceAddToHome,
                ),
                AppSizedBoxes.box5,
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    AppStrings.location,
                    style: Apptext.text2,
                  ),
                ),
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
                          width: MediaQuery.of(context).size.width * .30,
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
                              AppStrings.lacks,
                              AppStrings.beachs,
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
                          width: MediaQuery.of(context).size.width * .40,
                          height: MediaQuery.of(context).size.width * .13,
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: AppColor.whiteOpacity,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 14, left: 10),
                            child: RatingBar(
                                itemPadding: const EdgeInsets.symmetric(
                                  horizontal: 1,
                                ),
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 20,
                                minRating: 3,
                                initialRating: 3,
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
                                  ratingValue = rating;
                                }),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                AppSizedBoxes.box5,
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    AppStrings.details,
                    style: Apptext.text2,
                  ),
                ),
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
                    bottonText: AppStrings.addtohome,
                    bottonnavigator: () async {
                      final key = DateTime.now().millisecondsSinceEpoch;
                      if (_formKey.currentState!.validate() && _image != null) {
                        await addminAddDetailsToHome(
                          AddToHomeAdmin(
                            image: _image!.path,
                            categories: selectedCategories!,
                            rating: ratingValue!,
                            place: _placeController.text.trim(),
                            location: _locationController.text.trim(),
                            details: _detailsController.text.trim(),
                            key: key.toString(),
                          ),
                        );
                        // ignore: use_build_context_synchronously
                        addAdminSnackBar(context);
                        setState(() {
                          _image = null;
                        });
                        _placeController.clear();
                        _locationController.clear();
                        _detailsController.clear();
                      } else {
                        addAdminSnackBarImageError(context);
                      }
                    }),
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
                            _image = img;
                            _addToHomeImage = _image!.path;
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
                            _image = img;
                          });
                          _addToHomeImage = _image!.path;
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
