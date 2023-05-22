import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bn_order.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/global_urls.dart';
import 'values/strings.dart';
import 'values/styles.dart';

// void main() => runApp(OngoingLeadDetails());

class OngoingLeadDetails extends StatefulWidget {
  String? status;
  String? order_id;

  OngoingLeadDetails(this.order_id, this.status);

  @override
  State<OngoingLeadDetails> createState() => _OngoingLeadDetailsState(order_id);
}

class _OngoingLeadDetailsState extends State<OngoingLeadDetails> {
  late BuildContext ctx;

  String? order_id;

  _OngoingLeadDetailsState(this.order_id);

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
  String? discount;
  String? total;
  var url1;
  late bool flag;

  void getLeadDetails() async {
    load(context);
    print(order_id.toString());
    SharedPreferences sp = await SharedPreferences.getInstance();
    var dio = Dio();
    var formData = FormData.fromMap({
      "id": order_id.toString(),
      // "id": "38",
    });
    // print(sp.getString("user_id").toString());
    var response = await dio.post(getOrderDetails(), data: formData);
    if (globalDebugMode()) {
      print(response);
    }
    final result = response.data;
    dismissLoad(context);
    setState(() {
      brandName = result['brand'].toString();
      vehicleModel = result['model'].toString();
      manufacturingYear = result['manfacturing_year'].toString();
      supplierName = result['seller_name'].toString();
      mobileNumber = result['contact_no'].toString();
      address = result['house_no'].toString();
      addressNearByLandmark = result['landmark'].toString();
      addressPincode = result['pincode'].toString();
      addressState = result['state'].toString();
      addressCity = result['city'].toString();
      dateForInspection = result['inspection_date'].toString();
      inspectionPrice = result['inspection_price'].toString();
      discount = result['discount'].toString();
      total = result['total'].toString();
      flag = result['flag'];
      url1 = result['documents'];
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getLeadDetails();
    });
    // TODO: implement initState
    super.initState();
  }

  var a;

  Future<void> _launchUrl(url) async {
    if (!await launch(url)) {
      throw 'Could not launch $url';
    }
  }

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
          'Lead Details',
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
                          child: ShaderMask(
                            child: SvgPicture.asset("assets/Car.svg"),
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
                          child: ShaderMask(
                            child: SvgPicture.asset("assets/Car.svg"),
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
                          child: ShaderMask(
                            child: SvgPicture.asset("assets/location (2).svg"),
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
                        '$address, $addressNearByLandmark, $addressCity, $addressState $addressPincode'),
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

            // Row(
            //   children: [
            //     Expanded(
            //       child: TextFormField(
            //         decoration: InputDecoration(
            //           contentPadding: EdgeInsets.all(10),
            //           // label: Text('Enter Your Number'),
            //           hintText: "Enter Coupon Code",
            //
            //           border: OutlineInputBorder(
            //               borderSide: BorderSide(
            //                 color: Clr().black,
            //               )),
            //         ),
            //       ),
            //     ),
            //
            //   ],
            // ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: GestureDetector(
            //     onTap: () {
            //       // STM().redirect2page(ctx, ForgetPassword());
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.only(right: 10  ),
            //       child: RichText(
            //           text: TextSpan(
            //               text: 'VIew all Coupons',
            //               style: Sty().mediumBoldText.copyWith(
            //                   fontWeight: FontWeight.w400,
            //                   fontSize: 14,
            //                   color: Color(0xFF2D135B)))),
            //     ),
            //   ),
            // ),
            SizedBox(height: Dim().d4),
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
                            child: Text('\u20b9 $inspectionPrice'),
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
                            child: Text('\u20b9 $discount'),
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
                          child: Text('Total',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff69A9F0))),
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
                            child: Text('\u20b9 $total',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff69A9F0))),
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
            a == 1
                ? Text(
                    'Cancel Lead',
                    style: Sty().mediumText.copyWith(
                          color: Clr().red,
                        ),
                  )
                : widget.status == 'Completed'
                    ? InkWell(
                        onTap: () {
                          STM().openWeb(url1);
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
                            'Download Report',
                            style: Sty().mediumText.copyWith(
                                  color: Clr().white,
                                ),
                          ),
                        ),
                      )
                    : widget.status == 'Cancelled'
                        ? Text(
                            'Cancel Lead',
                            style: Sty().mediumText.copyWith(
                                  color: Clr().red,
                                ),
                          )

                    : flag
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dim().d16, horizontal: Dim().d80),
                            decoration: BoxDecoration(
                              gradient: Sty().linearGradient,
                              borderRadius: BorderRadius.circular(
                                Dim().d4,
                              ),
                            ),
                            margin: EdgeInsets.all(20),
                            child: InkWell(
                              onTap: () {
                                // STM().redirect2page(ctx, CompletedLeadDetails());
                                setState(() {
                                  a = 1;
                                });
                                cancelorder();
                              },
                              child: Text(
                                'Cancel Lead',
                                style: Sty().mediumText.copyWith(
                                      color: Clr().white,
                                    ),
                              ),
                            ),
                          )
                        : Container(),
          ],
        ),
      ),
    );
  }

  cancelorder() async {
    //Input
    SharedPreferences sp = await SharedPreferences.getInstance();
    FormData body = FormData.fromMap({
      "order_id": widget.order_id,
    });
    if (!mounted) return;
    var result =
        await STM().post(ctx, Str().processing, "customer_order_cancel", body);
    var error = result['error'];
    var message = result['message'];
    if (!error) {
      displayToast("Success");
      successAlert(ctx, message, Order());
    } else {
      STM().errorDialog(ctx, message);
    }
  }
}
