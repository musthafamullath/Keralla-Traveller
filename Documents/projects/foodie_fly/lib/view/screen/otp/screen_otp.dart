// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:foodie_fly/controller/api_sevices/sign_up_login/api_calling.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/screen/main/screen_main_page.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/button_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/text_btn_widget.dart';
import 'package:foodie_fly/view/widgets/function_widgets/snackbar.dart';

class ScreenOTP extends StatefulWidget {
  const ScreenOTP({super.key});

  @override
  State<ScreenOTP> createState() => _ScreenOTPState();
}

class _ScreenOTPState extends State<ScreenOTP> {
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNode = List.generate(6, (index) => FocusNode());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBarWidget(
          title: "Verify OTP",
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: width*10/10,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(width: 2,color: Colors.grey.shade300),
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
              kHight20,
                const Text(
                  "Verify Phone Number",
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                ),
                kHight20,
                const Text(
                  'We have sent you a 6 digit code. Please enter here to verify your number.',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                ),
                kHight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                    (index) {
                      return Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: width * .05),
                            alignment: Alignment.center,
                            width: width * .125,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2,color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: controllers[index],
                              focusNode: focusNode[index],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '';
                                }
                                return '';
                              },
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  FocusScope.of(context)
                                      .requestFocus(focusNode[index+1]);
                                }
                              },
                              decoration:
                                  const InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                kHight20,
                TextButtonWidget(
                  width: width,
                  text: 'Didn’t get the code? Resend code',
                  onPressed: () {},
                ),
                kHight20,
                Container(
                  alignment: Alignment.center,
                  child: ButtonWidget(
                    width: width,
                    height: width * 3 / 10,
                    text: 'Verify',
                    onPressed: () async {
                      String otp = '';
                      for (int i = 0; i < controllers.length; i++) {
                        if (formKey.currentState!.validate()) {
                          otp += controllers[i].text;
                        }
                      }
                      bool value =
                          await ApiAuthentication().otpVerification(otp) as bool;
                      
                      if (value) {
                       
                        showSnack(context, kGreen, 'Account created successfully');
                         
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ScreenMainPage(),
                        ));
                      } else {
                        showSnack(context, red, 'Invalid OTP');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
