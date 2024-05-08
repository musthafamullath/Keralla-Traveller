import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/cart/cart_bloc.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/coupens/widgets/coupen_list.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';

class ScreenCoupons extends StatelessWidget {
  const ScreenCoupons({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    context.read<CartBloc>().add(GetAvailableCouponsEvent());
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBarWidget(title: 'Coupons Fun!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<CartBloc, CartState>(
          buildWhen: (previous, current) => current is GetAllCouponsState,
          builder: (context, state) {
            if (state is GetAllCouponsState) {
              return state.coupons.isEmpty
                  ? const Center(child: Text("NO Coupens",style: bigBoldBlack,))
                  : CouponList(
                      height: height, width: width, coupons: state.coupons);
            } else {
              return const Center(
                child: Text('No data'),
              );
            }
          },
        ),
      ),
    );
  }
}
