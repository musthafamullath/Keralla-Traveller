import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/category/category_bloc.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/screen/category/screen_category.dart';

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
    context.read<CategoryBloc>().add(CategoryEvent());
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state.categories.isEmpty) {
            return const CircularProgressIndicator();
          }
          return GridView.builder(
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ScreenCategory(category: state.categories[index]),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 2, color: Colors.grey.withOpacity(0.5))),
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
                            color: grey),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
