import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/category/category_bloc.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/views/screens/category/widget/action_screen_category.dart';

class HomeCategoryGridviews extends StatelessWidget {
  const HomeCategoryGridviews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    context.read<CategoryBloc>().add(CategoryEvent());
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return GridView.builder(
          itemCount: 6,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            if (state.categories.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return InkWell(
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ActionScreenCategory(
                      category: state.categories[index],
                    ),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 0.9,color: grey.withOpacity(0.5))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      index < 6 ? state.categories[index].iconUrl! : '',
                      height: heightSize * 1 / 10, filterQuality: FilterQuality.high,fit: BoxFit.fill,
                    ),
                    Text(
                      index < 6 ? state.categories[index].name! : '',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: grey),
                    ),
                    kHight10,
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
