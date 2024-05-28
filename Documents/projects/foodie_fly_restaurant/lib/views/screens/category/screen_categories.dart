import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/category/category_bloc.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/views/screens/category/widget/action_screen_category.dart';

class HomeCategoryGridviews extends StatelessWidget {
  const HomeCategoryGridviews({super.key});

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;
    context.read<CategoryBloc>().add(FetchCategories());

    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(left: 10, right: 20),
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          height: heightSize * 3.5 / 10,
          width: widthSize * 1,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: state.categories.isEmpty
              ? const Center(
                  child: SpinKitFadingCircle(
                    color: yellow,
                    size: 50.0, 
                  ),
                )
              : GridView.builder(
                  itemCount: state.categories.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return state.categories[index].iconUrl.isEmpty
                                  ? const SpinKitFadingCircle(
                                      color: yellow, size: 20)
                                  :
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ActionScreenCategory(
                              category: state.categories[index],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0.5, vertical: 0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  width: 0.9, color: grey.withOpacity(0.5))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               Image.network(
                                      state.categories[index].iconUrl,
                                      height: heightSize * 0.8 / 10,
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.fill,
                                    ),
                              Text(
                                state.categories[index].name,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: grey),
                              ),
                              kHight10,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
