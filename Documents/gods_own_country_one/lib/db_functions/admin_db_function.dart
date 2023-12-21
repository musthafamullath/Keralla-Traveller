import 'package:flutter/material.dart';
import 'package:keralatraveller/modal/addtohomeadmin.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:keralatraveller/screenforadmin/addtohome.dart';
import 'package:keralatraveller/screenforadmin/listofhome.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keralatraveller/screens/login_page.dart';

//db add function
Future<void> addminAddDetailsToHome(AddToHomeAdmin addToHomeAdmin) async {
  await Hive.box(AppStrings.addToHomeAdmin).add(addToHomeAdmin);
}

Future<void> addAdminSnackBar(BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text(AppStrings.detailsaddedseccessfuly),
      backgroundColor: Colors.green[900],
      duration: const Duration(seconds: 1),
    ),
  );
  Navigator.of(context).pop( const AddToHome());
}


//db edit function
Future<void> addminEditDetailsFromHome(AddToHomeAdmin value, int index) async {
  await Hive.box(AppStrings.addToHomeAdmin).putAt(index, value);
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
Future<void> deleteAdminDetailsFromHome(BuildContext context, int index) async {
  showDialog(
    context: context,
    useSafeArea: true,
    builder: (context) => AlertDialog(
      backgroundColor: AppColor.buttoncolor,
      scrollable: true,
      title: const Text(AppStrings.delete,style: Apptext.text9,),
      content: const Text(AppStrings.doyouwanttodelete,style: Apptext.text12,),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await Hive.box(AppStrings.addToHomeAdmin).deleteAt(index);
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
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

Future<void> logoutAdmin(BuildContext context) async {
  showDialog(
    context: context,
    useSafeArea: true,
    builder: (context) => AlertDialog(
      backgroundColor: AppColor.buttoncolor,
      scrollable: true,
      title: const Text(AppStrings.logout,style: Apptext.text9,),
      content: const Text(AppStrings.doyouwanttologout,style: Apptext.text12,),
      actions: [
        ElevatedButton(
          onPressed: ()  {
           Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => const LogIn()),
        (route) => false);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: const Text(
            AppStrings.logout,
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




Future<void>addAdminSnackBarImageError(BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text(AppStrings.imageofplace),
      backgroundColor: Colors.red[900],
      duration: const Duration(seconds: 1),
    ),
  );
 
}
