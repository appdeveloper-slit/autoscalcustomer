import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quick_room_services/manage/static_method.dart';
import 'package:quick_room_services/values/colors.dart';
import 'package:quick_room_services/values/dimens.dart';
import 'package:quick_room_services/values/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'otp_verification.dart';
import 'values/global_urls.dart';

void main() => runApp(ForgetPassword());

class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late BuildContext ctx;

  TextEditingController forgotMobileNumberController = TextEditingController();

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
            child: Column(children: [
              SizedBox(
                height: 5,
              ),
              Text(
                'Forgot Password',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    foreground: Paint()
                      ..shader = Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Mobile Number',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w500))),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: forgotMobileNumberController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  // label: Text('Enter Your Number'),
                  hintText: "Enter Mobile Number",
                  counterText: "",

                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Clr().black,
                  )),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () async {
                  load(context);
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  var dio = Dio();
                  final formdata = FormData.fromMap({
                    "mobile": forgotMobileNumberController.text,
                    "page_type": "forgot_password"
                  });
                  var response = await dio.post(sendOTPUrl(), data: formdata);
                  if (globalDebugMode()) {
                    print(response);
                  }
                  final result = response.data;
                  dismissLoad(context);

                  if (result['error'] != true) {
                    STM().redirect2page(
                        context,
                        OTPVerification(
                            "",
                            "",
                            forgotMobileNumberController.text.toString(),
                            "forgot_password"));
                  } else {
                    errorAlert(context, result['message'].toString());
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
                    'Send OTP',
                    style: Sty().mediumText.copyWith(
                          color: Clr().white,
                        ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
