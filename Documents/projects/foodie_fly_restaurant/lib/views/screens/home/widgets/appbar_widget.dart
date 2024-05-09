
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/profile/profile_bloc.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';

import '../../../../utils/text_styles.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width * 10 / 10,
      decoration:const BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(
            color: black,
            width: 10,
          ),
        ),
        backgroundBlendMode: BlendMode.darken,
        color: yellow,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Stack(
        children: [
           Padding(
              padding: const EdgeInsets.fromLTRB(20, 55, 20, 0),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Hello, Welome ',
                          style: bigBoldBlack,
                        ),
                        TextSpan(
                          text: state.profile?.name ??
                              "Restaurant Name",
                          style: bigBoldBlack,
                        ),
                        const TextSpan(
                          text: "🤝..!!!",
                          style: bigBoldBlack,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          
        ],
      ),
    );
  }
}
