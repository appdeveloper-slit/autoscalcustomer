import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bn_home.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'cancelledLeadDetails.dart';
import 'completed_Lead_details.dart';
import 'manage/static_method.dart';
import 'ongoing_lead_details.dart';
import 'values/colors.dart';
import 'values/global_urls.dart';
import 'values/styles.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return OrderPage();
  }
}

class OrderPage extends State<Order> {
  late BuildContext ctx;
  List<dynamic> orderList = [];

  void getOrders() async {
    load(context);
    SharedPreferences sp = await SharedPreferences.getInstance();
    var dio = Dio();
    var formData =
        FormData.fromMap({"user_id": sp.getString("user_id").toString()});
    print(sp.getString("user_id").toString());
    var response = await dio.post(getMyOrdersUrl(), data: formData);
    if (globalDebugMode()) {
      print(response);
    }
    final result = response.data;
    dismissLoad(context);
    setState(() {
      orderList = result;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getOrders();
    });
    // TODO: implement initState
    super.initState();
  }

  Widget bodyLayout() {
    return orderList.length != 0
        ? SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: InkWell(
                    onTap: () {
                      STM().redirect2page(
                          ctx,
                          OngoingLeadDetails(orderList[index]['id'].toString(),
                              orderList[index]['status'].toString()));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Lead ID: ' +
                                                    orderList[index]['order_no']
                                                        .toString(),
                                                style:
                                                    Sty().mediumText.copyWith(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                orderList[index]['created_at']
                                                    .toString(),
                                                style: Sty()
                                                    .mediumText
                                                    .copyWith(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Clr().grey),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                orderList[index]['brand_name']
                                                        .toString() +
                                                    " | " +
                                                    orderList[index]['model_no']
                                                        .toString() +
                                                    " | " +
                                                    orderList[index][
                                                            'manfacturing_year']
                                                        .toString(),
                                                style:
                                                    Sty().mediumText.copyWith(
                                                          fontSize: 16,
                                                        ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text: 'Lead Status : ',
                                                  style: Sty()
                                                      .smallText
                                                      .copyWith(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: orderList[index]
                                                              ['status']
                                                          .toString(),
                                                      style:
                                                          Sty()
                                                              .mediumText
                                                              .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: orderList[index]
                                                                            [
                                                                            'status'] ==
                                                                        'Ongoing'
                                                                    ? Clr()
                                                                        .ongoingcolor
                                                                    : orderList[index]['status'] ==
                                                                            'Pending'
                                                                        ? Clr()
                                                                            .ongoingcolor
                                                                        : orderList[index]['status'] ==
                                                                                'Completed'
                                                                            ? Clr().completedcolor
                                                                            : orderList[index]['status'] == 'Under Review'
                                                                                ? Clr().ongoingcolor
                                                                                : orderList[index]['status'] == 'Cancelled'
                                                                                    ? Clr().pendingcolor
                                                                                    : Clr().black,
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Color(0xff3F1358),
                                          size: 20,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
                },
              ),
            ),
          )
        : Center(child: Text("No Order Found!"));
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return WillPopScope(
      onWillPop: () async{
        STM().replacePage(context, Home());
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: bottomBarLayout(ctx, 1),
        body: bodyLayout(),
        appBar: AppBar(
          backgroundColor: Color(0xffffffff),
          leading: InkWell(
            onTap: () {
              STM().replacePage(ctx,Home());
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffE48260),
            ),
          ),
          centerTitle: true,
          title: Text(
            'My Leads',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                foreground: Paint()
                  ..shader = LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.3, 12),
                    colors: <Color>[
                      Color(0xff34135B),
                      Color(0xffA9163A),
                    ],
                  ).createShader(Rect.fromLTWH(0.0, 35.0, 200.0, 70.0))),
          ),
        ),
      ),
    );
  }
}
