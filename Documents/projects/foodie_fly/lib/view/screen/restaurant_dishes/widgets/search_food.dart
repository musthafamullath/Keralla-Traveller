import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/dish/dish_bloc.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, required this.text, required this.sellerId});
  final String text;
  final int sellerId;
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('$sellerId this is seller id');
    return CupertinoSearchTextField(
      padding: const EdgeInsets.all(12),
      placeholder: text,
      backgroundColor: Colors.green[100],
      prefixIcon: Icon(CupertinoIcons.search, color: Colors.green[700]),
      suffixIcon:
          Icon(CupertinoIcons.xmark_circle_fill, color: Colors.green[700]),
      style: TextStyle(color: Colors.green[700]),
      onChanged: (value) async {
        context
            .read<DishBloc>()
            .add(SearchDishEvent(query: value, sellerId: sellerId));
        
      },
    );
  }
}
