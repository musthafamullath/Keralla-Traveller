import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keralatraveller/db_functions/user_db_fucntion.dart';
import 'package:keralatraveller/modal/mycountry.dart';
import 'package:keralatraveller/refacteredclasses/app_avatarfield.dart';
import 'package:keralatraveller/refacteredclasses/app_button.dart';
import 'package:keralatraveller/refacteredclasses/app_toolbarsearch.dart';
import 'package:keralatraveller/refacteredclasses/leanir.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_icons.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textfeildborders.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:keralatraveller/screens/aboutus.dart';
import 'package:keralatraveller/screens/edit_userprofile.dart';
import 'package:keralatraveller/screens/privacypolicy.dart';
import 'package:keralatraveller/screens/termsandcontitions.dart';
enum AccountMenu {
  privacypolicy,
  termsconditions,
  aboutua,
}

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late Box mycountryBox;
  int? storedIndex;
  @override
  void initState() {
    mycountryBox = Hive.box("mycountry");
    isfavor().then((value) {
      setState(() {
        storedIndex = value;
      });
    });
    super.initState();
  }

  void updateprofileinfo(Mycountry updatedlogin) {
    if (storedIndex != null) {
      mycountryBox.putAt(storedIndex!, updatedlogin);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final login = storedIndex != null ? mycountryBox.getAt(storedIndex!) : null;
    final imageFile =
        login?.imageUser != null ? File(login.imageUser.toString()) : null;
    return Scaffold(
      appBar: AppToolBar(
        title: AppStrings.profile,
        action: [
          PopupMenuButton<AccountMenu>(
            icon: AppIcons.icon12,
            onSelected: (value) {
              switch (value) {
                case AccountMenu.privacypolicy:
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Privacyandpolicy(),
                  ));
                  break;
                case AccountMenu.termsconditions:
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TermsAndCountions(),
                  ));
                  break;
                case AccountMenu.aboutua:
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AboutUs(),
                  ));
                  break;
                default:
              }
            },
            shadowColor: AppColor.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: AppColor.buttoncolor,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: AccountMenu.privacypolicy,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppIcons.icon11,
                      AppSizedBoxes.box4,
                      Text(
                        AppStrings.privacyandpolicy,
                        style: Apptext.text10.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: AccountMenu.termsconditions,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppIcons.icon2,
                      AppSizedBoxes.box4,
                      Text(
                        AppStrings.termsandcountions,
                        style: Apptext.text10.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: AccountMenu.termsconditions,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppIcons.icon2,
                      AppSizedBoxes.box4,
                      Text(
                        AppStrings.aboutus,
                        style: Apptext.text10.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: mycountryBox.listenable(),
        builder: (context, value, child) => BackgroundWrapper(
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(
                  top: 40, bottom: 80, left: 30, right: 30),
              decoration: AppTextFieldBorders.border3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppAvatarUser(
                        width: 300,
                        height: 300,
                        size: 150,
                        imageWidget: imageFile != null
                            ? Image.file(imageFile, fit: BoxFit.cover)
                            : const Icon(
                                Icons.camera,
                                size: 50,
                                color: Colors.black,
                              ),
                      ),
                      AppSizedBoxes.box2,
                      Text(
                        login?.name ?? '',
                        style: Apptext.text1,
                      ),
                      AppSizedBoxes.box3,
                      Text(
                        login?.email ?? '',
                        style: Apptext.text8,
                      ),
                      AppSizedBoxes.box2,
                      Appbutton(
                          bottonText: AppStrings.editProfile,
                          bottonnavigator: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditProfile(
                                  mycountry: login,
                                  index: storedIndex!,
                                  updateprofileinfo: updateprofileinfo,
                                ),
                              ),
                            );
                          }),
                      AppSizedBoxes.box4,
                      Appbutton(
                          bottonText: AppStrings.logoutaccount,
                          bottonnavigator: () async {
                            deleteuserDetailsFromdb(context, storedIndex!);
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
