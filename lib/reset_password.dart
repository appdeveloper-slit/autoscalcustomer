import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_room_services/SignIn.dart';
import 'package:quick_room_services/values/colors.dart';
import 'package:quick_room_services/values/dimens.dart';
import 'package:quick_room_services/values/strings.dart';
import 'package:quick_room_services/values/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'manage/static_method.dart';
import 'values/global_urls.dart';

// void main() => runApp(ResetPassword());

class ResetPassword extends StatefulWidget {

  String? mobileNumber;
  ResetPassword(this.mobileNumber);

  @override
  State<ResetPassword> createState() => _ResetPasswordState(mobileNumber);
}

class _ResetPasswordState extends State<ResetPassword> {

  String? mobileNumber;
  _ResetPasswordState(this.mobileNumber);

  late BuildContext ctx;
  bool isHidden = true, isHidden2 = true;
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController cnfPasswordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void setNewPasswordInForgot() async {

    load(context);
      SharedPreferences sp = await SharedPreferences.getInstance();
      var dio = Dio();
      final formdata = FormData.fromMap({
        "mobile": mobileNumber.toString(),
        "password":passwordCtrl.text.toString()
      });
      var response = await dio.post(forgotPassUrl(), data: formdata);
      if(globalDebugMode()){
      print(response);
      }
      final result = response.data;
      dismissLoad(context);
      if(result['error'] != true){
        STM().gotoPage(context, SignIn());
      }
      else{
        errorAlert(context, result['message'].toString());
      }
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
                    ))),
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
                            'Reset Password',
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
                              child: Text('Create Password',
                                  style: Sty()
                                      .largeText
                                      .copyWith(fontWeight: FontWeight.w500))),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: passwordCtrl,
                            cursorColor: Clr().primaryColor,
                            style: Sty().mediumText.copyWith(
                              color: Clr().grey,
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isHidden,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Clr().black,
                                  )),
                              hintStyle: Sty().mediumText.copyWith(
                                color: Clr().lightGrey,
                              ),
                              hintText: "New Password",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: InkWell(
                                  child: Icon(
                                    isHidden
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.grey,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      isHidden ^= true;
                                    });
                                  },
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'(.{6,})').hasMatch(value)) {
                                return Str().invalidPassword;
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Confirm Password',
                                  style: Sty()
                                      .largeText
                                      .copyWith(fontWeight: FontWeight.w500))),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: cnfPasswordCtrl,
                            cursorColor: Clr().primaryColor,
                            style: Sty().mediumText.copyWith(
                                  color: Clr().grey,
                                ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isHidden2,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Clr().black,
                                  )),
                              hintStyle: Sty().mediumText.copyWith(
                                    color: Clr().lightGrey,
                                  ),
                              hintText: "Confirm Password",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: InkWell(
                                  child: Icon(
                                    isHidden2
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.grey,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      isHidden2 ^= true;
                                    });
                                  },
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || passwordCtrl.text != value) {
                                return Str().passwordNotMatch;
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
                                vertical: Dim().d16, horizontal: Dim().d32),
                            decoration: BoxDecoration(
                              gradient: Sty().linearGradient,
                              borderRadius: BorderRadius.circular(
                                Dim().d4,
                              ),
                            ),
                            margin: EdgeInsets.all(20),
                            child: InkWell(
                              onTap: () {
                                // STM().redirect2page(ctx, SignIn());
                                if(formKey.currentState!.validate()){
                                  setNewPasswordInForgot();
                                }
                                
                              },
                              child: Text(
                                'Reset Password',
                                style: Sty().mediumText.copyWith(
                                      color: Clr().white,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ))));
  }
}
