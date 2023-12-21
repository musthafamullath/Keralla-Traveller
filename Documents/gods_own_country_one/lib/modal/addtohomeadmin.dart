import 'package:hive/hive.dart';
part 'addtohomeadmin.g.dart';

@HiveType(typeId: 2)
class AddToHomeAdmin extends HiveObject {
  @override
  @HiveField(0)
  final String key;
  @HiveField(1)
  final String place;
  @HiveField(2)
  final String location;
  @HiveField(3)
  final String details;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final String categories;
  @HiveField(6)
  final double rating;


  AddToHomeAdmin({
    required this.image,
    required this.place,
    required this.location,
    required this.details,
    required this.categories,
    required this.rating,
    required this.key,
  });
}
