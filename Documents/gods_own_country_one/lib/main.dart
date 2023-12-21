import 'package:flutter/material.dart';
import 'package:keralatraveller/modal/addtohomeadmin.dart';
import 'package:keralatraveller/modal/commentdb.dart';
import 'package:keralatraveller/modal/favoritesdb.dart';
import 'package:keralatraveller/modal/mycountry.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keralatraveller/screens/splash_page.dart';

// ignore: constant_identifier_names
const SAVE_KEY_NAME = AppStrings.userloggedin;
// ignore: constant_identifier_names
const USER_ROLE_KEY = AppStrings.checkuserloggedinandrole;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MycountryAdapter());
  await Hive.openBox("mycountry");
  Hive.registerAdapter(AddToHomeAdminAdapter());
  await Hive.openBox(AppStrings.addToHomeAdmin);
  Hive.registerAdapter(FavoritesdbAdapter());
  await Hive.openBox("favorite");
  Hive.registerAdapter(CommentAdapter());
  await Hive.openBox('comment');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.superName,
      theme: ThemeData(
        fontFamily: AppStrings.appfont,
        scaffoldBackgroundColor: AppColor.background,
      ),
      home: const SplashScreen(),
    );
  }
}
