// import 'package:flutter/material.dart';
// import 'package:foodie_fly/utils/constants.dart';
// import 'package:foodie_fly/utils/text_styles.dart';

// class DemoUser extends StatelessWidget {
//   const DemoUser({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         const Text(
//           "Demo User",
//           style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: grey,
//               decoration: TextDecoration.underline),
//         ),
//         textSpanWidget(
//           blackText: 'Email-address: ',
//           orangeText: 'kalad@gmail.com',
//         ),
//         textSpanWidget(
//           blackText: 'Password: ',
//           orangeText: 'Kalad@123',
//         ),
//       ],
//     );
//   }

//   Text textSpanWidget({required String blackText, required String orangeText}) {
//     return Text.rich(
//       TextSpan(
//         children: [
//           TextSpan(text: blackText, style: semiBoldGrey),
//           TextSpan(text: orangeText, style: semiBoldGrey)
//         ],
//       ),
//     );
//   }
// }
