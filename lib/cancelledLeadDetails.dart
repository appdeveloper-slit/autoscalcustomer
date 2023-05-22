import 'package:flutter/material.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'manage/static_method.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

void main() => runApp(CancelledLeadDetails());

class CancelledLeadDetails extends StatefulWidget {
  @override
  State<CancelledLeadDetails> createState() => _CancelledLeadDetailsState();
}

class _CancelledLeadDetailsState extends State<CancelledLeadDetails> {
  late BuildContext ctx;

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
                            child: Image.asset('assets/car.png'),
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
                            child: Text('Mahindra'),
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
                            child: Text('ALTROZ'),
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
                            child: Text('2017'),
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
                            child: Image.asset('assets/car.png'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text('Supplier Details'),
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
                            child: Text('Aniket Mahakal'),
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
                            child: Text('3251513511'),
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
                            child: Image.asset('assets/location.png'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(Dim().d8),
                            child: Text('Supplier Address'),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                          'Vasant Lawns , DP Road, Opp. TCS , Subhash Nagar , Thane West , Thane , Maharashtra 400606'),
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
                              child: Text('\u20b9500'),
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
                              child: Text('\u20b90'),
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
                            child: Text('Total'),
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
                              child: Text('\u20b9500'),
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
                height: 20,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
