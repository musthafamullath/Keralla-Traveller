import 'package:flutter/material.dart';
import 'package:foodie_fly/model/dish.dart';
import 'package:foodie_fly/model/seller.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/dish_detatils/widget/Restaurant_banner.dart';
import 'package:foodie_fly/view/screen/dish_detatils/widget/add_to_cart.dart';
import 'package:foodie_fly/view/screen/dish_detatils/widget/image_container.dart';
import 'package:foodie_fly/view/screen/home/widgets/section_head.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';

class ScreenDishDetails extends StatelessWidget {
  const ScreenDishDetails(
      {super.key, required this.dish, required this.seller});
  final Dish dish;
  final Seller seller;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBarWidget(title: dish.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 7.5, right: 7.5,bottom: 7.5),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageContainer(width: width, height: height, dish: dish),
                    kHight10,
                    Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 7.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SectionHead(heading: dish.name),
                          Text(
                            '₹ ${dish.price}',
                            style: semiBoldGreen,
                          )
                        ],
                      ),
                    ),
                    kHight10,
                    Padding(
                      padding: const EdgeInsets.only(left: 7.5),
                      child: RestaurantBanner(seller: seller),
                    ),
                    kHight10,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.5),
                      child: Text(
                        dish.description,
                        style: semiBoldGrey,
                      ),
                    ),
                  ],
                ),
                kHight20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.5,vertical: 7.5),
                  child: AddToCartButton(
                    width: width,
                    height: height,
                    dish: dish,
                  ),
                ),
                  kHight30,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
