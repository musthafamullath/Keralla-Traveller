// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/category/category_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/offer/offer_bloc.dart';
import 'package:foodie_fly_restaurant/models/category.dart';
import 'package:foodie_fly_restaurant/models/offer.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';
import 'package:foodie_fly_restaurant/views/screens/add_dishes/widgets/pick_image.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/button_widget.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/text_field_widget.dart';
import 'package:foodie_fly_restaurant/views/widgets/function_widgets/snackbar_function.dart';
import 'package:image_picker/image_picker.dart';

enum OperatiorOff {
  add,
  edit,
}

class ScreenAddOffer extends StatefulWidget {
  ScreenAddOffer({
    super.key,
    required this.operatior,
    this.offer,
    required this.categories,
  });

  OperatiorOff operatior;
  Offer? offer;
  final List<Category> categories;

  @override
  State<ScreenAddOffer> createState() => _ScreenAddOfferState();
}

class _ScreenAddOfferState extends State<ScreenAddOffer> {
  initTextOfferControllers() {
    if (widget.offer != null) {
      offerController.text = widget.offer!.offerTitle;
      offerPerController.text = widget.offer!.offerPercentage.toString();
      categoryId = widget.offer!.categoryId;
    }
  }

  final formkey = GlobalKey<FormState>();

  final offerController = TextEditingController();

  final offerPerController = TextEditingController();

  final List<Category> categories = [];

  int categoryId = 0;

  XFile? imagePath;

  String image = '';

  @override
  void initState() {
    if (widget.operatior == OperatiorOff.edit) {
      initTextOfferControllers();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBarWidget(
          title: widget.operatior == OperatiorOff.add
              ? "Add New Offer"
              : "Update Offer",
        ),
      ),
      body: BlocBuilder<OfferBloc, OfferState>(
        builder: (context, state) {
          if (state is OfferLoading) {
            return const Center(
              child: SpinKitFadingGrid(color: yellow, size: 50),
            );
          } else if (state is OfferLoaded) {
            if (state.offers.isEmpty) {
              return const Center(
                child: Text("Offer is Empty"),
              );
            } else {
              return SingleChildScrollView(
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
                              setState(() {
                                image = imagePath!.path;
                              });
                            }
                          },
                          child: Container(
                            width: width,
                            height: height * .3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade200),
                            child: image != ''
                                ? Image.file(File(image))
                                : const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_a_photo,
                                        size: 70,
                                        color: yellow,
                                      ),
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
                          label:  "Offer item's Name:",
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
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10)),
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
                                    label: Text(state.categories.isNotEmpty
                                        ? state.categories
                                            .firstWhere(
                                                (cat) => cat.id == categoryId,
                                                orElse: () =>
                                                    state.categories[0])
                                            .name
                                        : 'Choose Category'),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 10),
                                    border: InputBorder.none),
                                items: state.categories.map((cat) {
                                  return DropdownMenuItem(
                                    value: cat,
                                    child: Text(cat.name),
                                  );
                                }).toList(),
                                onChanged: (value) async {
                                  categoryId = value!.id;
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
                        ButtonWidget(
                          width: width,
                          text: widget.operatior == OperatiorOff.add
                              ? 'ADD OFFER'
                              : 'UPDATE OFFER',
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              if (image == '') {
                                showSnack(context, red, 'Add Banner');
                              } else {
                                if (widget.operatior == OperatiorOff.add) {
                                  MultipartFile imageFile =
                                      await MultipartFile.fromFile(image);
                                  OfferRequest offer = OfferRequest(
                                    image: imageFile,
                                    categoryId: categoryId,
                                    offerTitle: offerController.text,
                                    offerPercentage:
                                        int.parse(offerPerController.text),
                                    status: 'ACTIVE',
                                  );
                                  context.read<OfferBloc>().add(AddOfferEvent(
                                      offer: offer, context: context));
                                } else {
                                  Offer offer = Offer(
                                    offerId: widget.offer!.offerId,
                                    offerTitle: widget.offer!.offerTitle,
                                    sellerId: 0,
                                    categoryId: categoryId,
                                    imageUrl: image != ''
                                        ? image
                                        : widget.offer!.imageUrl,
                                    offerPercentage:
                                        widget.offer!.offerPercentage,
                                    status: "ACTIVE",
                                  );
                                  context.read<OfferBloc>().add(
                                      UpdateOfferEvent(
                                          offer: offer, context: context));
                                }
                              }
                            }
                          },
                          height: height * 1.5 / 10,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}
