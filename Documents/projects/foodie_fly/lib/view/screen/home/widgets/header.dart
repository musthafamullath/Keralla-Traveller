import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/profile/profile_bloc.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/screen/favorites/favorites.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 7,
                  spreadRadius: 5,
                  offset: const Offset(0.5, 0.5),
                )
              ],
              color: yellowGreen,
              border: const BorderDirectional(
                bottom: BorderSide(
                  color: yellowGreen,
                  width: 10,
                ),
              ),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35))),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(children: <TextSpan>[
                    const TextSpan(
                        text: 'Hello Welcome\n',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: white,
                        )),
                    TextSpan(
                      text: state.profile?.firstName ?? "Name",
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: white),
                    ),
                  ]),
                ),
                Container(
                  alignment: Alignment.center,
                  width: width * .125,
                  height: height * .06,
                  decoration: BoxDecoration(
                    color: black.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ScreenFavorites(),
                      ));
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
