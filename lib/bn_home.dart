import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:quick_room_services/car_model_inspection_form.dart';
import 'package:quick_room_services/values/colors.dart';
import 'package:quick_room_services/values/dimens.dart';
import 'package:quick_room_services/values/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'brand.dart';
import 'manage/static_method.dart';
import 'notification.dart';
import 'values/strings.dart';

// void main() => runApp(Home());

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late BuildContext ctx;
  List<dynamic> imageList = [];
  List<dynamic> resultList = [];
  List<dynamic> brandsList = [];
  int? notificationCount;

  void getHomePageData() async {
    //Input
    SharedPreferences sp = await SharedPreferences.getInstance();
    final status = await OneSignal.shared.getDeviceState();
    FormData body = FormData.fromMap({
      "uuid": status?.userId,
      'date': sp.getString('date') ?? DateTime.now(),
    });
    if (!mounted) return;
    var result = await STM().post(ctx, Str().processing, "home", body);
    setState(() {
      brandsList = result['brands'];
      resultList = result['reviews'];
      imageList = result['sliders'];
      notificationCount = result['count'];
    });
  }

  // void getHomePageData() async {
  //   load(context);
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   final status = await OneSignal.shared.getDeviceState();
  //   var dio = Dio();
  //   var response = await dio.post(homeDataUrl(), data: {
  //     "uuid": status?.userId,
  //     'date': sp.getString('date') ?? DateTime.now(),
  //   });
  //   if (globalDebugMode()) {
  //     print(response);
  //   }
  //   final result = response.data;
  //   dismissLoad(context);
  //   if (result['error'] != true) {
  //     imageList = [];
  //     for (int i = 0; i < result['sliders'].length; i++) {
  //       imageList.add(result['sliders'][i]['image_path']);
  //     }
  //     brandsList = [];
  //     brandsList = result['brands'];
  //     resultList = [];
  //     resultList = result['reviews'];
  //     notificationCount = result['count'];
  //     setState(() {
  //       imageList = imageList;
  //       brandsList = brandsList;
  //     });
  //   } else {}
  // }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        getHomePageData();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return DoubleBack(
      message: "Press back once again to exit!",
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Clr().screenBackground,
        bottomNavigationBar: bottomBarLayout(ctx, 0),
        appBar: AppBar(
          title: ShaderMask(
              shaderCallback: (bounds) => Sty().linearGradient.createShader(const Rect.fromLTWH(0.0, 0.0, 100.0, 15.0)),
              child: const Text("The Cars Doctor",
                  style: TextStyle(color: Colors.red))),
          centerTitle: true,
          backgroundColor: const Color(0xffffffff),
          leading: Container(
            margin: EdgeInsets.only(left: Dim().d4),
            child: Image.asset(
              'assets/profilelogo.png',
              fit: BoxFit.contain,
              height: 50,
              width: 50,
            ),
          ),
          actions: [
            Stack(
              children: [Container(
                margin: EdgeInsets.only(right: Dim().d12,top: Dim().d14),
                child: GestureDetector(
                  onTap: () {
                    STM().redirect2page(ctx, Notifications());
                  },
                  child: SvgPicture.asset('assets/Notification.svg',height: Dim().d28,color: Color(0xffE48260),),
                ),
              ),
                Positioned(
                  top: 21,
                  right: 6,
                  child: Container(
                    height: Dim().d32,
                    width: Dim().d16,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('$notificationCount',style: Sty().smallText.copyWith(color: Clr().white,),),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  // enableInfiniteScroll: true,
                  // autoPlay: true,
                ),
                items: imageList
                    .map((e) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              CachedNetworkImage(
                                imageUrl: e['image_path'].toString(),
                                width: 1200,
                                height: 300,
                                fit: BoxFit.fill,
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // STM().redirect2page(ctx, Brand());
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ShaderMask(
                          child: SvgPicture.asset("assets/Car.svg"),
                          shaderCallback: (bounds) => Sty().linearGradient.createShader(
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Brands',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            foreground: Paint()
                              ..shader = Sty().linearGradient.createShader(
                                  const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
                      ),
                    ),
                  ],
                ),
              ),
              if (brandsList.isNotEmpty) const SizedBox(height: 16),
              if (brandsList.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisExtent: 100,
                  ),
                  itemCount: brandsList.length = 12,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        STM().redirect2page(
                            context,
                            CarModelInspectionForm(
                              brandsList[index]['brand_name'].toString(),
                              brandsList[index]['id'].toString(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Clr().white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Clr().lightGrey,
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: CachedNetworkImage(
                                    imageUrl: brandsList[index]['image_path']
                                        .toString(),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            brandsList[index]['brand_name'].toString(),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    );
                  },
                ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  STM().redirect2page(ctx, Brand());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dim().d16, horizontal: Dim().d28),
                  decoration: BoxDecoration(
                    gradient: Sty().linearGradient,
                    borderRadius: BorderRadius.circular(
                      Dim().d4,
                    ),
                  ),
                  margin: const EdgeInsets.all(0),
                  child: Wrap(
                    children: [
                      Text(
                        'View all Brands',
                        style: Sty().mediumText.copyWith(
                              color: Clr().white,
                            ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Clr().white,
                        size: 18,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ShaderMask(
                          child: SvgPicture.asset('assets/how.svg'),
                          shaderCallback: (bounds) => Sty().linearGradient.createShader(
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ShaderMask(
                        shaderCallback: (bounds) => Sty().linearGradient.createShader(
                            const Rect.fromLTWH(0.0, 0.0, 100.0, 15.0)),
                        child: const Text(
                          'How Cars Doctor Works ?',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Image.asset('assets/doctorworks.png'),
              Container(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ShaderMask(
                          child: SvgPicture.asset('assets/thumb.svg'),
                          shaderCallback: (bounds) => Sty().linearGradient.createShader(
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ShaderMask(
                        shaderCallback: (bounds) => Sty().linearGradient.createShader(
                            const Rect.fromLTWH(0.0, 0.0, 100.0, 10.0)),
                        child: const Text(
                          'User Reviews',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  // itemCount: resultList.length,
                  itemCount: resultList.length,
                  itemBuilder: (context, index) {
                    return itemLayout(ctx, index, resultList);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemLayout(ctx, index, list) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Container(
        width: 350,
        margin: const EdgeInsets.only(right: 25),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffE4DFDF)),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8, top: 12, left: 8),
              child: Wrap(
                children: [
                  ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: list[index]['image_path'].toString(),
                      width: 60,
                      height: 60,
                    ),
                    borderRadius: BorderRadius.circular(Dim().d100),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(Dim().d8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          list[index]['name'].toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          list[index]['created_at'].toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff747688)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 10, bottom: 10),
              child: Text(
                list[index]['review'].toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xff747688),
                    height: 1.5),
              ),
            ),
            SizedBox(height: Dim().d4)
          ],
        ),
      ),
    );
  }
}
