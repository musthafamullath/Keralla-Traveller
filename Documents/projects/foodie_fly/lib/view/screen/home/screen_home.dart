import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodie_fly/controller/blocs/offer/offer_bloc.dart';
import 'package:foodie_fly/controller/blocs/profile/profile_bloc.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/home/widgets/categories.dart';
import 'package:foodie_fly/view/screen/home/widgets/header.dart';
import 'package:foodie_fly/view/screen/home/widgets/screen_all_categories.dart';
import 'package:foodie_fly/view/screen/home/widgets/screen_dishes.dart';
import 'package:foodie_fly/view/screen/home/widgets/view_all_widget.dart';
import 'package:foodie_fly/view/screen/offer_details/screen_offer.dart';
import 'package:foodie_fly/view/widgets/class_widgets/search_text_field.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    context.read<OfferBloc>().add(GetAllOfferEvent());
    context.read<ProfileBloc>().add(GetProfileEvent());

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Header(width: width, height: height)),
      body: SafeArea(
        child: ListView(
          children: [
            kHight10,
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SearchTextField(text: 'Search restaurants...'),
                    kHight10,
                    ViewAllwidget(
                      text: "Categories",
                      buttonName: "View All",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ScreenAllCategories(),
                        ));
                      },
                    ),
                    kHight10,
                    CategoriesGridview(height: height, width: width),
                    BlocBuilder<OfferBloc, OfferState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Offers",
                              style: semiBoldBlack,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ScreenDishes(
                                        height: height,
                                        width: width,
                                        offer: state.offers),
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade50),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'View All',
                                      style: regularBlack,
                                    ),
                                  ),
                                ))
                          ],
                        );
                      },
                    ),
                    BlocBuilder<OfferBloc, OfferState>(
                      builder: (context, state) {
                        return state.offers.isEmpty
                            ? const Center(
                                child: SpinKitWave(color: yellowGreen,size: 50,)
                              )
                            : ScreenOffer(
                                height: height,
                                width: width,
                                offers: state.offers,
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
