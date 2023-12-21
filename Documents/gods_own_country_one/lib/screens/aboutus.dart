import 'package:flutter/material.dart';
import 'package:keralatraveller/refacteredclasses/app_toolbarsearch.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolBar(title: AppStrings.aboutus),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizedBoxes.box3,
              Text(AppStrings.welcometokerala,style: Apptext.text8,),
              AppSizedBoxes.box6,
              Text(AppStrings.discover,style: Apptext.text2,),
              AppSizedBoxes.box3,
              Text(AppStrings.whatsets,style: Apptext.text8,),
              AppSizedBoxes.box6,
              Text(AppStrings.atkerala,style: Apptext.text2,),
              AppSizedBoxes.box3,
              Text(AppStrings.keyfeatures,style: Apptext.text8,),
              AppSizedBoxes.box6,
              Text(AppStrings.comprehensive,style: Apptext.text2,),
              AppSizedBoxes.box3,
              Text(AppStrings.ourmission,style: Apptext.text8,),
              AppSizedBoxes.box6,
              Text(AppStrings.keralatraveller,style: Apptext.text2,), 
              AppSizedBoxes.box3,
              Text(AppStrings.contactus,style: Apptext.text8,),
              AppSizedBoxes.box6,
              Text(AppStrings.havesuggestion,style: Apptext.text2,),
              AppSizedBoxes.box3,
            ],
          ),
        ),
      ),
    );
  }
}