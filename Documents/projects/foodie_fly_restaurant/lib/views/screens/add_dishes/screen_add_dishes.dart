// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/api_tokens/tokens.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/dish/dish_bloc.dart';
import 'package:foodie_fly_restaurant/models/category.dart';
import 'package:foodie_fly_restaurant/models/dish.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';
import 'package:foodie_fly_restaurant/views/screens/add_dishes/widgets/pick_image.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/button_widget.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/text_field_widget.dart';
import 'package:foodie_fly_restaurant/views/widgets/function_widgets/drop_down.dart';
import 'package:foodie_fly_restaurant/views/widgets/function_widgets/snackbar_function.dart';
import 'package:image_picker/image_picker.dart';

enum Operatior {
  add,
  edit,
}

// ignore: must_be_immutable
class ScreenAddDishes extends StatefulWidget {
  ScreenAddDishes(
      {super.key,
      required this.categories,
      this.dishModel,
      required this.operatior});
  Operatior operatior;
  DishModel? dishModel;
  final List<Category> categories;

  @override
  State<ScreenAddDishes> createState() => _ScreenAddDishesState();
}

class _ScreenAddDishesState extends State<ScreenAddDishes> {
  initTextControllers() {
    if (widget.dishModel != null) {
      dishController.text = widget.dishModel!.name!;
      descriptionController.text = widget.dishModel!.description!;
      priceController.text = widget.dishModel!.price.toString();
      quantityController.text = widget.dishModel!.quantity.toString();
      isVeg = widget.dishModel!.isVeg!;
      isAvailable = widget.dishModel!.isAvailable!;
      image = widget.dishModel!.image!;
      categoryId = widget.dishModel!.categoryId!;
      sellerId = widget.dishModel!.sellerId!;
    }
  }

  final formKey = GlobalKey<FormState>();

  final dishController = TextEditingController();

  final descriptionController = TextEditingController();

  final priceController = TextEditingController();

  final quantityController = TextEditingController();

  bool isVeg = false;

  bool isAvailable = false;

  int categoryId = 0;

  int sellerId = 0;

  XFile? imagePath;

  String image = '';
  @override
  void initState() {
    if (widget.operatior == Operatior.edit) {
      initTextControllers();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBarWidget(
          title: widget.operatior == Operatior.add
              ? "Add New Dish"
              : "Update Dish",
        ),
      ),
      body: BlocBuilder<DishBloc, DishState>(
        builder: (context, state) {
          return state is AddNewDishState
              ? const Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      kHight10,
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "pls wait",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
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
                                width: widthSize,
                                height: heightSize * .3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.shade300),
                                child: (widget.operatior == Operatior.add)
                                    ? image != ''
                                        ? Image.file(File(image))
                                        : const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add_a_photo,
                                                size: 70,
                                                color: yellow,
                                              ),
                                              Text(
                                                "Add Image",
                                                style: boldGrey,
                                              ),
                                            ],
                                          )
                                    : image != ''
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(
                                              image,
                                              filterQuality: FilterQuality.high,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : null),
                          ),
                          kHight10,
                          TextFieldWidget(
                            userController: dishController,
                            label: 'Dish Name: ',
                            inputType: TextInputType.name,
                            obscureText: false,
                            validator: (value) {
                              if (value!.isEmpty) return 'Enter the dish name';
                              return null;
                            },
                          ),
                          kHight10,
                          TextFieldWidget(
                            userController: descriptionController,
                            label: 'Description: ',
                            inputType: TextInputType.name,
                            obscureText: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter the description';
                              }
                              return null;
                            },
                          ),
                          kHight10,
                          TextFieldWidget(
                            userController: priceController,
                            label: 'Price: ',
                            inputType: TextInputType.name,
                            obscureText: false,
                            validator: (value) {
                              if (value!.isEmpty) return 'Enter the price';
                              return null;
                            },
                          ),
                          kHight10,
                          TextFieldWidget(
                            userController: quantityController,
                            label: 'Quantity: ',
                            inputType: TextInputType.name,
                            obscureText: false,
                            validator: (value) {
                              if (value!.isEmpty) return 'Enter the quantity';
                              return null;
                            },
                          ),
                          kHight10,
                          BlocBuilder<DishBloc, DishState>(
                            buildWhen: (previous, current) =>
                                current is AddCategoryState,
                            builder: (context, state) {
                              categoryId = state is AddCategoryState
                                  ? state.categoryId
                                  : 0;
                              return DropDownWidget(
                                categories: widget.categories,
                                title: 'Categoroy',
                                operation: widget.operatior,
                                dish: widget.operatior == Operatior.add
                                    ? null
                                    : widget.dishModel,
                              );
                            },
                          ),
                          kHight10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '  Vegetarian: ',
                                style: semiBoldBlack,
                              ),
                              BlocBuilder<DishBloc, DishState>(
                                builder: (context, state) {
                                  return Switch(
                                    focusColor: red,
                                    hoverColor: green,
                                    inactiveTrackColor: white,
                                    activeColor: yellow,
                                    inactiveThumbColor: grey,
                                    value: state is AddVegState
                                        ? state.isVeg
                                        : isVeg,
                                    onChanged: (value) {
                                      context.read<DishBloc>().add(
                                            AddVegEvent(isVeg: value),
                                          );
                                      isVeg = value;
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                          kHight10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '  Available: ',
                                style: semiBoldBlack,
                              ),
                              BlocBuilder<DishBloc, DishState>(
                                buildWhen: (previous, current) =>
                                    current is AddAvailState,
                                builder: (context, state) {
                                  return Switch(
                                    activeColor: yellow,
                                    inactiveThumbColor: grey,
                                    inactiveTrackColor: white,
                                    value: state is AddAvailState
                                        ? state.isAvail
                                        : isAvailable,
                                    onChanged: (value) {
                                      context.read<DishBloc>().add(
                                            AddAvailableEvent(isAvail: value),
                                          );
                                      isAvailable = value;
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                          kHight10,
                          ButtonWidget(
                            width: widthSize,
                            height: heightSize * 1.5 / 10,
                            text: widget.operatior == Operatior.add
                                ? "ADD DISH"
                                : "UPDATE DISH",
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                if (image == '') {
                                  showSnack(
                                      context, amber, 'Image is mandatory');
                                } else {
                                  if (widget.operatior == Operatior.add) {
                                    int sellerId = await getSellerId();

                                    MultipartFile imageFile =
                                        await MultipartFile.fromFile(image);
                                    Dish dish = Dish(
                                      dishId: 0,
                                      sellerId: sellerId,
                                      name: dishController.text,
                                      description: descriptionController.text,
                                      price: int.parse(priceController.text),
                                      image: imageFile,
                                      quantity:
                                          int.parse(quantityController.text),
                                      categoryId: categoryId,
                                      isVeg: isVeg,
                                      isAvailable: isAvailable,
                                    );
                                    
                                    context.read<DishBloc>().add(
                                        
                                        AddNewDishEvent(
                                            
                                            dish: dish,
                                            context: context));
                                  } else {
                                    DishModel dishModel = DishModel(
                                      dishId: widget.dishModel!.dishId!,
                                      sellerId: sellerId,
                                      name: dishController.text,
                                      description: descriptionController.text,
                                      price: int.parse(priceController.text),
                                      image: image != ''
                                          ? image
                                          : widget.dishModel!.image,
                                      quantity:
                                          int.parse(quantityController.text),
                                      categoryId: categoryId,
                                      isVeg: isVeg,
                                      isAvailable: isAvailable,
                                    );
                                    context.read<DishBloc>().add(
                                        UpdateDishEvent(
                                            dishModel: dishModel,
                                            context: context));
                                  }
                                }
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
