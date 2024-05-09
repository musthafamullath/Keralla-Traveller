
import 'package:flutter/material.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

SalomonBottomBarItem salomonbottombaritem(ImageIcon imageIcon,String  text,) {
    return SalomonBottomBarItem(
      icon: imageIcon,
      title:  Text(
        text,
        style:const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      selectedColor: yellow,
      unselectedColor: Colors.grey.shade100,
    );
  }