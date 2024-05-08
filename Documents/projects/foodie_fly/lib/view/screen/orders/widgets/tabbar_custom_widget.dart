
import 'package:flutter/material.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/orders/widgets/tabbar_text_widget.dart';


class TabBarWidgetCustom extends StatelessWidget {
  const TabBarWidgetCustom({
    super.key, required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration:  BoxDecoration(
        boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              spreadRadius: 5,
              offset: const Offset(0.5, 0.5),
            )
        ],
          color: yellowGreen,
          border:const BorderDirectional(
            bottom: BorderSide(
              color: yellowGreen,
              width: 20,
            ),
          ),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: AppBar(
        backgroundColor: yellowGreen,
        title: const Padding(
          padding:  EdgeInsets.only(top: 10),
          child:  Text('Orders', style: bigBoldWhite),
        ),
        centerTitle: true,
        bottom: const TabBar(
          labelColor: white,
          unselectedLabelColor: black,
          indicatorWeight: 5,
          indicatorColor: white,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TabBarWidget(
                text: 'All Orders',
              ),
            ),
            TabBarWidget(
              text: 'Delivered',
            ),
           
            TabBarWidget(
              text: 'Pending',
            ),
          ],
        ),
      ),
    );
  }
}
