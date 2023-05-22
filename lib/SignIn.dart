import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quick_room_services/forgot_password.dart';
import 'package:quick_room_services/manage/static_method.dart';
import 'package:quick_room_services/values/colors.dart';
import 'package:quick_room_services/values/dimens.dart';
import 'package:quick_room_services/values/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Register.dart';
import 'bn_home.dart';
import 'values/global_urls.dart';

void main() => runApp(SignIn());

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late BuildContext ctx;
  TextEditingController userMobile = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isHidden = true;

  void userLogin() async {
    load(context);
    SharedPreferences sp = await SharedPreferences.getInstance();
    var dio = Dio();
    final formdata = FormData.fromMap({
      "mobile": userMobile.text,
      "password": userPassword.text
    });
    var response = await dio.post(signInUrl(), data: formdata);
    if(globalDebugMode()){
    print(response);
    }
    final result = response.data;
    dismissLoad(context);
    if(result['error'] != true){
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString("user_id", result['user']['id'].toString());
      sp.setString("user_name", result['user']['name'].toString());
      sp.setString("user_email", result['user']['email'].toString());
      sp.setString("user_mobile", result['user']['mobile'].toString());
      // sp.setString("user_email", result['user']['email'].toString());
      setLoginTrue();
      STM().gotoPage(context, Home());
    }
    else{
      errorAlert(context, result['message'].toString());
    }
  }


    @override
  void initState() {
    checkLoginAndGotoHome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Cars Doctor'),
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dim().d16),
            child: Form(
              key:formkey,
              child: Column(children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  'Welcome Back',
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
                    child: Text('Enter Mobile Number',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w500))),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: userMobile,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.length == 10 && value.isNotEmpty){
                    }
                    else{
                      return "Please enter valid mobile number";
                    }
                  },
                  decoration: InputDecoration(
                    counterText: "",
                    contentPadding: EdgeInsets.all(8),
                    // label: Text('Enter Your Number'),
                    hintText: "Enter Mobile Number",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Clr().black,
                    )),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Password',
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.w500))),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: userPassword,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: isHidden,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter password";
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    // label: Text('Enter Your Number'),
                    hintText: "Enter Your password",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Clr().black,
                    )),
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
                ),
                SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      STM().redirect2page(ctx, ForgetPassword());
                    },
                    child: RichText(
                        text: TextSpan(
                            text: 'Forgot Password?',
                            style: Sty().mediumBoldText.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xFF69A9F0)))),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      // STM().redirect2page(ctx, Home());
                      // Login with this...
                      if(formkey.currentState!.validate()){
                         userLogin();
                      }
                     
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dim().d16, horizontal: Dim().d60),
                      decoration: BoxDecoration(
                        gradient: Sty().linearGradient,
                        borderRadius: BorderRadius.circular(
                          Dim().d4,
                        ),
                      ),
                      margin: EdgeInsets.all(0),
                      child: Text(
                        'Login',
                        style: Sty().mediumText.copyWith(
                              color: Clr().white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                            ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    STM().redirect2page(ctx, Register());
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Don’t have an account? ',
                      style: Sty().smallText.copyWith(
                        fontSize: 16,
                            fontWeight: FontWeight.w400
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign Up',
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
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
