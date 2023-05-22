import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:quick_room_services/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignIn.dart';
import 'bn_home.dart';
import 'car_model_inspection_details_form.dart';
import 'notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  String uId = sp.getString("user_id") ?? '';
  OneSignal.shared.setAppId("fc3e9961-69d8-442b-858c-bc2a20defc7d");
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  OneSignal.shared.setNotificationOpenedHandler((value) {
    navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => Notifications(),
      ),
    );
  });
  runApp(
    GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        // home: isLogin
        //     ? const Home()
        //     : isID
        //     ? const SelectCourse()
        //     : const Register(),
        home: uId == '' ? SignIn() : Home(),
      ),
    ),
  );
}
