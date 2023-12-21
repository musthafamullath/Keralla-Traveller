import 'dart:io';
import 'package:flutter/material.dart';
import 'package:keralatraveller/modal/addtohomeadmin.dart';
import 'package:keralatraveller/refacteredclasses/app_toolbarsearch.dart';
import 'package:keralatraveller/refacteredclasses/leanir.dart';
import 'package:keralatraveller/refacteredclasses/rating.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';

class DisplaySideOverviewAdmin extends StatefulWidget {
  final AddToHomeAdmin addToHomeAdmin;
  const DisplaySideOverviewAdmin({
    super.key,
    required this.addToHomeAdmin,
  });

  @override
  State<DisplaySideOverviewAdmin> createState() => _DisplaySideOverviewAdminState();
}

class _DisplaySideOverviewAdminState extends State<DisplaySideOverviewAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppToolBar(title: AppStrings.overView),
      body: BackgroundWrapper(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSizedBoxes.box5,
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.black,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        File(widget.addToHomeAdmin.image.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  AppSizedBoxes.box5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          widget.addToHomeAdmin.place,
                          style: Apptext.text1,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AppSizedBoxes.box4,
                      Rating(
                        itemSize: 20,
                        initialRating: widget.addToHomeAdmin.rating,
                      ),
                    ],
                  ),
                  AppSizedBoxes.box5,
                  Text(
                    widget.addToHomeAdmin.location,
                    style: Apptext.text2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSizedBoxes.box5,
                  Text(
                    widget.addToHomeAdmin.details,
                    style: Apptext.text3,
                  ),
                  AppSizedBoxes.box5,
                  // Appbutton(
                  //     bottonText: AppStrings.leavecomment,
                  //     bottonnavigator: () {
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (context) =>
                  //               CommendScreen(addToHomeAdmin: widget.addToHomeAdmin)));
                  //     }),
                  // AppSizedBoxes.box2,
                  AppSizedBoxes.box2,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
