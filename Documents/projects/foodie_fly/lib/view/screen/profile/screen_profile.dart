import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/profile/profile_bloc.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/strings.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/address/screen_address.dart';
import 'package:foodie_fly/view/screen/home/widgets/section_head.dart';
import 'package:foodie_fly/view/screen/profile/widgets/dialog_box.dart';
import 'package:foodie_fly/view/screen/profile/widgets/sub_text.dart';
import 'package:foodie_fly/view/screen/profile/widgets/updat_profile.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/profile_span.dart';
import 'package:foodie_fly/view/widgets/class_widgets/string_genarator.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    context.read<ProfileBloc>().add(GetProfileEvent());
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBarWidget(title: 'Profile'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade200,
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 2)),
                          width: size * 7 / 10,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kHight10,
                                ProfileSpanText(
                                  indicateText: 'Seller Fast Name:  ',
                                  valueText:
                                      state.profile?.firstName ?? 'First Name',
                                ),
                                kHight10,
                                ProfileSpanText(
                                  indicateText: "Seller Last Name:  ",
                                  valueText:
                                      state.profile?.lastName ?? "Lastname",
                                ),
                                kHight10,
                                ProfileSpanText(
                                  indicateText: "Email:  ",
                                  valueText: state.profile?.email ?? "Email",
                                ),
                                kHight10,
                                ProfileSpanText(
                                  indicateText: "Phone Number:  ",
                                  valueText:
                                      state.profile?.phone ?? "Phone Number",
                                ),
                                kHight10,
                                ProfileSpanText(
                                  indicateText: "Status:  ",
                                  valueText: (state.profile?.status ?? "Status")
                                      .toString(),
                                ),
                                kHight10,
                                ProfileSpanText(
                                  indicateText: "User Id:  ",
                                  valueText: state.profile?.userId.toString() ??
                                      "User Id",
                                ),
                                kHight10,
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ScreenUpdateProfile(
                                      profile: state.profile!),
                                ),
                              );
                            },
                            child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25),
                                    ),
                                    color: yellowGreen),
                                child: const Text(
                                  "Edit",
                                  style: boldWhite,
                                ))),
                      ],
                    ),
                    divider3,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SectionHead(heading: 'Addresses'),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenAddresses(),
                                  ),
                                );
                              },
                              icon: CircleAvatar(
                                  backgroundColor:
                                      yellowGreen.withOpacity(0.25),
                                  child:
                                      const Icon(CupertinoIcons.right_chevron)),
                            )
                          ],
                        ),
                        const SubText(
                          text: 'Edit & Add new addresses',
                        ),
                        kHight10,
                        divider3,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SectionHead(heading: 'About Us'),
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
                                  backgroundColor:
                                      yellowGreen.withOpacity(0.25),
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
                            const SectionHead(heading: 'Terms & Contention'),
                            IconButton(
                              onPressed: () {
                                           Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                          StringGenarator(string: termsAndConditions)
                      ),
                    );
                              },
                              icon: CircleAvatar(
                                  backgroundColor:
                                      yellowGreen.withOpacity(0.25),
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
                            const SectionHead(heading: 'Privacy & Policy '),
                            IconButton(
                              onPressed: () {
                                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                          StringGenarator(string: privacyAndPolicy)
                      ),
                    );
                              },
                              icon: CircleAvatar(
                                  backgroundColor:
                                      yellowGreen.withOpacity(0.25),
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
                            const SectionHead(heading: 'LogOut'),
                            IconButton(
                              onPressed: () async {
                                showDialogBox(context);
                              },
                              icon: CircleAvatar(
                                  backgroundColor:
                                      yellowGreen.withOpacity(0.25),
                                  child: const Icon(
                                    CupertinoIcons.right_chevron,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
