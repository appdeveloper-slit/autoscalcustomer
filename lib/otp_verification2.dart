import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quick_room_services/manage/static_method.dart';
import 'package:quick_room_services/reset_password.dart';
import 'package:quick_room_services/values/colors.dart';
import 'package:quick_room_services/values/dimens.dart';
import 'package:quick_room_services/values/styles.dart';

import 'create_password.dart';

void main() => runApp(OTPVerification2());

class OTPVerification2 extends StatefulWidget {
  @override
  State<OTPVerification2> createState() => _OTPVerification2State();
}

class _OTPVerification2State extends State<OTPVerification2> {
  late BuildContext ctx;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController otpCtrl = TextEditingController();

  StreamController<ErrorAnimationType> errorController =
  StreamController<ErrorAnimationType>();

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Clr().transparent,
              leading: InkWell(
                  onTap: () {
                    STM().back2Previous(ctx);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xffE48260),
                  )),
            ),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(Dim().d16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Verification',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              foreground: Paint()
                                ..shader = Sty().linearGradient.createShader(
                                    Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                'We’ve sent you the verification code on 62003237631',
                                style: Sty()
                                    .largeText
                                    .copyWith(fontWeight: FontWeight.w400))),
                        SizedBox(
                          height: 30,
                        ),
                        PinCodeTextField(
                          controller: otpCtrl,
                          errorAnimationController: errorController,
                          appContext: context,
                          enableActiveFill: true,
                          textStyle: Sty().largeText,
                          length: 4,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          animationType: AnimationType.scale,
                          cursorColor: Clr().primaryColor,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(Dim().d4),
                            fieldWidth: Dim().d60,
                            fieldHeight: Dim().d56,
                            selectedFillColor: Clr().transparent,
                            activeFillColor: Clr().transparent,
                            inactiveFillColor: Clr().transparent,
                            inactiveColor: Clr().lightGrey,
                            activeColor: Clr().black,
                            selectedColor: Clr().lightGrey,
                          ),
                          animationDuration: const Duration(milliseconds: 200),
                          onChanged: (value) {},
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'(.{4,})').hasMatch(value)) {
                              return "";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Dim().d16, horizontal: Dim().d52),
                          decoration: BoxDecoration(
                            gradient: Sty().linearGradient,
                            borderRadius: BorderRadius.circular(
                              Dim().d4,
                            ),
                          ),
                          margin: EdgeInsets.all(20),
                          child: InkWell(
                            onTap: () {
                              // STM().redirect2page(ctx, CreatePassword());
                            },
                            child: Text(
                              'Continue',
                              style: Sty().mediumText.copyWith(
                                color: Clr().white,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              // STM().redirect2page(ctx, ForgetPassword());
                            },
                            child: RichText(
                                text: TextSpan(
                                    text: '00:20',
                                    style: Sty().mediumBoldText.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF2D135B)))),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            // STM().redirect2page(ctx, ForgetPassword());
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Didn't get it?",
                              style: Sty().smallText.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Resend OTP',
                                  style: Sty().smallText.copyWith(
                                      color: Color(0xFF2D135B),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )))));
  }
}
