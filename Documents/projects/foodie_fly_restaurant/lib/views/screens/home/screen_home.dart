import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/category/category_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/order/order_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/profile/profile_bloc.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/views/screens/add_dishes/screen_add_dishes.dart';
import 'package:foodie_fly_restaurant/views/screens/all_categories/screen_categories.dart';
import 'package:foodie_fly_restaurant/views/screens/category/screen_categories.dart';
import 'package:foodie_fly_restaurant/views/screens/home/widgets/appbar_widget.dart';
import 'package:foodie_fly_restaurant/views/screens/home/widgets/recent_order_widget.dart';
import 'package:foodie_fly_restaurant/views/screens/home/widgets/seller_sales_panal_widget.dart';
import 'package:foodie_fly_restaurant/views/screens/home/widgets/viewall_widget.dart';
import 'package:foodie_fly_restaurant/views/screens/orders/screen_orders.dart';

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
    final height = MediaQuery.of(context).size.height;
    context.read<ProfileBloc>().add(GetProfileEvent());
    context.read<OrderBloc>().add(GetAllOrdersEvent());
    context.read<CategoryBloc>().add(FetchCategories());
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
                  RecentOrders(height: height, width: width),
                  // kHight20,
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
                  // kHight20,
                  const HomeCategoryGridviews(),
                  kHight50,
                  // kHight20,
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
