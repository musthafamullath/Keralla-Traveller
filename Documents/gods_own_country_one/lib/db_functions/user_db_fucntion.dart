import 'package:flutter/material.dart';
import 'package:keralatraveller/modal/mycountry.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:keralatraveller/screenforadmin/listofhome.dart';
import 'package:keralatraveller/screens/login_page.dart';
import 'package:keralatraveller/screens/profile_page.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

//db add function
Future<void> signUpAndAddDetailsToBD(Mycountry addUserDB) async {
  await Hive.box("mycountry").add(addUserDB);
}

Future<void> snakBarAndNavigatorFromAddDB(BuildContext context) async {
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(AppStrings.snackbargreen),
      backgroundColor: Colors.green,
    ),
  );
  await Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => const LogIn(),
  ));
}

//db edit function
Future<void> userEditDetailsFromHome(Mycountry value, int index) async {
  await Hive.box("mycountry").putAt(index, value);
}

Future<void> editUserSnackBar(BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(AppStrings.dataeditedsuccessfully),
      backgroundColor: Colors.green,
    ),
  );
  Navigator.of(context).pop(
    MaterialPageRoute(
      builder: (context) => const AccountPage(),
    ),
  );
}

Future<void> loginSnackBarfeiledWithOutValue(BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text(AppStrings.feildisrequired),
      backgroundColor: Colors.red[900],
      duration: const Duration(seconds: 1),
    ),
  );
}

Future<int?> isfavor() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final id = sharedPreferences.getInt('userIndex') ?? 0;
  return id;
}

//db edit function
Future<void> addminEditDetailsFromHome(Mycountry value, int index) async {
  await Hive.box("mycountry").putAt(index, value);
}

Future<void> editAdminSnackBar(BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(AppStrings.dataeditedsuccessfully),
      backgroundColor: Colors.green,
    ),
  );
  Navigator.of(context).pop(
    MaterialPageRoute(
      builder: (context) => const ListOfHome(),
    ),
  );
}

//db delete function
Future<void> deleteuserDetailsFromdb(BuildContext context, int index) async {
  showDialog(
    context: context,
    useSafeArea: true,
    builder: (context) => AlertDialog(
      backgroundColor: AppColor.buttoncolor,
      scrollable: true,
      title: const Text(
        AppStrings.delete,
        style: Apptext.text9,
      ),
      content: const Text(
        AppStrings.doyouwanttodelete,
        style: Apptext.text12,
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx1) => const LogIn()),
                (route) => false);
            final sheredprifer = await SharedPreferences.getInstance();
            sheredprifer.clear();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: const Text(
            AppStrings.delete,
            style: Apptext.text2,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: const Text(
            AppStrings.goback,
            style: Apptext.text2,
          ),
        ),
      ],
    ),
  );
}
