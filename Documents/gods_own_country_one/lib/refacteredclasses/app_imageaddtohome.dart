import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:image_picker/image_picker.dart';

class AppImageAddToHome extends StatefulWidget {
  final double size;
  final Widget imageWidget;
  const AppImageAddToHome({super.key, required this.size, required this.imageWidget});

  @override
  State<AppImageAddToHome> createState() => _AppImageAddToHomeState();
}

class _AppImageAddToHomeState extends State<AppImageAddToHome> {
  String? _addToHomeImage;
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.black,
          style: BorderStyle.solid,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: GestureDetector(
        onTap: () async {
          bottomsheet(context);
        },
        child: 
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            height: 150,
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
                 AppStrings.chooseanyimagesource,
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
                        setState(() {
                          image = img;
                        });
                        _addToHomeImage = image?.path;
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
                        setState(() {
                          image = img;
                        });
                        _addToHomeImage = image?.path;
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
