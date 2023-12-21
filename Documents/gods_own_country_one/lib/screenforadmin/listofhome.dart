import 'dart:io';
import 'package:flutter/material.dart';
import 'package:keralatraveller/db_functions/admin_db_function.dart';
import 'package:keralatraveller/refacteredclasses/app_toolbarsearch.dart';
import 'package:keralatraveller/refacteredclasses/app_widgetforstack.dart';
import 'package:keralatraveller/refacteredclasses/leanir.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_icons.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:keralatraveller/screenforadmin/addtohome.dart';
import 'package:keralatraveller/screenforadmin/displayadminside.dart';
import 'package:keralatraveller/screenforadmin/editHome.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum HomeMenu {
  edit,
  delete,
}

class ListOfHome extends StatefulWidget {
  const ListOfHome({super.key});

  @override
  State<ListOfHome> createState() => _ListOfHomeState();
}

class _ListOfHomeState extends State<ListOfHome> {
  late Box adminHomeBox;
  @override
  void initState() {
    adminHomeBox = Hive.box(AppStrings.addToHomeAdmin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppToolBar(
        title: AppStrings.youraddedplaces,
        action: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: AppColor.whiteOpacity2
              ),
              child: IconButton(onPressed: (){logoutAdmin(context);}, icon: const Icon( Icons.logout_outlined)),
              ),
          )
        ],
        ),
      body: BackgroundWrapper(
        child: ValueListenableBuilder(
          valueListenable: adminHomeBox.listenable(),
          builder: (context, value, child) => Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 10,
            ),
            child: adminHomeBox.isEmpty 
            ? 
            const Center(child: Text(AppStrings.fieldisempty),)
            :
            ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                final homeDeal = adminHomeBox.getAt(index);
                return AppWidgetsForStack(
                  mainwidget: ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DisplaySideOverviewAdmin(addToHomeAdmin: homeDeal),
                            ),
                          );
                        },
                        child: Container(
                          width: 50,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColor.black,
                                style: BorderStyle.solid,
                                width: 1.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.file(
                              File(homeDeal.image.toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        homeDeal.place,
                        style: Apptext.text2,
                      ),
                      isThreeLine: true,
                      subtitle: Text(
                        homeDeal.location,
                        style: Apptext.text3,
                      ),
                      trailing: PopupMenuButton<HomeMenu>(
                        onSelected: (value) {
                          switch (value) {
                            case HomeMenu.edit:
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditHome(
                                      index: index, editAreas: homeDeal),
                                ),
                              );
                              break;
                            case HomeMenu.delete:
                              deleteAdminDetailsFromHome(context, index);
                              break;
                            default:
                          }
                        },
                        shadowColor: AppColor.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: AppColor.whiteOpacity2,
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: HomeMenu.edit,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AppIcons.icon1,
                                  AppSizedBoxes.box4,
                                  Text(
                                    AppStrings.edit,
                                    style:
                                        Apptext.text10.copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: HomeMenu.delete,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AppIcons.icon9,
                                  AppSizedBoxes.box4,
                                  Text(
                                    AppStrings.delete,
                                    style:
                                        Apptext.text10.copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ];
                        },
                      )),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                height: 10.0,
              ),
              itemCount: adminHomeBox.length,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        navigateToAddToHome(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColor.buttoncolor,
        child: const Icon(Icons.add,size: 20,),
      ),
      
    );
  }
  navigateToAddToHome(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddToHome(),));
  }
}
