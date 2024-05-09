import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/category/category_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/order/order_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/profile/profile_bloc.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';
import 'package:foodie_fly_restaurant/views/screens/add_dishes/screen_add_dishes.dart';
import 'package:foodie_fly_restaurant/views/screens/all_categories/screen_categories.dart';
import 'package:foodie_fly_restaurant/views/screens/category/screen_categories.dart';
import 'package:foodie_fly_restaurant/views/screens/home/widgets/appbar_widget.dart';
import 'package:foodie_fly_restaurant/views/screens/home/widgets/seller_sales_panal_widget.dart';
import 'package:foodie_fly_restaurant/views/screens/home/widgets/viewall_widget.dart';
import 'package:foodie_fly_restaurant/views/screens/order_details/order_details.dart';
import 'package:foodie_fly_restaurant/views/screens/orders/screen_orders.dart';
import 'package:intl/intl.dart';

import 'widgets/floating_action_btn.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    context.read<ProfileBloc>().add(GetProfileEvent());
    context.read<OrderBloc>().add(GetAllOrdersEvent());
    // context.read<SalesDailyBloc>().add(SalesDailyEvent());
    // context.read<SalesTotelBloc>().add(SalesTotelEvent());
    context.read<CategoryBloc>().add(CategoryEvent());
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(160),
              child: HomeAppBarWidget(width: width),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  kHight50,
                  kHight10,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ViewAllwidget(
                      text: "Recent Orders",
                      buttonName: "viewAll",
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ScreenOrders(),
                          ),
                        );
                      },
                    ),
                  ),
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      return state.orders.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              children: List.generate(
                                state.orders.length,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Card(
                                      shadowColor: grey,
                                      surfaceTintColor: grey,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.5,
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                title: Text(
                                                  'Order id: ${state.orders[index].orderId}',
                                                  style: regularGrey,
                                                ),
                                                subtitle: Text(
                                                  'Order Amount: ₹ ${state.orders[index].totalPrice - state.orders[index].deliveryCharge}\nDate: ${DateFormat('d MMMM yyyy').format(DateTime.parse(state.orders[index].orderDate))}',
                                                  style: regularGrey,
                                                ),
                                                trailing: CircleAvatar(
                                                  backgroundColor: Colors.grey
                                                      .withOpacity(0.3),
                                                  radius: 24,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ScreenOrderDetails(
                                                            order: state
                                                                .orders[index],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      CupertinoIcons
                                                          .chevron_forward,
                                                      size: 32,
                                                      fill: BorderSide
                                                          .strokeAlignCenter,
                                                    ),
                                                  ),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                    },
                  ),
                  kHight20,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ViewAllwidget(
                      text: "Categories",
                      buttonName: "View All",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ScreenAllCategories(),
                        ));
                      },
                    ),
                  ),
                  kHight20,
                  const HomeCategoryGridviews(),
                  kHight50,
                  kHight20,
                ],
              ),
            ),
          ),
          SellerSalesPanalWidget(width: width),
        ],
      ),
      floatingActionButton: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return FloatingActionBTN(
              string: 'Add Dish',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ScreenAddDishes(
                      categories: state.categories,
                      operatior: Operatior.add,
                    ),
                  ),
                );
              },
              icon: Icons.add);
        },
      ),
    );
  }
}
