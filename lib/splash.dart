import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:quick_room_services/SignIn.dart';

import 'manage/static_method.dart';

class Splash extends StatefulWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

@override
  void initState() {
    Future.delayed(Duration(seconds: 8), (){
      STM().gotoPage(context, SignIn());
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F4F0),
      body: Center(
        child: GifView.asset(
          'assets/splashgif.gif',
          height: 200,
          width: 200,
          frameRate: 30, // default is 15 FPS
        ),
      ),
    );
  }
}