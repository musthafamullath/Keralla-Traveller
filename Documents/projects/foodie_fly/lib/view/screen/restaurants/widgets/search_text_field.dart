import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/dish/dish_bloc.dart';
import 'package:foodie_fly/utils/constants.dart';

class SearchTextFieldForFood extends StatelessWidget {
  const SearchTextFieldForFood({
    super.key,
    required this.text,
    required this.sellerId,
  });
  final String text;
  final int sellerId;
  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      padding: const EdgeInsets.all(15),
      placeholder: text,
      placeholderStyle: const TextStyle(color: white),
      backgroundColor: Colors.green.shade50,
      prefixIcon: const Padding(
        padding:  EdgeInsets.only(left: 10),
        child: Icon(
          CupertinoIcons.search,
          color: kGreen,
          size: 32,
        ),
      ),
      suffixIcon:
         const Icon(CupertinoIcons.xmark_circle_fill, ),
      style: const TextStyle(color: white, fontSize: 20),
      onChanged: (value) async {
        context.read<DishBloc>().add(
              SearchDishEvent(
                query: value,
                sellerId: sellerId,
              ),
            );
      },
    );
  }
}
