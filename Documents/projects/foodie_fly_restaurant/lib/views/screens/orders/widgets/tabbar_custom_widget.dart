import 'package:flutter/material.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';
import 'package:foodie_fly_restaurant/views/screens/orders/widgets/tabbar_text_widget.dart';

class TabBarWidgetCustom extends StatelessWidget {
  const TabBarWidgetCustom({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              spreadRadius: 5,
              offset: const Offset(0.5, 0.5),
            )
          ],
          color: yellow,
          border:const BorderDirectional(
            bottom: BorderSide(
              color: yellow,
              width: 20,
            ),
          ),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: AppBar(
        backgroundColor: yellow,
        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text('Orders', style: bigBoldBlack),
        ),
        centerTitle: true,
        bottom: const TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
          indicatorWeight: 6,
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: TabBarWidget(
                text: 'Orders',
              ),
            ),
            TabBarWidget(
              text: 'Cooking',
            ),
            TabBarWidget(
              text: 'Ready',
            ),
            TabBarWidget(
              text: 'Delivered',
            ),
          ],
        ),
      ),
    );
  }
}
