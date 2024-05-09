
import 'package:flutter/material.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';


class FloatingActionBTN extends StatelessWidget {
  const FloatingActionBTN({
    super.key, required this.icon, required this.string,required this.onPressed,
  });
  final IconData icon;
  final String string;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
           splashColor: grey,
            backgroundColor: white,
            
            onPressed:onPressed,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon),
                Text(string,style:const TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)
              ],
            )
          );
  }
}
