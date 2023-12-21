import 'package:flutter/material.dart';
import 'package:keralatraveller/db_functions/user_db_fucntion.dart';
import 'package:keralatraveller/modal/favoritesdb.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteCls extends StatefulWidget {
  final int? index;
  const FavoriteCls({
    Key? key,
    required this.index,
  }): super(key: key);

  @override
  State<FavoriteCls> createState() => _FavoriteClsState();
}

class _FavoriteClsState extends State<FavoriteCls> {
  bool isfavorite = false;
  int? userindex;
  late Box favoriteBox;
  @override
  void initState() {
    favoriteBox = Hive.box("favorite");
   
    isfavor().then((value) {
      setState(() {
        userindex = value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int favoriteIndex = widget.index ?? 0;
    return IconButton(
      splashRadius: 20,
      onPressed: () {
        addToFavoriteList(favoriteIndex);
      },
      icon: Icon(
        favoriteBox.values.any((item) =>
                item.userId == userindex && item.countryId == widget.index)
            ? Icons.favorite
            : Icons.favorite_border,
        color: Colors.white,
      ),
    );
  }

  Future<void> addToFavoriteList(int favoriteIndex) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int userIndex = sharedPreferences.getInt('userIndex') ?? 0;
    userindex = userIndex;
    List favoriteItems = favoriteBox.values.toList();
    int existingIndex = favoriteItems.indexWhere(
      (element) =>
          element.userId == userIndex && element.countryId == favoriteIndex,
    );
    setState(() {
      if (existingIndex != -1) {
        favoriteBox.deleteAt(existingIndex);
      } else {
        Favoritesdb favoriteitem = Favoritesdb(
          userId: userIndex,
          countryId: favoriteIndex,
        );
        favoriteBox.add(favoriteitem);
      }
    });
  }
}


