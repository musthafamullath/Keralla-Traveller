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

class Forest extends StatefulWidget {
  const Forest({super.key});

  @override
  State<Forest> createState() => _ForestState();
}

class _ForestState extends State<Forest> {
  List<AddToHomeAdmin> forest = [];
  void getforest() {
    final boxresulte = Hive.box(AppStrings.addToHomeAdmin);
    final catforest = boxresulte.values.toList();
    for (final addToforestAdmin in catforest) {
      if (addToforestAdmin.categories == AppStrings.forest) {
        forest.add(addToforestAdmin);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    getforest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolBar(title: AppStrings.forest),
      body: forest.isEmpty
          ? const BackgroundWrapper(
              child: Center(
                child: Text(AppStrings.forestnotavilable),
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
                  final forestDeal = forest[index];
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
                                      addToHomeAdmin: forestDeal),
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
                                  File(forestDeal.image.toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          AppSizedBoxes.box6,
                          Text(
                            forestDeal.place,
                            style: Apptext.text2,
                          ),
                          AppSizedBoxes.box6,
                          Text(
                            forestDeal.location,
                            style: Apptext.text3,
                          ),
                          Rating(
                            itemSize: 12,
                            initialRating: forestDeal.rating,
                          ),
                          AppSizedBoxes.box6,
                                              ],
                                            ),
                        )),
                  );
                },
                itemCount: forest.length,
              ),
            ),
    );
  }
}
