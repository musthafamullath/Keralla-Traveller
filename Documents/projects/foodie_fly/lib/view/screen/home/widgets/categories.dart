import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:foodie_fly/controller/blocs/category/category_bloc.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/screen/category/screen_category.dart';

import 'shimmers/six_category_shimmer_widget.dart';

class CategoriesGridview extends StatelessWidget {
  const CategoriesGridview({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    context.read<CategoryBloc>().add(GetAllCategoriesEvent());
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.isLoading) {
          return CategoryShimmer(height: height, width: width);
        }

        if (state.categories.isEmpty) {
         return CategoryShimmer(height: height, width: width);
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenCategory(
                      category: state.categories[index],
                    ),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    state.categories[index].iconUrl,
                    height: height * .8 / 10,
                  ),
                  Text(
                    state.categories[index].name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: grey,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}




