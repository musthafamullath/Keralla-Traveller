import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/restaurant/restaurant_bloc.dart';
import 'package:foodie_fly/utils/constants.dart';


class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: CupertinoSearchTextField(
        padding: const EdgeInsets.all(15),
        placeholder: text,
        placeholderStyle: const TextStyle(color: white),
        backgroundColor: Colors.grey.shade300,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(CupertinoIcons.search, color: greenPointShade800,size: 32,),
        ),
        suffixIcon:
            Icon(CupertinoIcons.xmark_circle_fill, color: greenPointShade800),
        style: TextStyle(color: greenPointShade800,fontSize: 20),
        onChanged: (value) async {
          context.read<RestaurantBloc>().add(SearchRestaurantEvent(query: value));
        },
      ),
    );
  }
}
