import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'manage/static_method.dart';
import 'values/global_urls.dart';
import 'values/styles.dart';

void main() => runApp(Coupons());

class Coupons extends StatefulWidget {
  const Coupons({Key? key}) : super(key: key);

  @override
  State<Coupons> createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {
  late BuildContext ctx;
  List<dynamic> resultList = [];

  void getCoupons() async {
    load(context);
    SharedPreferences sp = await SharedPreferences.getInstance();
    var dio = Dio();
    var response = await dio.get(getCouponsUrl());
    if(globalDebugMode()){
      print(response);
    }
    final result = response.data;
    dismissLoad(context);

    if(result['error'] != true){
      setState(() {
        resultList = result['result_array'];

      });
    }
    else{

    }

  }

  @override
  void initState() {
    Future.delayed(Duration.zero, (){
      getCoupons();
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
            'Coupons',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                foreground: Paint()
                  ..shader = Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(16),
          shrinkWrap: true,
          // itemCount: resultList.length,
          itemCount: resultList.length,
          itemBuilder: (context, index) {
            return itemLayout(ctx,index,resultList);
          },
        ),
      ),
    );
  }

  Widget itemLayout(ctx, index,list) {
    return
      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              side: BorderSide(color: Color(0xffE48260))),
          borderOnForeground: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 12,
                  right: 10,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      side: BorderSide(color: Color(0xffE48260))),
                  child: InkWell(
                    onTap: () async {
                       await Clipboard.setData(ClipboardData(text: list[index]['code'].toString()));
                       alert(context, "Copied: " + list[index]['code'].toString());
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: SvgPicture.asset('assets/copy.svg',
                              color: Color(0xffE48260)),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(list[index]['code'].toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 8, bottom: 8, right: 8),
                child: Text(
                  list[index]['detail'].toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),

        ),
      );

  }
}
