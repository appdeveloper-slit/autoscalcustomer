import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quick_room_services/bottom_navigation/bottom_navigation.dart';
import 'package:quick_room_services/toolbar/toolbar.dart';
import 'package:quick_room_services/values/colors.dart';
import 'package:quick_room_services/values/dimens.dart';
import 'package:quick_room_services/values/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'manage/static_method.dart';
import 'service.dart';
import 'values/strings.dart';

class Cartransfer extends StatefulWidget {
  const Cartransfer({Key? key}) : super(key: key);

  @override
  State<Cartransfer> createState() => _CartransferState();
}

class _CartransferState extends State<Cartransfer> {
  late BuildContext ctx;
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _mobilecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ctx  =  context;
    return Scaffold(
      appBar: toolbar1Layout('Car Transfer', context),
      bottomNavigationBar: bottomBarLayout(context, 2),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d36),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dim().d32,
                ),
                Text(
                  'Name',
                  style: Sty().mediumText,
                ),
                SizedBox(
                  height: Dim().d8,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please fill the name";
                    }
                  },
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    hintText: 'Enter  Name',
                    hintStyle: Sty().mediumText.copyWith(
                      color: Clr().hintColor
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffE4DFDF),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dim().d32,
                ),
                Text(
                  'Email Id',
                  style: Sty().mediumText,
                ),
                SizedBox(
                  height: Dim().d8,
                ),
                TextFormField(
                  controller: _emailcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    hintText: 'Enter  Email Id',
                    hintStyle: Sty().mediumText.copyWith(
                        color: Clr().hintColor
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffE4DFDF),
                        )),
                  ),
                ),
                SizedBox(
                  height: Dim().d32,
                ),
                Text(
                  'Mobile Number',
                  style: Sty().mediumText,
                ),
                SizedBox(
                  height: Dim().d8,
                ),
                TextFormField(
                  controller: _mobilecontroller,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  validator: (value) {
                    if (value!.length != 10) {
                      return "Please enter your valid mobile number";
                    }
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.all(8),
                    hintText: 'Enter  Mobile Number',
                    hintStyle: Sty().mediumText.copyWith(
                        color: Clr().hintColor
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffE4DFDF),
                        )),
                  ),
                ),
                SizedBox(
                  height: Dim().d32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if(_formKey.currentState!.validate()){
                          updatecarinsurance();
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
                          'Submit',
                          style: Sty().mediumText.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  updatecarinsurance() async {
    //Input
    SharedPreferences sp = await SharedPreferences.getInstance();
    FormData body = FormData.fromMap({
      "name":_namecontroller.text,
      "mobile":_mobilecontroller.text,
      "email":_emailcontroller.text,
      "user_id":sp.getString("user_id"),
    });
    if (!mounted) return;
    var result =
    await STM().post(ctx, Str().processing, "car_transfer", body);
    var error = result['error'];
    var message = result['message'];
    if (!error) {
      displayToast("Success");
      successAlert(ctx,'Kindly share your contact details, we will respond your inquiry shortly.',Services());
    } else {
      STM().errorDialog(ctx, message);
    }
  }
}
