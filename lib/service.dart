import 'package:flutter/material.dart';
import 'package:quick_room_services/manage/static_method.dart';
import 'package:quick_room_services/toolbar/toolbar.dart';
import 'package:quick_room_services/values/colors.dart';
import 'package:quick_room_services/values/dimens.dart';
import 'package:quick_room_services/values/styles.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'car_loan.dart';
import 'car_transfer.dart';
import 'insurance.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbar1Layout('Services', context),
      bottomNavigationBar: bottomBarLayout(context, 2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Dim().d20,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: Dim().d28),
              child: Text(
                'Kindly share your contact details, we will respond your inquiry shortly.',
                style: Sty().mediumText.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                STM().redirect2page(context, Insurance());
              },
              child: Padding(
                padding: EdgeInsets.all(Dim().d28),
                child: Container(
                  height: Dim().d60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Clr().lightGrey),
                      color: Clr().white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dim().d16))),
                  child: Padding(
                    padding: EdgeInsets.all(Dim().d20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Car Insurance',
                          style: Sty().mediumText,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Clr().black,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                STM().redirect2page(context, CarLoan());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d28),
                child: Container(
                  height: Dim().d60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Clr().lightGrey),
                      color: Clr().white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dim().d16))),
                  child: Padding(
                    padding: EdgeInsets.all(Dim().d20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Car Loan',
                          style: Sty().mediumText,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Clr().black,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                STM().redirect2page(context, Cartransfer());
              },
              child: Padding(
                padding: EdgeInsets.all(Dim().d28),
                child: Container(
                  height: Dim().d60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Clr().lightGrey),
                      color: Clr().white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dim().d16))),
                  child: Padding(
                    padding: EdgeInsets.all(Dim().d20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Car Transfer',
                          style: Sty().mediumText,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Clr().black,
                        )
                      ],
                    ),
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
