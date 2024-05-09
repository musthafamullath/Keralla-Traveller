import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/sales_report/sales_report_bloc.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';

class SellerSalesPanalWidget extends StatelessWidget {
  const SellerSalesPanalWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    context.read<SalesReportBloc>().add(GetDailySalesReportEvent());
    return Positioned(
      top: 110,
      left: 33,
      child: Container(
        width: width * 8.5 / 10,
        height: width * 3 / 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: white,
          border: Border.all(
            width: 1.5,
            color: black,
          ),
        ),
        child: BlocBuilder<SalesReportBloc, SalesReportState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * 3 / 10,
                  height: 100 / 01,
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: yellow,
                        border: Border.all(
                            width: 1, color:black),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Text(
                            "Today's Orders",
                            style: semiBoldBlack,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.yellow.shade300,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            '${state.report?.saleCount}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                 
                  width: width *5 / 10,
                  height: 100 / 01,
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: black),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Text(
                            "Today's revenue",
                            style: semiBoldBlack,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.yellow.shade300,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            '₹ ${state.report?.totalSales.round()}.00',
                            style: const TextStyle(
                              fontSize: 20,
                              color: black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
