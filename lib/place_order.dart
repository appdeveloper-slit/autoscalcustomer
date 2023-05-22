import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_room_services/bn_home.dart';
import 'package:quick_room_services/bn_order.dart';
import 'package:quick_room_services/values/dimens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'coupons.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/global_urls.dart';
import 'values/styles.dart';
import 'webview.dart';

// void main() => runApp(PlaceOrder());

class PlaceOrder extends StatefulWidget {

  String? brandName;
  String? vehicleModel;
  String? manufacturingYear;
  String? supplierName;
  String? mobileNumber;
  String? address;
  String? addressNearByLandmark;
  String? addressPincode;
  String? addressState;
  String? addressCity;
  String? dateForInspection;
  String? inspectionPrice;
  String? brandId;
  String? modelId;


  PlaceOrder(
    this.brandName,
    this.vehicleModel,
    this.manufacturingYear,
    this.supplierName,
    this.mobileNumber,
    this.address,
    this.addressNearByLandmark,
    this.addressPincode,
    this.addressState,
    this.addressCity,
    this.dateForInspection,
    this.inspectionPrice,
    this.brandId,
    this.modelId
  );

  @override
  State<PlaceOrder> createState() => _PlaceOrderState(
    brandName,
    vehicleModel,
    manufacturingYear,
    supplierName,
    mobileNumber,
    address,
    addressNearByLandmark,
    addressPincode,
    addressState,
    addressCity,
    dateForInspection,
    inspectionPrice,
    brandId,
    modelId
  );
}

class _PlaceOrderState extends State<PlaceOrder> {
  late BuildContext ctx;

  String? brandName;
  String? vehicleModel;
  String? manufacturingYear;
  String? supplierName;
  String? mobileNumber;
  String? address;
  String? addressNearByLandmark;
  String? addressPincode;
  String? addressState;
  String? addressCity;
  String? dateForInspection;
  String? inspectionPrice;
  String? brandId;
  String? modelId;
  _PlaceOrderState(
    this.brandName,
    this.vehicleModel,
    this.manufacturingYear,
    this.supplierName,
    this.mobileNumber,
    this.address,
    this.addressNearByLandmark,
    this.addressPincode,
    this.addressState,
    this.addressCity,
    this.dateForInspection,
    this.inspectionPrice,
    this.brandId,
    this.modelId
  );


  double discount = 0;
  double final_amount = 0;
  int dummy = 0;
  TextEditingController couponCodeController = TextEditingController();
  final couponCodeFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ctx = context;

    


    return Scaffold(
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
            'Place Order',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                foreground: Paint()
                  ..shader = Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(Dim().d16),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE4DFDF)),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ShaderMask(child: SvgPicture.asset("assets/Car.svg"), 
                            shaderCallback: (bounds) => Sty().linearGradient.createShader(
                                      Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text('Car Details'),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text('Brand'),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(':'),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text(brandName.toString()),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text('Car Model'),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(':'),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text(vehicleModel.toString()),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text('Manufacturing Year'),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(':'),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text(manufacturingYear.toString()),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dim().d8)
                  ],
                ),
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Container(
                margin: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE4DFDF)),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ShaderMask(child: SvgPicture.asset("assets/Car.svg"),
                             shaderCallback: (bounds) => Sty().linearGradient.createShader(
                                      Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text('Seller Details'),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text('Name'),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(':'),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text(supplierName.toString()),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text('Contact Number'),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(':'),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text(mobileNumber.toString()),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dim().d8)
                  ],
                ),
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Container(
                margin: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE4DFDF)),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ShaderMask(child: SvgPicture.asset("assets/location (2).svg"), 
                            shaderCallback: (bounds) => Sty().linearGradient.createShader(
                                      Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text('Seller Address'),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        (address!.isNotEmpty && address != null) ? '$address $addressNearByLandmark $addressCity $addressState $addressPincode' : '-'),
                    ),
                    SizedBox(height: Dim().d4)
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Coupon Code',
                      style: Sty().largeText.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Clr().black,
                          ))),
              Form(
                key: couponCodeFormKey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: couponCodeController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Please enter a coupon code!";
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          // label: Text('Enter Your Number'),
                          hintText: "Enter Coupon Code",
              
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Clr().black,
                          )),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if(couponCodeFormKey.currentState!.validate()){

                        load(context);
                        SharedPreferences sp = await SharedPreferences.getInstance();
                        var dio = Dio();
                        final formData = FormData.fromMap({
                          "coupon_name" : couponCodeController.text.toString(),
                          "order_amt": inspectionPrice.toString(),
                          "user_id": sp.getString("user_id"),
                        });
                        var response = await dio.post(applyCouponUrl(), data: formData);
                        if(globalDebugMode()){
                          print(response);
                        }
                        final result = response.data;
                        dismissLoad(context);

                        if(result['error'] != true){
                          setState(() {
                            discount = double.parse(result['discount_amount'].toString());
                            final_amount = double.parse(result['final_amount'].toString());

                            print("DISCOUNT APPLIED: " + discount.toString());
                            print("FINAL AMOUNT: " + final_amount.toString());  
                          });
                        }
                        else{
                          errorAlert(context, result['message']);
                        }

                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dim().d14, horizontal: Dim().d28),
                        decoration: BoxDecoration(
                          gradient: Sty().linearGradient,
                          borderRadius: BorderRadius.circular(
                            Dim().d4,
                          ),
                        ),
                        margin: EdgeInsets.all(10),
                        child: Text(
                          'Apply',
                          style: Sty().mediumText.copyWith(
                                color: Clr().white,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // STM().redirect2page(ctx, ForgetPassword());
                          },
                          child: InkWell(
                            onTap: () {
                              STM().redirect2page(ctx, Coupons());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10  ),
                              child: RichText(
                                  text: TextSpan(
                                      text: 'View all Coupons',
                                      style: Sty().mediumBoldText.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Color(0xFF69A9F0)
                                      )
                                  )
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: SvgPicture.asset('assets/arrow.svg',
                          color: Color(0xFF69A9F0),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dim().d20),
              Container(
                margin: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE4DFDF)),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text('Inspection Price'),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(':'),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text('\u20b9 '+ inspectionPrice.toString()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text('Discount'),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(':'),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text('\u20b9 ' + discount.toString()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff69A9F0))),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(':'),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.all(Dim().d8),
                              child: Text('\u20b9' + (double.parse(inspectionPrice.toString()) - discount).toString(),  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff69A9F0))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dim().d8)
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () async {
                  // load(context);
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  String sUrl = """user_id=${sp.getString("user_id")}&seller_name=${supplierName != null ? supplierName.toString() : ""}&contact_no=${mobileNumber != null ? mobileNumber.toString() : ""}&house_no=${address != null ? address.toString() : ""}&landmark=${addressNearByLandmark != null ? addressNearByLandmark.toString() : ""}&pincode=${addressPincode != null ? addressPincode.toString() : ""}&state=${addressState != null ? addressState.toString() : ""}&city=${addressCity != null ? addressCity.toString() : ""}&inspection_date=${dateForInspection != null ? dateForInspection.toString() : ""}&brand_id=${brandId != null ? brandId.toString() : ""}&model_id=${modelId != null ? modelId.toString() : ""}&manfacturing_year=${manufacturingYear != null ? manufacturingYear.toString() : ""}&inspection_price=${inspectionPrice != null ? inspectionPrice.toString() : ""}&discount=${discount.toString()}&total=${inspectionPrice != null ? (double.parse(inspectionPrice.toString()) - discount).toString() : ""}""";
                  STM().finishAffinity(ctx, WebViewPage(sUrl));
                  // var dio = Dio();
                  // final formData = FormData.fromMap({
                  //   "user_id": sp.getString("user_id"),
                  //
                  //   "seller_name":supplierName != null ? supplierName.toString() : "",
                  //   "contact_no":mobileNumber != null ? mobileNumber.toString() : "",
                  //   "house_no":address != null ? address.toString() : "",
                  //   "landmark":addressNearByLandmark != null ? addressNearByLandmark.toString() : "",
                  //   "pincode":addressPincode != null ? addressPincode.toString() : "",
                  //   "state":addressState != null ? addressState.toString() : "",
                  //   "city":addressCity != null ? addressCity.toString() : "",
                  //   "inspection_date":dateForInspection != null ? dateForInspection.toString() : "",
                  //   "brand_id":brandId != null ? brandId.toString() : "",
                  //   "model_id":modelId != null ? modelId.toString() : "",
                  //   "manfacturing_year":manufacturingYear != null ? manufacturingYear.toString() : "",
                  //   "inspection_price":inspectionPrice != null ? inspectionPrice.toString() : "",
                  //   "discount":discount.toString(),
                  //   "total":inspectionPrice != null ? (double.parse(inspectionPrice.toString()) - discount).toString() : "",
                  //
                  // });
                  //
                  // formData.fields.forEach((element) {
                  //   print(element.key.toString() + " : " + element.value.toString());
                  // });
                  //
                  // var response = await dio.post(placeOrderUrl(), data: formData);
                  // if(globalDebugMode()){
                  //   print(response);
                  // }
                  // final result = response.data;
                  // dismissLoad(context);
                  //
                  // if(result['error'] != true){
                  //   STM().gotoPage(context, Order());
                  //   showDialog(
                  //     barrierDismissible: false,
                  //     context: context, builder: (context) {
                  //     return AlertDialog(title: ShaderMask(
                  //        shaderCallback: (bounds) => LinearGradient(
                  //                   begin: Alignment.topCenter,
                  //                   end: Alignment.bottomCenter,
                  //                   colors: <Color>[
                  //                     Color(0xff34135B),
                  //                     Color(0xffA9163A),
                  //                     // Color(0xff000000)
                  //                   ],
                  //                 ).createShader(
                  //                     Rect.fromLTWH(0.0, 0.0, 50.0, 15.0)),
                  //       child: Text("Alert", style: TextStyle(color: Colors.white),)), content: Text(result['message'].toString()), elevation: 0, actions: [
                  //       TextButton(
                  //         style: ButtonStyle(
                  //           splashFactory: NoSplash.splashFactory,
                  //         ),
                  //         onPressed: (){
                  //         Navigator.pop(context);
                  //       }, child: ShaderMask(
                  //         shaderCallback: (bounds) => LinearGradient(
                  //                   begin: Alignment.topCenter,
                  //                   end: Alignment.bottomCenter,
                  //                   colors: <Color>[
                  //                     Color(0xff34135B),
                  //                     Color(0xffA9163A),
                  //                     // Color(0xff000000)
                  //                   ],
                  //                 ).createShader(
                  //                     Rect.fromLTWH(0.0, 0.0, 50.0, 15.0)),
                  //         child: Text("OK", style: TextStyle(color:Colors.white))))
                  //     ],);
                  //   });
                  // }
                  // else{
                  //   errorAlert(context, result['message'].toString());
                  // }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dim().d16, horizontal: Dim().d60),
                  decoration: BoxDecoration(
                    gradient:Sty().linearGradient,
                    borderRadius: BorderRadius.circular(
                      Dim().d4,
                    ),
                  ),
                  margin: EdgeInsets.all(0),
                  child: Text(
                    'Proceed to Payment',
                    // 'Proceed to Payment'
                    style: Sty().mediumText.copyWith(
                          color: Clr().white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
