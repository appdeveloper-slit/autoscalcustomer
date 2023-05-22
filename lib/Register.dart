import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quick_room_services/SignIn.dart';
import 'package:quick_room_services/otp_verification.dart';
import 'package:quick_room_services/values/colors.dart';
import 'package:quick_room_services/values/dimens.dart';
import 'package:quick_room_services/values/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validators/validators.dart';
import 'manage/static_method.dart';
import 'otp_verification2.dart';
import 'values/global_urls.dart';

void main() => runApp(Register());

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    final Uri _urlterms = Uri.parse('https://leadstoclient.tech/TCD/terms');
    TextEditingController userFullName = TextEditingController();
    TextEditingController userEmailId = TextEditingController();
    TextEditingController userMobileNumber = TextEditingController();
    final formkey = GlobalKey<FormState>();

    Future<void> _launchUrl(url) async {
      if (!await launchUrl(url)) {
        throw 'Could not launch $url';
      }
    }
    void userSignUp() async {
      load(context);
      SharedPreferences sp = await SharedPreferences.getInstance();
      var dio = Dio();
      final formdata = FormData.fromMap({
        "mobile": userMobileNumber.text,
        "page_type": "register"
      });
      var response = await dio.post(sendOTPUrl(), data: formdata);
      if(globalDebugMode()){
      print(response);
      }
      final result = response.data;
      dismissLoad(context);

      if(result['error'] != true){
        STM().redirect2page(context, OTPVerification(userFullName.text.toString(), userEmailId.text.toString(), userMobileNumber.text.toString(), "register"));
      }
      else{
        errorAlert(context, result['message'].toString());
      }
    }

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
                  key: formkey,
                  child: Padding(
                      padding: EdgeInsets.all(Dim().d16),
                      child: Column(children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Register',
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
                            child: Text('Full Name',
                                style: Sty()
                                    .largeText
                                    .copyWith(fontWeight: FontWeight.w500))),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: userFullName,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter name";
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            // label: Text('Enter Your Number'),
                            hintText: "Enter Full Name",
                
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Clr().black,
                            )),
                          ),
                        ),
                
                
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Email ID',
                                style: Sty()
                                    .largeText
                                    .copyWith(fontWeight: FontWeight.w500))),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: userEmailId,
                          validator: (value){
                            if(isEmail(value.toString())){
                            }
                            else{
                              return "Please enter a valid email.";
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            // label: Text('Enter Your Number'),
                            hintText: "Enter Your Email ID",
                
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Clr().black,
                                )),
                          ),
                        ),
                
                
                        SizedBox(
                          height: 20,
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
                          controller: userMobileNumber,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          validator:(value) {
                            if(value!.length != 10){
                              return "Please enter your valid mobile number";
                            }
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.all(8),
                            // label: Text('Enter Your Number'),
                            hintText: "Enter Your Mobile Number",
                
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Clr().black,
                                )),
                          ),
                        ),
                        SizedBox(height: 8,),
                        GestureDetector(
                          onTap: () {
                            // STM().redirect2page(ctx, Register());
                            launchUrl(_urlterms);
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                text: 'By continuing I agree to ',
                                style: Sty().smallText.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: Sty().smallText.copyWith(
                                      color: Color(0xFF69A9F0),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: InkWell(
                            onTap: () {
                              if(formkey.currentState!.validate()){
                                userSignUp();
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
                        ),
                        GestureDetector(
                          onTap: () {
                            STM().redirect2page(ctx, SignIn());
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Already have an account?',
                              style: Sty().smallText.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Sign In',
                                  style: Sty().smallText.copyWith(
                                    color: Color(0xFF69A9F0),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ])),
                ))));
  }
}
