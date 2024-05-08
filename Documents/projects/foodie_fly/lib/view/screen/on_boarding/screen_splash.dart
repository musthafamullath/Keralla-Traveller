import 'package:flutter/material.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/screen/on_boarding/widgets/button.dart';
import 'package:foodie_fly/view/screen/on_boarding/widgets/image_widget.dart';
import 'package:foodie_fly/view/screen/on_boarding/widgets/screen_indicator.dart';
import 'package:foodie_fly/view/screen/on_boarding/widgets/sub_titles.dart';
import 'package:foodie_fly/view/screen/on_boarding/widgets/title.dart';

class ScreenOnBoarding extends StatelessWidget {
  const ScreenOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, position) {
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  kHight100,
                  kHight50,
                  ImageWidget(
                    width: width,
                    height: height,
                    position: position,
                  ),
                  kHight20,
                  ScreenIndicator(position: position),
                  kHight20,
                  Titles(position: position),
                  kHight20,
                  SubTitles(position: position),
                  kHight30,
                  NextButton(width: width, position: position)
                ],
              ),
            ),
          );
        },
        itemCount: 3,
      ),
    );
  }
}
