
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/category/category_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/offer/offer_bloc.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';
import 'package:foodie_fly_restaurant/views/screens/add_offer/screen_add_offer.dart';
import 'package:foodie_fly_restaurant/views/screens/home/widgets/floating_action_btn.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/section_head.dart';
import 'package:intl/intl.dart';

class ScreenOffers extends StatelessWidget {
  const ScreenOffers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    context.read<OfferBloc>().add(GetOffersEvent());
    context.read<CategoryBloc>().add(CategoryEvent());

    return Scaffold(
      appBar: const  PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBarWidget(title: "Offers"),
      ),
      body: BlocBuilder<OfferBloc, OfferState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 7),
            child: state.offers.isEmpty
                ? const Center(
                    child: Column(
                    children: <Widget>[
                       CircularProgressIndicator(),
                       Divider(),
                      Text(' Empty', style: boldGrey),
                    ],
                  ))
                : ListView.builder(
                    itemCount: state.offers.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Stack(
                            children: <Widget>[
                              Container(
                                width: width,
                                height: height * .40,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[50],
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 2),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              Colors.black.withAlpha(7),
                                          radius: 36,
                                          child: Image.asset(
                                            'assets/icons/box.png',
                                            height: height * .071,
                                            width: width * 1.2 / 10,
                                            color: yellow,
                                          ),
                                        ),
                                        Container(
                                          width: width * 4.5 / 10,
                                          height: height * 2 / 10,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.grey.shade300,
                                                width: 2.5),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(
                                              state.offers[index].imageUrl,
                                              fit: BoxFit.cover,
                                              matchTextDirection: true,
                                              filterQuality: FilterQuality.high,
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 1,color: grey.withOpacity(0.5)),
                                            shape: BoxShape.circle
                                          ),
                                          child: CircleAvatar(
                                            radius: 36,
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.12),
                                            foregroundColor: black,
                                            child: Text(
                                              '${state.offers[index].offerPercentage}%',
                                              style: bigBoldGrey,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            SectionHead(
                                                heading: 'Title : ',
                                                values: state
                                                    .offers[index].offerTitle),
                                            BlocBuilder<CategoryBloc,
                                                CategoryState>(
                                              builder: (context, state) {
                                                return SectionHead(
                                                    heading: "Category : ",
                                                    values: state
                                                        .categories[index]
                                                        .name!);
                                              },
                                            ),
                                            SectionHead(
                                                heading: 'Started : ',
                                                values: state
                                                    .offers[index].startDate
                                                    .substring(0, 10)),
                                            SectionHead(
                                              heading: 'Will End : ',
                                              values: DateFormat('d MMMM yyyy')
                                                  .format(
                                                DateTime.parse(state
                                                    .offers[index].endDate),
                                              ),
                                            ),
                                            SectionHead(
                                                heading: 'Status : ',
                                                values: state
                                                    .offers[index].status
                                                    .substring(0, 6)),
                                          ],
                                        ),
                                        // Column(
                                        //   children: <Widget>[
                                        //     CircleAvatar(
                                              
                                        //       backgroundColor:
                                        //           Colors.grey.withAlpha(7),
                                        //       radius: 25,
                                        //       child: CircleAvatar(
                                        //         backgroundColor: Colors.grey
                                        //             .withOpacity(0.09),
                                        //         child: const Icon(
                                        //           CupertinoIcons
                                        //               .eyedropper_halffull,
                                        //           size: 22,color: grey,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     const Divider(),
                                        //     CircleAvatar(
                                              
                                        //       backgroundColor:
                                        //           Colors.grey.withAlpha(7),
                                        //       radius: 25,
                                        //       child: CircleAvatar(
                                        //         backgroundColor: Colors.grey
                                        //             .withOpacity(0.09),
                                        //         child: const Icon(
                                        //           CupertinoIcons.delete,
                                        //           size: 25,color: grey,
                                        //         ),
                                        //       ),
                                        //     )
                                        //   ],
                                        // )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          kHight10,
                          Divider(thickness: 2,color: Colors.grey.shade300,),
                          kHight10,
                        ],
                      );
                    },
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionBTN(
        icon: Icons.add,
        string: 'Add Offer',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ScreenAddOffer(),
            ),
          );
        },
      ),
    );
  }
}
