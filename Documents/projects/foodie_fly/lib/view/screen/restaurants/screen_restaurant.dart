import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodie_fly/controller/blocs/restaurant/restaurant_bloc.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/home/widgets/section_head.dart';
import 'package:foodie_fly/view/screen/restaurants/widgets/restaurant_dishes.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/search_text_field.dart';

class ScreenRestaurants extends StatelessWidget {
  const ScreenRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RestaurantBloc>().add(RestaurantEvent());
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBarWidget(title: "Restaurants"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,),
          child: BlocBuilder<RestaurantBloc, RestaurantState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  kHight10,
                  const SearchTextField(text: "Search restaurants..."),
                  kHight10,
                  state.restaurants.isEmpty
                      ? const Padding(
                        padding:  EdgeInsets.only(top: 250),
                        child:  Center(
                            child: Column(
                              children: <Widget>[
                                SpinKitCubeGrid(color: yellowGreen,size: 50,),
                                Text(
                                  "Please wait",
                                  style: semiBoldBlack,
                                ),
                              ],
                            ),
                          ),
                      )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SectionHead(heading: "All Restaurants"),
                            kHight10,
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.restaurants.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ScreenRestaurantDishes(
                                          seller: state.restaurants[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    height: height * .15,
                                  
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade300),
                                        color: Colors.grey.shade200,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 2,
                                            spreadRadius: 1,
                                            blurStyle: BlurStyle.outer,
                                            color: yellowGreen,
                                          )
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: <Widget>[
                                          kWidth10,
                                          Container(
                                            decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.grey.shade50),
                                                      shape: BoxShape.circle,),
                                            child: CircleAvatar(
                                              radius: 50,
                                              backgroundColor: Colors.grey.shade300,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Stack(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(7.5),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 3,
                                                              color:
                                                                  Colors.grey.shade200),
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: Container(
                                                          margin: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 10,
                                                              vertical: 10),
                                                          height: height * .112,
                                                          width: width * .225,
                                                          decoration:const BoxDecoration(
                                                            image: DecorationImage(
                                                              image: AssetImage(
                                                                'assets/icons/restaurant.png',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    FadeInLeftBig(
                                                      delay:const Duration(microseconds: 500),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 2,
                                                              color: yellowGreen.withOpacity(0.9)),
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: CircleAvatar(
                                                          radius: 16,
                                                          backgroundColor:
                                                              yellowGreen.withOpacity(0.7),
                                                          child: Text(
                                                            state.restaurants[index]
                                                                .name
                                                                .substring(0, 1)
                                                                .toUpperCase(),
                                                            style:const TextStyle(
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 22,
                                                                color: white),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          kWidth10,
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                state.restaurants[index].name,
                                                style: semiBoldBlack,
                                              ),
                                              Text(
                                                state.restaurants[index]
                                                    .description,
                                                style: regularGrey,
                                              ),
                                            ],
                                          ),
                                          kWidth10,
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
