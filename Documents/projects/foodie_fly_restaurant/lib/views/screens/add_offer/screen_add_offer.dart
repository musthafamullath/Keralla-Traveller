import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/category/category_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/offer/offer_bloc.dart';
import 'package:foodie_fly_restaurant/models/offer.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';
import 'package:foodie_fly_restaurant/views/screens/add_dishes/widgets/pick_image.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/button_widget.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/text_field_widget.dart';
import 'package:foodie_fly_restaurant/views/widgets/function_widgets/snackbar_function.dart';
import 'package:image_picker/image_picker.dart';

class ScreenAddOffer extends StatefulWidget {
  const ScreenAddOffer({super.key});

  @override
  State<ScreenAddOffer> createState() => _ScreenAddOfferState();
}

class _ScreenAddOfferState extends State<ScreenAddOffer> {
  final formkey = GlobalKey<FormState>();
  final offerController = TextEditingController();

  final offerPerController = TextEditingController();



  int categoryId = 0;

  XFile? imagePath;

  String image = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBarWidget(title: 'Add New Offer'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    imagePath = await showBottomSheetWidget(context);
                    if (imagePath != null) {
                      image = imagePath!.path;
                      
                    }
                  },
                  child: Container(
                    width: width,
                    height: height * .3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                     color: Colors.grey.shade300
                    ),
                    child: image != ''
                        ? Image.file(File(image))
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 70,color: yellow,),
                              Text(
                                'Add Banner',
                                style: boldGrey,
                              )
                            ],
                          ),
                  ),
                ),
                kHight10,
                TextFieldWidget(
                  userController: offerController,
                  label: 'Offer Name: ',
                  inputType: TextInputType.name,
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) return 'Add offer name';
                    return null;
                  },
                ),
                kHight10,
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: DropdownButtonFormField(
                        dropdownColor: Colors.grey.shade300,
                        iconSize: 32,
                        validator: (value) {
                          if (value == null) {
                            return "Choose category";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            label: Text(state.categories[0].name!),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            border: InputBorder.none),
                        items: state.categories.map((cat) {
                          return DropdownMenuItem(
                            value: cat,
                            child: Text(cat.name!),
                          );
                        }).toList(),
                        onChanged: (value) async {
                          categoryId = value!.id!;
                          log(categoryId.toString());
                        },
                      ),
                    );
                  },
                ),
                kHight10,
                TextFieldWidget(
                  userController: offerPerController,
                  label: 'Offer percentage: ',
                  inputType: TextInputType.number,
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) return 'Add offer percentage';
                    return null;
                  },
                ),
                kHight30,
                BlocConsumer<OfferBloc, OfferState>(
                  listener: (context, state) {
                    if (state is AddOfferSuccessState) {
                      showSnack(context, green, 'offer created successfully');
                    } else if (state is AddOfferInvalidInputs) {
                      showSnack(context, amber, "invalid inputs");
                    } else if (state is AddOfferFailedToGetImageFromForm) {
                      showSnack(
                          context, orange, "failed to get image from form");
                    } else if (state is AddOfferFailedToParseBody) {
                      showSnack(context, orange, "failed to parse body");
                    } else if (state is AddOfferFailedToOpenFilePathInServer) {
                      showSnack(
                          context, amber, "failed to open file path in server");
                    } else if (state is AddOfferFailedToUploadFileToCloud) {
                      showSnack(
                          context, amber, "failed to upload file to cloud");
                    } else if (state is AddOfferFailedToDeleteTempImage) {
                      showSnack(context, amber, "failed to delete temp image");
                    } else if (state
                        is AddOfferErrorOccuredWhileCreatingOffer) {
                      showSnack(context, orange,
                          "error occured while creating offer");
                    } else {
                      
                    }
                  },
                  builder: (context, state) {
                    return ButtonWidget(
                      width: width,
                      text: 'ADD OFFER',
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          if (image == '') {
                            showSnack(context, red, 'Add Banner');
                          } else {
                            MultipartFile imageFile =
                                await MultipartFile.fromFile(image);
                            final offer = OfferRequest(
                              image: imageFile,
                              categoryId: categoryId,

                              offerTitle: offerController.text,
                              offerPercentage:  int.parse(offerPerController.text),
                              status: 'ACTIVE',
                            );
                            // ignore: use_build_context_synchronously
                            context.read<OfferBloc>().add(AddOfferEvent(
                                  offerRequest: offer,
                                ));
                          }
                        }
                      },
                      height: height * 1.5 / 10,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
