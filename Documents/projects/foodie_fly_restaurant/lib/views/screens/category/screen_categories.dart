import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/category/category_bloc.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';
import 'package:foodie_fly_restaurant/views/screens/category/widget/action_screen_category.dart';

class HomeCategoryGridviews extends StatelessWidget {
  const HomeCategoryGridviews({super.key});

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    context.read<CategoryBloc>().add(FetchCategories());

    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: SpinKitFadingCircle(
              color: yellow,
              size: 50.0,
            ),
          );
        }
        final categoriesToShow = state.categories.take(6).toList();
        return state.categories.isEmpty
            ? const Center(
                child: Text(
                  "No Categories Available",
                  style: semiBoldGrey,
                ),
              )
            : GridView.builder(
                itemCount: categoriesToShow.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    ),
                itemBuilder: (context, index) {
                  return state.categories[index].iconUrl.isEmpty
                      ? const SpinKitFadingCircle(color: yellow, size: 20)
                      : InkWell(
                          onTap: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ActionScreenCategory(
                                  category: state.categories[index],
                                ),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                state.categories[index].iconUrl,
                                height: heightSize * 1 / 10,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.fill,
                              ),
                              Text(
                                state.categories[index].name,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: grey),
                              ),
                              kHight20,
                            ],
                          ),
                        );
                },
              );
      },
    );
  }
}
