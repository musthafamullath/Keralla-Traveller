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

class River extends StatefulWidget {
  const River({super.key});

  @override
  State<River> createState() => _RiverState();
}

class _RiverState extends State<River> {
  List<AddToHomeAdmin> river = [];

  void getriver() {
    final boxresulte = Hive.box(AppStrings.addToHomeAdmin);
    final catriver = boxresulte.values.toList();
    for (final addToriverAdmin in catriver) {
      if (addToriverAdmin.categories == AppStrings.river) {
        river.add(addToriverAdmin);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    getriver();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolBar(title: AppStrings.river),
      body: river.isEmpty
          ? const BackgroundWrapper(
              child: Center(
                child: Text(AppStrings.riversnotavilable),
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
                  final riverDeal = river[index];
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
                                      addToHomeAdmin: riverDeal,
                                    ),
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
                                    File(riverDeal.image.toString()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            AppSizedBoxes.box6,
                            Text(
                              riverDeal.place,
                              style: Apptext.text2,
                            ),
                            AppSizedBoxes.box6,
                            Text(
                              riverDeal.location,
                              style: Apptext.text3,
                            ),
                            Rating(
                              itemSize: 12,
                              initialRating: riverDeal.rating,
                            ),
                            AppSizedBoxes.box6,
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: river.length,
              ),
            ),
    );
  }
}
