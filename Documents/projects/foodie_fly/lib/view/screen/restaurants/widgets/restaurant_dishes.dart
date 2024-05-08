import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/dish/dish_bloc.dart';
import 'package:foodie_fly/model/seller.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/dish_detatils/screen_dish_details.dart';
import 'package:foodie_fly/view/screen/home/widgets/section_head.dart';
import 'package:foodie_fly/view/screen/restaurants/widgets/search_text_field.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';

class ScreenRestaurantDishes extends StatelessWidget {
  const ScreenRestaurantDishes({super.key, required this.seller});
  final Seller seller;
  @override
  Widget build(BuildContext context) {
    context.read<DishBloc>().add(GetDishBySeller(sellerId: seller.id));
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBarWidget(title: seller.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SearchTextFieldForFood(
                  text: 'Search Foods...', sellerId: seller.id),
              kHight10,
              const SectionHead(heading: 'All Dishes'),
              BlocBuilder<DishBloc, DishState>(
                builder: (context, state) {
                  return state.dishes.isEmpty
                      ? const Center(
                          child: Column(
                            children: <Widget>[
                              CircularProgressIndicator(),
                              Text(
                                "Please wait",
                                style: semiBoldBlack,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.dishes.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ScreenDishDetails(
                                        dish: state.dishes[index], 
                                        seller: seller),
                                  ),
                                );
                              },
                              child: Container(
                                
                                width: width * .8,
                                height: height * .2,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300,width:2),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      width: width * .3,
                                      height: height * .2,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              state.dishes[index].name,
                                              style: semiBoldBlack,
                                              overflow: TextOverflow.fade,
                                            ),
                                            Text(
                                              '₹ ${state.dishes[index].price}',
                                              style: semiBoldGreen,
                                            ),
                                            Text(
                                              'Only ${state.dishes[index].quantity}s left',
                                              style: semiBoldGrey,
                                              overflow: TextOverflow.fade,
                                            ),
                                            Text(
                                              state.dishes[index].isVeg
                                                  ? 'Vegetarian'
                                                  : 'Non-Veg',
                                              style: semiBoldGrey,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: width * .50,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: white, width: 5),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                state.dishes[index].imageUrl,
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
