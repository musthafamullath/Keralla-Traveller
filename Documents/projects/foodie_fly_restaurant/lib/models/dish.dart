import 'package:dio/dio.dart';

class DishModel {
  final int? dishId;
  final int? sellerId;
  final String? name;
  final String? description;
  final num? price;
  final String? image;
  final int? quantity;
  final int? categoryId;
  final bool? isVeg;
  final bool? isAvailable;

  DishModel({
     this.dishId,
     this.sellerId,
     this.name,
     this.description,
     this.price,
     this.image,
     this.quantity,
     this.categoryId,
     this.isVeg,
     this.isAvailable,
  });
    factory DishModel.fromJson(Map<String, dynamic> json) {
      // print(json);
    return DishModel(
      dishId: json['dishId'],
      sellerId: json['sellerId'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['imageUrl'],
      quantity: json['quantity'],
      categoryId: json['categoryId'],
      isVeg: json['isVeg'],
      isAvailable: json['isAvailable'],
    );
  }
    Map<String, dynamic> toJson(DishModel dishModel) {
    final Map<String, dynamic> data = {
      'name': dishModel.name,
      'description': dishModel.description,
      'price': dishModel.price,
      'image': dishModel.image,
      'quantity': dishModel.quantity,
      'categoryId': dishModel.categoryId,
      'isVeg': dishModel.isVeg,
      'isAvailable': dishModel.isAvailable,
    };

    return data;
  }
}

class Dish {
  final int? dishId;
  final int? sellerId;
  final String? name;
  final String? description;
  final int? price;
  final MultipartFile? image;
  final int? quantity;
  final int? categoryId;
  final bool? isVeg;
  final bool? isAvailable;

  Dish({
     this.dishId,
     this.sellerId,
     this.name,
     this.description,
     this.price,
     this.image,
     this.quantity,
     this.categoryId,
     this.isVeg,
     this.isAvailable,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      dishId: json['dishId'],
      sellerId: json['sellerId'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'],
      categoryId: json['categoryId'],
      isVeg: json['isVeg'],
      isAvailable: json['isAvailable'],
    );
  }

  Map<String, dynamic> toJson(Dish dish) {
    final Map<String, dynamic> data = {
      'name': dish.name,
      'description': dish.description,
      'price': dish.price,
      'image': dish.image,
      'quantity': dish.quantity,
      'categoryId': dish.categoryId,
      'isVeg': dish.isVeg,
      'isAvailable': dish.isAvailable,
    };

    return data;
  }
}

