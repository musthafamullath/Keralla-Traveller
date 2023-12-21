import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:keralatraveller/refacteredclasses/app_textfieldthree.dart';
import 'package:keralatraveller/refacteredclasses/app_toolbarsearch.dart';
import 'package:keralatraveller/refacteredclasses/app_widgetforstack.dart';
import 'package:keralatraveller/refacteredclasses/leanir.dart';
import 'package:keralatraveller/refacteredclasses/rating.dart';
import 'package:keralatraveller/refactoredwidgets/app_aspetbutton.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:keralatraveller/screenforadmin/displayuserside.dart';
import 'package:keralatraveller/screens/favorite_cls.dart';
import 'package:keralatraveller/screens/forest.dart';
import 'package:keralatraveller/screens/lake.dart';
import 'package:keralatraveller/screens/mountain.dart';
import 'package:keralatraveller/screens/river.dart';
import 'package:keralatraveller/screens/beach.dart';
import 'package:keralatraveller/screens/userdrawar.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box adminHomeBox;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final searchController = TextEditingController();

  List filteredPlace = [];
  void filteration() {
    String search = searchController.text.toLowerCase();
    if (search.isNotEmpty) {
      filteredPlace = adminHomeBox.values
          .where((myplace) =>
              myplace.place.toLowerCase().contains(search) ||
              myplace.location.toLowerCase().contains(search))
          .toList();
    } else {
      filteredPlace = List.from(adminHomeBox.values);
    }
  }

  @override
  void initState() {
    adminHomeBox = Hive.box(AppStrings.addToHomeAdmin);
    filteredPlace = List.from(adminHomeBox.values);
    searchController.addListener(filteration);
    super.initState();
  }

  @override
  void dispose() {
    searchController
        .removeListener(filteration); // Remove listener to the searchController
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppToolBar(
          title: AppStrings.home,
          drawer: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: const Icon(Icons.menu),
          )),
      endDrawer: const Mydrawar(),
      body: BackgroundWrapper(
        child: ValueListenableBuilder(
          valueListenable: adminHomeBox.listenable(),
          builder: (context, value, child) => Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizedBoxes.box5,
                AppTextFieldthree(
                  hint: AppStrings.search,
                  hintStyle: Apptext.text13,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColor.buttoncolor,
                  ),
                  keyboard: TextInputType.name,
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      filteration();
                    });
                  },
                ),
                AppSizedBoxes.box5,
                const Text(
                  AppStrings.categories,
                  style: Apptext.text8,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AspectRatio(
                    aspectRatio: 100 / 12,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        AstpetButton(
                            iconText: AppStrings.lacks,
                            icons: const Icon(
                              Mdi.sailBoat,
                              size: 18,
                              color: Colors.white,
                            ),
                            aspetfunction: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Lake(),
                              ));
                            }),
                        AstpetButton(
                            iconText: AppStrings.beachs,
                            icons: const Icon(
                              Mdi.beach,
                              size: 18,
                              color: Colors.white,
                            ),
                            aspetfunction: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Sea(),
                              ));
                            }),
                        AstpetButton(
                            iconText: AppStrings.mountain,
                            icons: const Icon(
                              Mdi.flagTriangle,
                              size: 18,
                              color: Colors.white,
                            ),
                            aspetfunction: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Mountain(),
                              ));
                            }),
                        AstpetButton(
                            iconText: AppStrings.forest,
                            icons: const Icon(
                              Mdi.forest,
                              size: 18,
                              color: Colors.white,
                            ),
                            aspetfunction: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Forest(),
                              ));
                            }),
                        AstpetButton(
                            iconText: AppStrings.river,
                            icons: const Icon(
                              Mdi.shore,
                              size: 18,
                              color: Colors.white,
                            ),
                            aspetfunction: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const River(),
                              ));
                            }),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    AppStrings.allplaces,
                    style: Apptext.text8,
                  ),
                ),
                Expanded(
                  child: filteredPlace.isEmpty
                      ? const Center(
                          child: Text(AppStrings.fieldisempty),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 25.0,
                                  mainAxisSpacing: 25.0),
                          itemBuilder: (BuildContext context, int index) {
                            final homeDeal = filteredPlace[index];
                            return GridTile(
                              footer: Padding(
                                padding: const EdgeInsets.only(left: 90),
                                child: FavoriteCls(index: index),
                              ),
                              child: AppWidgetsForStack(
                                mainwidget: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DisplaySideOverview(
                                                    addToHomeAdmin: homeDeal),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 90,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.file(
                                            File(homeDeal.image.toString()),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppSizedBoxes.box5,
                                          Text(
                                            homeDeal.place,
                                            style: Apptext.text2,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          AppSizedBoxes.box6,
                                          Text(
                                            homeDeal.location,
                                            style: Apptext.text3,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          AppSizedBoxes.box6,
                                          Rating(
                                            itemSize: 12,
                                            initialRating: homeDeal.rating,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: filteredPlace.length,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
