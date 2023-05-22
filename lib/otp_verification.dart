import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quick_room_services/create_password.dart';
import 'package:quick_room_services/manage/static_method.dart';
import 'package:quick_room_services/reset_password.dart';
import 'package:quick_room_services/values/colors.dart';
import 'package:quick_room_services/values/dimens.dart';
import 'package:quick_room_services/values/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'values/global_urls.dart';

// void main() => runApp(OTPVerification());

class OTPVerification extends StatefulWidget {
  String? name;
  String? email;
  String? mobileNumber;
  String? pageType;

  OTPVerification(this.name, this.email, this.mobileNumber, this.pageType);
  @override
  State<OTPVerification> createState() => _OTPVerificationState(name, email, mobileNumber, pageType);
}

class _OTPVerificationState extends State<OTPVerification> {
  late BuildContext ctx;
  String? name;
  String? email;
  String? mobileNumber;
  String? pageType;
  _OTPVerificationState(this.name, this.email, this.mobileNumber, this.pageType);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController otpCtrl = TextEditingController();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();


  void resendOTP() async {
    if(pageType == "register"){
      load(context);
      SharedPreferences sp = await SharedPreferences.getInstance();
      var dio = Dio();
      final formdata = FormData.fromMap({
        "mobile": mobileNumber.toString(),
        "page_type": "register"
      });
      var response = await dio.post(resendOTPUrl(), data: formdata);
      if(globalDebugMode()){
      print(response);
      }
      final result = response.data;
      dismissLoad(context);
      if(result['error'] != true){
        alert(context, result['message'].toString());
      }
      else{
        errorAlert(context, result['message'].toString());
      }
    }
    else if(pageType == "forgot_password"){
      load(context);
      SharedPreferences sp = await SharedPreferences.getInstance();
      var dio = Dio();
      final formdata = FormData.fromMap({
        "mobile": mobileNumber.toString(),
        "page_type": "forgot_password"
      });
      var response = await dio.post(resendOTPUrl(), data: formdata);
      if(globalDebugMode()){
      print(response);
      }
      final result = response.data;
      dismissLoad(context);

      if(result['error'] != true){
        alert(context, result['message'].toString());
      }
      else{
        errorAlert(context, result['message'].toString());
      }
    }
    else{

    }
  }



  void verifyOTP() async {
    if(pageType == "register"){
      load(context);
      SharedPreferences sp = await SharedPreferences.getInstance();
      var dio = Dio();
      final formdata = FormData.fromMap({
        "mobile": mobileNumber.toString(),
        "otp": otpCtrl.text
      });
      var response = await dio.post(verifyOTPUrl(), data: formdata);
      if(globalDebugMode()){
      print(response);
      }
      final result = response.data;
      dismissLoad(context);

      if(result['error'] != true){
        STM().redirect2page(context, CreatePassword(name, email, mobileNumber));
      }
      else{
        errorAlert(context, result['message'].toString());
      }
    }
    else if(pageType == "forgot_password"){
      load(context);
      SharedPreferences sp = await SharedPreferences.getInstance();
      var dio = Dio();
      final formdata = FormData.fromMap({
        "mobile": mobileNumber.toString(),
        "otp": otpCtrl.text
      });
      var response = await dio.post(verifyOTPUrl(), data: formdata);
      if(globalDebugMode()){
      print(response);
      }
      final result = response.data;
      dismissLoad(context);

      if(result['error'] != true){
        STM().redirect2page(context, ResetPassword(mobileNumber));
      }
      else{
        errorAlert(context, result['message'].toString());
      }

    }
    else{

    }
  }





  bool sendload = true;
  var periodicTimer;
  int totaltime = 60;
  bool resendEnabled = false;
  bool shouldStop = true;

  void resetTimer() {
    setState(() {
      totaltime = 60;
      resendEnabled = false;
      shouldStop = true;
    });
  }

  void resendOtpTimer() {
    shouldStop = false;

    periodicTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Update user about remaining time
      setState(() {
        if (timer.isActive) {
          if(globalDebugMode()){
          print("Timer Active...");
          }
          if (shouldStop) {
            timer.cancel();
          }
        }
        if (totaltime <= 0) {
          resendEnabled = true;
          shouldStop = true;
          totaltime = 0;
        } else {
          totaltime--;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if(globalDebugMode()){
    print("[i] Disposing timer periodic....");
    }
    periodicTimer?.cancel();
    if(globalDebugMode()){
    print("[+] Dispose executed...");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    resendOtpTimer();
    super.initState();
  }

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
                child: Form(
                  key: formKey,
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
                                  'We’ve sent you the verification code on $mobileNumber',
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
                                return "Enter an OTP";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            child: InkWell(
                              onTap: () {
                                // STM().redirect2page(ctx, ResetPassword());
                                if(formKey.currentState!.validate()){
                                  verifyOTP();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dim().d16, horizontal: Dim().d52),
                                decoration: BoxDecoration(
                                  gradient: Sty().linearGradient,
                                  borderRadius: BorderRadius.circular(
                                    Dim().d4,
                                  ),
                                ),
                                margin: EdgeInsets.all(0),
                                child: Text(
                                  'Continue',
                                  style: Sty().mediumText.copyWith(
                                        color: Clr().white,
                                      ),
                                ),
                              ),
                            ),
                          ),
                         if(!resendEnabled) Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                // STM().redirect2page(ctx, ForgetPassword());
                              },
                              child:  RichText(
                                  text: TextSpan(
                                      text: (totaltime == 60) ? '01:00' : (totaltime < 10) ? '00:0$totaltime' : '00:$totaltime',
                                      style: Sty().mediumBoldText.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF69A9F0)))),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          if(resendEnabled) GestureDetector(
                            onTap: () {
                              // STM().redirect2page(ctx, ForgetPassword());
                              resendOTP();
                              resetTimer();
                              resendOtpTimer();
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
                                        color: Color(0xFF69A9F0),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ))));
  }
}
