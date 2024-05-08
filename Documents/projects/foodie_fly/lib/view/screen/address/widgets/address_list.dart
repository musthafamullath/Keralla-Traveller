
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:foodie_fly/controller/blocs/address/address_bloc.dart';
// import 'package:foodie_fly/utils/constants.dart';
// import 'package:foodie_fly/view/screen/add_address/screen_add_address.dart';
// import 'package:foodie_fly/view/screen/home/widgets/section_head.dart';
// import 'package:foodie_fly/view/widgets/class_widgets/button_widget.dart';

// class AddressList extends StatelessWidget {
//   const AddressList({super.key, required this.width, required this.length});

//   final double width;
//   final int length;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 500,
//       child: Expanded(
//         child: ListView.builder(
//           shrinkWrap: true,
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: () {
//                 context.read<AddressBloc>().add(SelectAddressEvent(index: index));
//               },
//               child: BlocBuilder<AddressBloc, AddressState>(
//                 builder: (context, state) {
//                   return Container(
//                     margin: const EdgeInsets.symmetric(vertical: 4),
//                     padding: const EdgeInsets.all(12),
//                     width: width,
//                     // height: width * .2,
//                     decoration: BoxDecoration(
//                       color: state.index == index ? Colors.grey[300] : Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: Colors.green),
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 const Icon(Icons.location_on_outlined,
//                                     size: 24, color: Colors.red),
//                                 SectionHead(heading: state.addresses[index].name),
//                               ],
//                             ),
//                             ButtonWidget(
//                               width: width *9/10,
//                               text: 'Change',
//                               onPressed: () {
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                     builder: (context) => ScreenAddAddress(
//                                       operation: Operation.edit,
//                                       address: state.addresses[index],
//                                     ),
//                                   ),
//                                 );
//                               }, height: width *2/10,
//                             )
//                           ],
//                         ),
//                         kHight10,
//                         Text(
//                           '${state.addresses[index].houseName},  ${state.addresses[index].street},  ${state.addresses[index].pinCode},  ${state.addresses[index].district},  ${state.addresses[index].state}, ${state.addresses[index].phone}',
//                           style:const TextStyle(fontSize: 18),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             );
//           },
//           itemCount: length,
//         ),
//       ),
//     );
//   }
// }
