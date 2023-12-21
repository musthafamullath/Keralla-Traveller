import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'mycountry.g.dart';

@HiveType(typeId: 1)
class Mycountry extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  @HiveField(3)
  String? imageUser;

  Mycountry({required this.name, required this.email, required this.password,this.imageUser});
}
