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

class Lake extends StatefulWidget {
  const Lake({super.key});

  @override
  State<Lake> createState() => _LakeState();
}

class _LakeState extends State<Lake> {
  List<AddToHomeAdmin> lakes = [];
  void getlakes() {
    final boxresulte = Hive.box(AppStrings.addToHomeAdmin);
    final catLakes = boxresulte.values.toList();
    for (final addTolakeAdmin in catLakes) {
      if (addTolakeAdmin.categories == AppStrings.lacks) {
        lakes.add(addTolakeAdmin);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    getlakes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolBar(title: AppStrings.lacks),
      body: lakes.isEmpty
          ? const BackgroundWrapper(
              child: Center(
                child: Text(AppStrings.lakesnotavilable),
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
                  final lakeDeal = lakes[index];
                  return GridTile(
                      // footer: Padding(
                      //   padding: const EdgeInsets.only(left: 120),
                      //   child: FavoriteCls(index: index),
                      // ),
                      child: AppWidgetsForStack(
                        mainwidget: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DisplaySideOverview(
                                          addToHomeAdmin: lakeDeal),
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
                                      File(lakeDeal.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              AppSizedBoxes.box6,
                              Text(
                                lakeDeal.place,
                                style: Apptext.text2,
                              ),
                              AppSizedBoxes.box6,
                              Text(
                                lakeDeal.location,
                                style: Apptext.text3,
                              ),
                               AppSizedBoxes.box6,
                              Rating(
                                itemSize: 12,
                                initialRating: lakeDeal.rating,
                              ),
                              AppSizedBoxes.box6,
                            ],
                          ),
                        ),
                      ));
                },
                itemCount: lakes.length,
              ),
            ),
    );
  }
}
