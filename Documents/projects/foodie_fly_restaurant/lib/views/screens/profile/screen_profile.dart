import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/profile/profile_bloc.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/strings.dart';
import 'package:foodie_fly_restaurant/views/screens/profile/widgets/dialog_box.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/section_head.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/string_genarator.dart';

import '../../widgets/class_widgets/profile_span_text.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    context.read<ProfileBloc>().add(GetProfileEvent());
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBarWidget(title: "Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(
                      width: size * 10 / 10,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 1, color: yellow)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              kHight20,
                              ProfileSpanText(
                                indicateText: 'Restaurant Name:  ',
                                valueText: state.profile?.name ?? 'Name',
                              ),
                              kHight10,
                              ProfileSpanText(
                                indicateText: "Description:  ",
                                valueText:
                                    state.profile?.description ?? "Description",
                              ),
                              kHight10,
                              ProfileSpanText(
                                indicateText: "Email:  ",
                                valueText: state.profile?.email ?? "Email",
                              ),
                              kHight10,
                              ProfileSpanText(
                                indicateText: "Pin Code:  ",
                                valueText: state.profile?.pinCode ?? "Pin Code",
                              ),
                              kHight10,
                              ProfileSpanText(
                                indicateText: "Seller Id:  ",
                                valueText:
                                    "${state.profile?.sellerId ?? "Seller Id"}"
                                        .toString(),
                              ),
                              kHight10,
                              ProfileSpanText(
                                indicateText: "Seller Status:  ",
                                valueText:
                                    state.profile?.status ?? "Seller Status",
                              ),
                              kHight10,
                            ],
                          ),
                        ),
                      ),
                    ),
                    kHight20,
                  ],
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionHead(
                  heading: 'About Us',
                  values: '',
                ),
                IconButton(
                  onPressed: () {
                      Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                          StringGenarator(string: aboutUs)
                      ),
                    );
                  },
                  icon: CircleAvatar(
                      backgroundColor: yellow.withOpacity(0.25),
                      child: const Icon(
                        CupertinoIcons.right_chevron,
                      )),
                ),
              ],
            ),
            divider3,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionHead(
                  heading: 'Terms & Contention',
                  values: '',
                ),
                IconButton(
                  onPressed: () {
                      Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                          StringGenarator(string: termsAndContitions)
                      ),
                    );
                  },
                  icon: CircleAvatar(
                      backgroundColor: yellow.withOpacity(0.25),
                      child: const Icon(
                        CupertinoIcons.right_chevron,
                      )),
                ),
              ],
            ),
            divider3,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionHead(
                  heading: 'Privacy & Policy ',
                  values: '',
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                          StringGenarator(string: privacyAndpolicy)
                      ),
                    );
                  },
                  icon: CircleAvatar(
                      backgroundColor: yellow.withOpacity(0.25),
                      child: const Icon(
                        CupertinoIcons.right_chevron,
                      )),
                ),
              ],
            ),
            divider3,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionHead(
                  heading: 'LogOut',
                  values: '',
                ),
                IconButton(
                  onPressed: () async {
                    showDialogBOx(context);
                  },
                  icon: CircleAvatar(
                      backgroundColor: yellow.withOpacity(0.25),
                      child: const Icon(
                        CupertinoIcons.right_chevron,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
