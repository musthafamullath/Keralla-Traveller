import 'dart:io';
import 'package:flutter/material.dart';
import 'package:keralatraveller/modal/addtohomeadmin.dart';
import 'package:keralatraveller/refacteredclasses/app_toolbarsearch.dart';
import 'package:keralatraveller/refacteredclasses/app_widgetforstack.dart';
import 'package:keralatraveller/refacteredclasses/leanir.dart';
import 'package:keralatraveller/refacteredclasses/rating.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:keralatraveller/screenforadmin/displayuserside.dart';
import 'package:hive/hive.dart';

class Sea extends StatefulWidget {
  const Sea({super.key});

  @override
  State<Sea> createState() => _SeaState();
}

class _SeaState extends State<Sea> {
  List<AddToHomeAdmin>beach = [];
  void getsea() {
    final boxresulte = Hive.box(AppStrings.addToHomeAdmin);
    final catBeach = boxresulte.values.toList();
    for (final addToBeachAdmin in catBeach) {
      if (addToBeachAdmin.categories == AppStrings.beachs) {
        beach.add(addToBeachAdmin);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    getsea();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolBar(title: AppStrings.beachs),
      body: beach.isEmpty
          ? const BackgroundWrapper(
              child: Center(
                child: Text(AppStrings.beachesnotavilable),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final beachDeal = beach[index];
                  return AppWidgetsForStack(
                    mainwidget: GridTile(
                      // footer: Padding(
                      //   padding: const EdgeInsets.only(left: 120),
                      //   child: FavoriteCls(index: index),
                      // ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DisplaySideOverview(
                                      addToHomeAdmin: beachDeal),
                                ),
                              );
                            },
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.file(
                                  File(beachDeal.image.toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          AppSizedBoxes.box6,
                          Text(
                            beachDeal.place,
                            style: Apptext.text2,
                          ),
                          AppSizedBoxes.box6,
                          Text(
                            beachDeal.location,
                            style: Apptext.text3,
                          ),
                          Rating(
                            itemSize: 12,
                            initialRating: beachDeal.rating,
                          ),
                          AppSizedBoxes.box6,
                                              ],
                                            ),
                        )),
                  );
                },
                itemCount: beach.length,
              ),
            ),
    );
  }
}
