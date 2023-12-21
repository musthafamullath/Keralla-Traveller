import 'dart:io';
import 'package:flutter/material.dart';
import 'package:keralatraveller/db_functions/admin_db_function.dart';
import 'package:keralatraveller/db_functions/user_db_fucntion.dart';
import 'package:keralatraveller/modal/mycountry.dart';
import 'package:keralatraveller/refacteredclasses/app_button.dart';
import 'package:keralatraveller/refacteredclasses/app_textfieldone.dart';
import 'package:keralatraveller/refacteredfunctions/app_regexsfunc.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refacteredclasses/app_widgets.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final Mycountry mycountry;
  final int index;
  final Function(Mycountry) updateprofileinfo;
  const EditProfile({
    super.key,
    required this.mycountry,
    required this.index,
    required this.updateprofileinfo,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  XFile? image;
  String? addToHomeImage;

  @override
  void initState() {
    nameController.text = widget.mycountry.name;
    emailController.text = widget.mycountry.email;
    passwordController.text = widget.mycountry.password;
    image = widget.mycountry.imageUser != null
        ? XFile(widget.mycountry.imageUser!)
        : null;
    super.initState();
  }

  Future<void> pickedImage() async {
    final imagetaker = ImagePicker();
    final pickedImages =
        await imagetaker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppWidgets(
      mainwidget: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSizedBoxes.box3,
              GestureDetector(
                onTap: () async {
                  bottomsheet(context);
                },
                child: image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.file(
                          File(image!.path),
                          fit: BoxFit.cover,
                        ))
                    : Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                                color: AppColor.black,
                                style: BorderStyle.solid,
                                width: 2)),
                        child: const Icon(Icons.camera)),
              ),
              AppSizedBoxes.box3,
              AppTextFieldOne(
                hint: AppStrings.userName,
                validators: AutovalidateMode.onUserInteraction,
                keyboard: TextInputType.name,
                controller: nameController,
                validator: validateName,
              ),
              AppSizedBoxes.box3,
              AppTextFieldOne(
                hint: AppStrings.email,
                validators: AutovalidateMode.onUserInteraction,
                keyboard: TextInputType.emailAddress,
                controller: emailController,
                validator: validateEmail,
              ),
              AppSizedBoxes.box3,
              AppTextFieldOne(
                hint: AppStrings.passWord,
                validators: AutovalidateMode.onUserInteraction,
                keyboard: TextInputType.text,
                controller: passwordController,
                validator: validatePassword,
              ),
              AppSizedBoxes.box3,
              Appbutton(
                bottonText: AppStrings.save,
                bottonnavigator: () async {
                  if (_formKey.currentState!.validate()&& image!=null) {
                    await userEditDetailsFromHome(
                        Mycountry(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          imageUser: image!.path,
                        ),
                        widget.index);
                    widget.updateprofileinfo(Mycountry(
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      imageUser: image!.path,
                    ));
                    // ignore: use_build_context_synchronously
                    editUserSnackBar(context);
                    setState(() {
                      image = null;
                    });
                    nameController.clear();
                    emailController.clear();
                    passwordController.clear();
                  }else{
                     addAdminSnackBarImageError(context);
                  }
                },
              ),
              AppSizedBoxes.box3,
            ],
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
