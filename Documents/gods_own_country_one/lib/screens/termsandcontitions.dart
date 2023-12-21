import 'package:flutter/material.dart';
import 'package:keralatraveller/refacteredclasses/app_toolbarsearch.dart';
import 'package:keralatraveller/refacteredclasses/leanir.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';

class TermsAndCountions extends StatelessWidget {
  const TermsAndCountions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolBar(title: AppStrings.termsandcountions),
      body: const BackgroundWrapper(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Text(AppStrings.termscountion,style: Apptext.text2,),
          ),
        ),
      ),
    );
  }
}