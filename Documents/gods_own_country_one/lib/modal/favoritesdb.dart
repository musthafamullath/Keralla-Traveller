import 'package:hive_flutter/hive_flutter.dart';
part 'favoritesdb.g.dart';

@HiveType(typeId: 3)
class Favoritesdb extends HiveObject {
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final int countryId;
  Favoritesdb({
    required this.userId,
    required this.countryId,
  });

}
