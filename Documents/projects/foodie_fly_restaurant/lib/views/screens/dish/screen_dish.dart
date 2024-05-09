import 'package:flutter/material.dart';
import 'package:foodie_fly_restaurant/models/dish.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/section_head.dart';

class ScreenDish extends StatelessWidget {
  const ScreenDish({super.key, required this.dish});
  final DishModel? dish;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBarWidget(
          title: dish!.name!,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                kHight20,
                Container(
                  width: width,
                  height: height * .35,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: yellow),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        filterQuality: FilterQuality.high,
                        image: dish!.image == ''
                            ? const AssetImage(
                                    'assets/images/categories/dish.jpg')
                                as ImageProvider
                            : NetworkImage(dish!.image!.toString()),
                        fit: BoxFit.cover),
                  ),
                ),
                kHight10,
                Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      children: [
                        const Text(
                          "Dish Details",
                          style: bigBoldBlack,
                          textAlign: TextAlign.start,
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey.shade300,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionHead(
                                heading: "Item: ",
                                values: dish!.name!,
                              ),
                              SectionHead(
                                heading: "Discription: ",
                                values: dish!.description!,
                              ),
                              SectionHead(
                                heading: 'Price ₹:  ',
                                values: dish!.price.toString(),
                              ),
                              SectionHead(
                                heading: 'Quantity: ',
                                values: dish!.quantity.toString(),
                              ),
                              SectionHead(
                                heading: 'Veg: ',
                                values: dish!.isVeg.toString(),
                              ),
                              SectionHead(
                                heading: 'Availability: ',
                                values: dish!.isAvailable.toString(),
                              ),
                              SectionHead(
                                heading: "Seller d: ",
                                values: dish!.sellerId.toString(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
