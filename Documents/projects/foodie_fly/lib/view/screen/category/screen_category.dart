import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/dish/dish_bloc.dart';
import 'package:foodie_fly/model/category.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/category/widgets/dish_container.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';

// ignore: must_be_immutable
class ScreenCategory extends StatelessWidget {
  ScreenCategory({super.key, required this.category});
  Category category;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    context.read<DishBloc>().add(GetDishByCategory(categoryId: category.id));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBarWidget(title: category.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<DishBloc, DishState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return state.dishes.isEmpty
                ? Center(
                   child: Text.rich(TextSpan(children: [
                            const TextSpan(
                                text: 'The Category: ', style: boldBlack),
                            TextSpan(
                                text: category.name, style: boldGreenGrey),
                            const TextSpan(text: ' is Empty', style: boldBlack),
                          ])),
                  )
                : GridView.builder(
                    itemCount: state.dishes.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: width / height / .53),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                        
                        },
                        child: DishContainer(
                          width: width,
                          height: height,
                          dish: state.dishes[index],
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
