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

class Mountain extends StatefulWidget {
  const Mountain({super.key});

  @override
  State<Mountain> createState() => _MountainState();
}

class _MountainState extends State<Mountain> {
   List<AddToHomeAdmin> mountain = [];
   void getmountain(){
      final boxresulte = Hive.box(AppStrings.addToHomeAdmin);
      final catmountain = boxresulte.values.toList();
      for(final addTomountainAdmin in catmountain){
        if(addTomountainAdmin.categories == AppStrings.mountain){
          mountain.add(addTomountainAdmin);
        }
      }
      setState(() {});
    }
  @override
  void initState() {
    getmountain();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppToolBar(title: AppStrings.mountain),
       body:mountain.isEmpty?
      const BackgroundWrapper(
        child: Center(
          child: Text(AppStrings.mountainsnotavilable),
        ),
      ):
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final mountainDeal = mountain[index];
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
                                      builder: (context) =>
                                          DisplaySideOverview(addToHomeAdmin: mountainDeal),
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
                                      File(mountainDeal.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              AppSizedBoxes.box6,
                              Text(
                                mountainDeal.place,
                                style: Apptext.text2,
                              ),
                              AppSizedBoxes.box9,
                              Text(
                                mountainDeal.location,
                                style: Apptext.text3,
                              ),
                               Rating(
                               itemSize: 12, 
                               initialRating: mountainDeal.rating,
                               ),
                                  AppSizedBoxes.box8,
                              ],
                            ),
                          )
                           
                         
                        ),
                      );
                    },
                    itemCount: mountain.length,
                  ),
      ),
    );
  }
}