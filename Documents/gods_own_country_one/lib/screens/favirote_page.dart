import 'dart:io';
import 'package:flutter/material.dart';
import 'package:keralatraveller/modal/addtohomeadmin.dart';
import 'package:keralatraveller/modal/favoritesdb.dart';
import 'package:keralatraveller/refacteredclasses/app_toolbarsearch.dart';
import 'package:keralatraveller/refacteredclasses/app_widgetforstack.dart';
import 'package:keralatraveller/refacteredclasses/leanir.dart';
import 'package:keralatraveller/refacteredclasses/rating.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:keralatraveller/screenforadmin/displayuserside.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavirotePage extends StatefulWidget {
  const FavirotePage({super.key});

  @override
  State<FavirotePage> createState() => _FavirotePageState();
}

class _FavirotePageState extends State<FavirotePage> {
  late Box favoritebox;
  late Box addtohomeadminbox;
  late int loggedUserIndex;
  @override
  void initState() {
    favoritebox = Hive.box("favorite");
    addtohomeadminbox = Hive.box(AppStrings.addToHomeAdmin);
    loggedUserIndex = 0;
    loadLoggedInUserIndex();
    super.initState();
  }

  void loadLoggedInUserIndex() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    loggedUserIndex = sharedpref.getInt('userIndex') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolBar(title: AppStrings.favorite),
      body: BackgroundWrapper(
        child: ValueListenableBuilder(
          valueListenable: favoritebox.listenable(),
          builder: (context, value, child) {
            List favoriteItems = favoritebox.values
                .where((element) => element.userId == loggedUserIndex)
                .toList();
            return favoriteItems.isEmpty
                ? const Center(
                    child: Text(AppStrings.fieldisempty),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 177,
                        crossAxisCount: 2,
                        crossAxisSpacing: 25.0,
                        mainAxisSpacing: 25.0,
                      ),
                      itemBuilder: (context, index) {
                        Favoritesdb favoriteItem = favoriteItems[index];
                        final country = addtohomeadminbox
                            .getAt(favoriteItem.countryId) as AddToHomeAdmin;
                        return GridTile(
                          footer: Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    int existingIndex = favoriteItems.indexWhere(
                                      (element) =>
                                          element.userId == loggedUserIndex &&
                                          element.countryId ==
                                              favoriteItem.countryId,
                                    );
                                    if (existingIndex != -1) {
                                      favoritebox.deleteAt(existingIndex);
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: AppColor.white,
                                )),
                          ),
                          child: GestureDetector(
                            child: AppWidgetsForStack(
                              mainwidget: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DisplaySideOverview(
                                              addToHomeAdmin: country,
                                            ),
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
                                            File(
                                              country.image.toString(),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppSizedBoxes.box6,
                                          Text(
                                            country.place,
                                            style: Apptext.text2,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          AppSizedBoxes.box6,
                                          Text(
                                            country.location,
                                            style: Apptext.text3,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                           AppSizedBoxes.box6,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Rating(
                                                itemSize: 12,
                                                initialRating: country.rating,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: favoriteItems.length,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
