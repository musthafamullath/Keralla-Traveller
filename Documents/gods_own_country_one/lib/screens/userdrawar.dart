import 'dart:io';
import 'package:flutter/material.dart';
import 'package:keralatraveller/db_functions/user_db_fucntion.dart';
import 'package:keralatraveller/modal/mycountry.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_icons.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:keralatraveller/screens/aboutus.dart';
import 'package:keralatraveller/screens/home_page.dart';
import 'package:keralatraveller/screens/privacypolicy.dart';
import 'package:keralatraveller/screens/termsandcontitions.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Mydrawar extends StatefulWidget {
  const Mydrawar({super.key});
  @override
  State<Mydrawar> createState() => _MydrawarState();
}

class _MydrawarState extends State<Mydrawar> {
  late Box myCountryBox;
  int? storedIndex;
  @override
  void initState() {
    myCountryBox = Hive.box("mycountry");
    isfavor().then((value) {
      setState(() {
        storedIndex = value;
      });
    });
    super.initState();
  }

  

  void updateprofileinfo(Mycountry updatedlogin) {
    myCountryBox.putAt(storedIndex!, updatedlogin);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final login = storedIndex != null ? myCountryBox.getAt(storedIndex!) : null;
    final imageFile =
        login?.imageUser != null ? File(login!.imageUser!.toString()) : null;
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(MaterialPageRoute(
          builder: (context) => const HomePage(),
        )),
        child: Drawer(
          backgroundColor: AppColor.buttoncolor,
          child: ValueListenableBuilder(
            valueListenable: myCountryBox.listenable(),
            builder: (context, value, child) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 80, bottom: 30),
                        child: RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: AppStrings.hello,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.teal)),
                          TextSpan(
                              text: '${login?.name ?? ''}',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                        ])),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              imageFile != null ? FileImage(imageFile) : null,
                          backgroundColor: Colors.black,
                          child: imageFile == null
                              ? const Icon(
                                  Icons.camera,
                                  size: 50,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                    ),
                    AppSizedBoxes.box2,
                    Center(
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Privacyandpolicy(),
                          ));
                        },
                        icon: AppIcons.icon11,
                        label: Text(
                          AppStrings.privacyandpolicy,
                          style: Apptext.text10.copyWith(fontSize: 25),
                        ),
                      ),
                    ),
                    AppSizedBoxes.box2,
                    Center(
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const TermsAndCountions(),
                          ));
                        },
                        icon: AppIcons.icon2,
                        label: Text(
                          AppStrings.termsandcountions,
                          style: Apptext.text10.copyWith(fontSize: 25),
                        ),
                      ),
                    ),
                    AppSizedBoxes.box2,
                    Center(
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AboutUs(),
                          ));
                        },
                        icon: const Icon(
                          Icons.details_sharp,
                          color: AppColor.black,
                        ),
                        label: Text(
                          AppStrings.aboutus,
                          style: Apptext.text10.copyWith(fontSize: 25),
                        ),
                      ),
                    ),
                    AppSizedBoxes.box2,
                    Center(
                      child: TextButton.icon(
                        onPressed: () async {
                          if (storedIndex != null) {
                            deleteuserDetailsFromdb(context, storedIndex!);
                          }
                        },
                        icon: const Icon(
                          Icons.logout_outlined,
                          color: AppColor.red,
                        ),
                        label: Text(
                          AppStrings.logout,
                          style: Apptext.text15.copyWith(fontSize: 25),
                        ),
                      ),
                    ),
                    AppSizedBoxes.box2,
                    const Center(
                        child: Text(
                      AppStrings.version,
                      style:
                          TextStyle(color: Color.fromARGB(255, 193, 191, 191)),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
