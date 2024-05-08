import 'package:flutter/material.dart';
import 'package:foodie_fly/model/dish.dart';
import 'package:foodie_fly/utils/constants.dart';

class DishContainer extends StatelessWidget {
  const DishContainer(
      {super.key,
      required this.width,
      required this.height,
      required this.dish});

  final double width;
  final double height;
  final Dish dish;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(6),
      width: width - (width * .8),
     
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: yellowGreen),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: height * .15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: yellowGreen),
                  image: DecorationImage(
                    image: dish.imageUrl == ''
                        ? const AssetImage('assets/images/categories/dish.jpg')
                            as ImageProvider
                        : NetworkImage(dish.imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          kHight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(dish.name), Text('₹ ${dish.price}')],
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade300,
                child: IconButton(
                  onPressed: () async {},
                  icon: const Icon(
                    Icons.favorite,
                    size: 22,
                    color: yellowGreen,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
