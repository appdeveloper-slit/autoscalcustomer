import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quick_room_services/values/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'manage/static_method.dart';
import 'values/global_urls.dart';
import 'values/styles.dart';

// void main() => runApp(Notifications());

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late BuildContext ctx;

  List<dynamic> resultList = [];

  void getNotifications() async {
    load(context);
    SharedPreferences sp = await SharedPreferences.getInstance();
    var dio = Dio();
    var formData = FormData.fromMap({
      "user_id" : sp.getString("user_id").toString()
    });
    var response = await dio.post(getNotificationUrl(), data: formData);
    if(globalDebugMode()){
    print(response);
    }
    final result = response.data;
    dismissLoad(context);    

    setState(() {
      resultList = result;
    });

    // if(result['error'] != true){

    // }
    // else{

    // }

  }

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      (){
        getNotifications();
      }
    );
    super.initState();
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
            'Notifications',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                foreground: Paint()
                  ..shader = Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
          ),
        ),
        body: resultList.length != 0 ? SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: resultList.length,
                itemBuilder: (context, index) {
                  return  Card(
                      child: Padding(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    resultList[index]['title'].toString(),
                                    style: Sty().mediumText.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    resultList[index]['message'].toString(),
                                    style: Sty().mediumText.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    resultList[index]['created_at'].toString(),
                                    style: Sty().mediumText.copyWith(
                                        fontSize: 12, color: Clr().grey),
                                  ),
                                ],
                              ),
                            )),
                            // SvgPicture.asset('assets/call.svg')
                          ],
                        )
                      ],
                    ),
                  ));
                },
              )
            ],
          ),
        ) : Center(child: Text("No Notifications")),
    );
  }
}
