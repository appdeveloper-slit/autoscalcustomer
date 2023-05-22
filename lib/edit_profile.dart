import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quick_room_services/values/global_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

import 'bn_profile.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

// void main() => runApp(EditProfile());

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late BuildContext ctx;

  
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final updateForm = GlobalKey<FormState>();
  


  TextEditingController updateUserMobileNumberController = TextEditingController();
  TextEditingController updateUserOtpController = TextEditingController();
  // change update state to send otp and vice versa
  void updateMobileNumber(){
    bool otpsend = false;
    updateUserMobileNumberController.text = "";
    updateUserOtpController.text = "";
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
              title: ShaderMask(
                 shaderCallback: (bounds) => Sty().linearGradient.createShader(
          Rect.fromLTWH(0.0, 0.0, 50.0, 15.0)),
                child: Text("Change Mobile Number", style: TextStyle(color: Colors.white))),
              content: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: !otpsend,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [SizedBox(
                          height: 20,
                        ),
                        Text(
                          "New Mobile Number",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.only(left:10, right: 10),
                          child: TextFormField(
                            controller: updateUserMobileNumberController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration: InputDecoration(
                              counterText: "",
                              hintText: "Enter Mobile Number",
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 50, minHeight: 0),
                              suffixIconConstraints:
                                  BoxConstraints(minWidth: 10, minHeight: 2),
                              border: InputBorder.none,
                              // prefixIcon: Icon(
                              //   Icons.phone,
                              //   size: iconSizeNormal(),
                              //   color: primary(),
                              // ),
                            ),
                          ),
                        ),],)),

                        Visibility(
                          visible: otpsend,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [SizedBox(
                          height: 20,
                        ),
                        Text(
                          "One Time Password",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.only(left:10, right: 10),
                          child: TextFormField(
                            controller: updateUserOtpController,

                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            decoration: InputDecoration(
                              counterText: "",
                              hintText: "Enter OTP",
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 50, minHeight: 0),
                              suffixIconConstraints:
                                  BoxConstraints(minWidth: 10, minHeight: 2),

                              border: InputBorder.none,
                              prefixIcon: ShaderMask(
                                 shaderCallback: (bounds) => Sty().linearGradient.createShader(
          Rect.fromLTWH(0.0, 0.0, 50.0, 15.0)),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                              
                                ),
                              ),
                            ),
                          ),
                        ),],)),
                        
                      ]),
                ),
              ),
              elevation: 0,
              actions: [
                Row(
                  children: [
                    Visibility(
                      visible: !otpsend,
                      child: Expanded(
                        child: InkWell(
                            onTap: () async {
                              if(updateUserMobileNumberController.text.toString().isNotEmpty && isLength(updateUserMobileNumberController.text.toString(), 10)){
                              // API UPDATE START
                              SharedPreferences sp = await SharedPreferences.getInstance();
                              load(context);
                              var dio = Dio();
                              final formdata = FormData.fromMap({
                                "mobile": updateUserMobileNumberController.text.toString(),
                                "page_type": "update_mobile"
                              });
                              var response = await dio.post(sendOTPUrl(), data: formdata);
                              if (globalDebugMode()) {
                                print(response);
                              }
                              final result = response.data;
                              dismissLoad(context);
                              if(result['error'] != true){                       
                                setState((){
                                otpsend = true; 
                                });
                              }
                              else{
                                errorAlert(context, result['message']);
                              }
                              
                              
                              // API UPDATE END
                              }
                              else{
                                alert(context, "Please enter mobile number in order to continue.");
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  gradient: Sty().linearGradient,
                              ),
                              child: Center(child: Text("Send OTP", style:TextStyle(color: Colors.white))))),
                      ),
                    ),
                    Visibility(
                      visible: otpsend,
                      child: Expanded(
                        child: InkWell(
                            onTap: () async {
                              if(updateUserOtpController.text.toString().isNotEmpty && isLength(updateUserOtpController.text.toString(), 4)){
                              // API UPDATE START
                              SharedPreferences sp = await SharedPreferences.getInstance();
                              load(context);
                              var dio = Dio();
                              final formdata = FormData.fromMap({
                                "otp": updateUserOtpController.text.toString(),
                                "mobile" : updateUserMobileNumberController.text.toString(),
                                "user_id" : sp.getString("user_id").toString(),
                              });
                              var response = await dio.post(changeMobileNumberUrl(), data: formdata);
                              if (globalDebugMode()) {
                                print(response);
                              }
                              final result = response.data;
                              dismissLoad(context);

                              if(result['error'] != true){
                                bottomAlert(context, result['message']);
                                mobile.text = updateUserMobileNumberController.text.toString();
                                Navigator.pop(context);
                              }
                              else{
                                errorAlert(context, result['message']);
                              }
                              
                              // API UPDATE END
                              }
                              else{
                                alert(context, "Please enter OTP in order to continue.");
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  gradient: Sty().linearGradient,
                              ),
                              child: Center(child: Text("Update", style: TextStyle(color: Colors.white),)))),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  gradient: Sty().linearGradient,
                              ),
                            child: Center(child: Text("Cancel", style: TextStyle(color: Colors.white))))),
                    ),
                  ],
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            ),
          );
        });
  }























  TextEditingController updateUserPasswordController = TextEditingController();
  TextEditingController updateUserPassword2Controller = TextEditingController();
  void updatePassword() async {
    bool passwordTextVisible = false;
    bool passwordText2Visible = false;
    updateUserPasswordController.text = "";
    updateUserPassword2Controller.text = "";
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
              title: ShaderMask(
                shaderCallback: (bounds) => Sty().linearGradient.createShader(
          Rect.fromLTWH(0.0, 0.0, 50.0, 15.0)),
                child: Text("Update password", style: TextStyle(color: Colors.white))),
              content: SizedBox(
                height: 240,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "New Password",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.only(left:10, right: 10),
                          child: TextFormField(
                            controller: updateUserPasswordController,
                            obscureText: !passwordTextVisible,
                            decoration: InputDecoration(
                              hintText: "Enter New Password",
                              border: InputBorder.none,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    passwordTextVisible =
                                        passwordTextVisible == false
                                            ? true
                                            : false;
                                  });
                                },
                                child: Container(
                                  child: ShaderMask(
                                    shaderCallback: (bounds) => Sty().linearGradient.createShader(
          Rect.fromLTWH(0.0, 0.0, 50.0, 15.0)),
                                    child: Icon(
                                      passwordTextVisible
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Re-Enter New Password",
                        ),  
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.only(left:10, right: 10),
                          child: TextFormField(
                            controller: updateUserPassword2Controller,
                            obscureText: !passwordText2Visible,
                            decoration: InputDecoration(
                              hintText: "Re-Enter New Password",
                              border: InputBorder.none,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    passwordText2Visible =
                                        passwordText2Visible == false
                                            ? true
                                            : false;
                                  });
                                },
                                child: Container(
                                  child:  ShaderMask(
                                    shaderCallback: (bounds) => Sty().linearGradient.createShader(
          Rect.fromLTWH(0.0, 0.0, 50.0, 15.0)),
                                    child: Icon(
                                      passwordText2Visible
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              elevation: 0,
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: () async {
                            if(updateUserPasswordController.text.toString().isNotEmpty && isLength(updateUserPasswordController.text.toString(), 6) && (updateUserPasswordController.text.toString() == updateUserPassword2Controller.text.toString())){
                            // API UPDATE START
                            SharedPreferences sp =
                                await SharedPreferences.getInstance();

                            load(context);
                            var dio = Dio();
                            final formdata = FormData.fromMap({
                              "user_id": sp.getString("user_id").toString(),
                              "password":
                                  updateUserPasswordController.text.toString()
                            });
                            var response = await dio.post(updatePasswordUrl(),
                                data: formdata);
                            if (globalDebugMode()) {
                              print(response);
                            }
                            final result = response.data;
                            dismissLoad(context);

                            if (result['error'] != true) {
                              sp.setString("password",
                                  password.text.toString());
                              password.text =
                                  sp.getString("password")!;
                              bottomAlert(context, result['message']);
                              Navigator.of(context).pop();
                            } else {
                              errorAlert(context, result['message']);
                            }
                            // API UPDATE END
                            }
                            else{
                              alert(context, "Please enter new password, it must match and it should be at least 6 characters long.");
                            }
                          },
                          child: Container(
                            padding:EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              gradient: Sty().linearGradient,
                            ),
                            child: Center(child: Text("Update", style: TextStyle(color: Colors.white))))),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              gradient: Sty().linearGradient,
                            ),
                            child: Center(child: Text("Cancel", style: TextStyle(color: Colors.white))))),
                    ),
                  ],
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            ),
          );
        });
  }



  void getProfileData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if(await getLoginSession()){
      setState(() {
        name.text = sp.getString("user_name").toString();
        mobile.text = sp.getString("user_mobile").toString();
        email.text = sp.getString("user_email").toString(); 
        password.text = "******";
      });
    }
    else{
      // errorAlert(context, "Please login in order to continue");
      Navigator.pop(context);
    }
  }

  void updateProfile() async {
    load(context);
    SharedPreferences sp = await SharedPreferences.getInstance();
    var dio = Dio();
    var formData = FormData.fromMap({
      "user_id" : sp.getString("user_id").toString(),
      "name" : name.text,
      "email" : email.text
    });
    var response = await dio.post(editProfileUrl(), data: formData);
    if(globalDebugMode()){
    print(response);
    }
    final result = response.data;
    dismissLoad(context);    

    if(result['error'] != true){
      sp.setString("user_name", name.text.toString());
      sp.setString("user_email", email.text.toString());
      // alert(context, result['message'].toString());
      Navigator.pop(context);
      STM().replacePage(context, Profile());
    }
    else{
      errorAlert(context, result['message'].toString());
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, (){
      getProfileData();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ctx = context;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: bottomBarLayout(ctx, 0),
        appBar: AppBar(
          backgroundColor: Color(0xffffffff),
          leading: InkWell(
            onTap: () {
              STM().back2Previous(ctx);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffE48260),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                foreground: Paint()
                  ..shader = Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child:Form(
            key: updateForm,
            child: Column(
              children: [
                SizedBox(height: 4,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Full Name',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w500)
                  ),
                ),
          
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: name,
                  validator: (value){
          
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    // label: Text('Enter Your Number'),
                    hintText: name.text,
          
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffE4DFDF),
                        )),
                  ),
                ),
                SizedBox(height: 20),
          
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Email ID',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w500)
                  ),
                ),
          
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    // label: Text('Enter Your Number'),
                    hintText: email.text,
          
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffE4DFDF),
                        )),
                  ),
                ),
                SizedBox(height: 20),
          
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Mobile Number',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w500)
                  ),
                ),
          
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: mobile,
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    // label: Text('Enter Your Number'),
                    hintText: mobile.text,
                    suffixIcon: InkWell(
                      onTap: (){
                        updateMobileNumber();
                      },
                      child: ShaderMask(
                        child: Icon(Icons.edit_outlined, color: Colors.white,),
                        shaderCallback: (bounds) => LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: <Color>[
                                      Color(0xff34135B),
                                      Color.fromARGB(255, 169, 39, 72),
                                    ],
                                  ).createShader(
                                      Rect.fromLTWH(0.0, 0.0, 10.0, 10.0)),
                      ),
                    ),
          
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffE4DFDF),
                        )),
                  ),
                ),
                SizedBox(height: 20),
          
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Password',
                      style: Sty()
                          .largeText
                          .copyWith(fontWeight: FontWeight.w500)
                  ),
                ),
          
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: password,
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    // label: Text('Enter Your Number'),
                    hintText: password.text,
                    suffixIcon: InkWell(
                      onTap: (){
                        updatePassword();
                      },
                      child: ShaderMask(
                        child: Icon(Icons.edit_outlined, color: Colors.white,),
                        shaderCallback: (bounds) => LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: <Color>[
                                      Color(0xff34135B),
                                      Color.fromARGB(255, 169, 39, 72),
                                    ],
                                  ).createShader(
                                      Rect.fromLTWH(0.0, 0.0, 10.0, 10.0)),
                      ),
                    ),
          
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffE4DFDF),
                        )),
                  ),
                ),
          
                SizedBox(height: 20,),
          
                InkWell(
                  onTap: () {
                    if(updateForm.currentState!.validate()){
                      updateProfile();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dim().d16, horizontal: Dim().d80),
                    decoration: BoxDecoration(
                      gradient: Sty().linearGradient,
                      borderRadius: BorderRadius.circular(
                        Dim().d4,
                      ),
                    ),
                    margin: EdgeInsets.all(20),
                    child: Text(
                      'Update Profile',
                      style: Sty().mediumText.copyWith(
                        color: Clr().white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )



          ),
        ),
    );
  }
}
