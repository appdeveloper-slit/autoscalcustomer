import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_room_services/values/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bn_home.dart';
import '../values/dimens.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_url.dart';
bool globalDebugMode() {
  // Debug log
  // true => ON
  // false => OFF
  return true;
}

void log(printable) {
  if (globalDebugMode()) {
    print(printable);
  }
}
void displayToast(String string) {
  Fluttertoast.showToast(msg: string, toastLength: Toast.LENGTH_SHORT);
}
void load(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      barrierColor: Color.fromARGB(0, 0, 0, 0),
      context: context,
      builder: (context) {
        return Center(
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(30),
              child:
              Container(
                height: Dim().d60,
                width: Dim().d100,
                child: GradientProgressIndicator(
                  radius: 30,
                  duration: 1,
                  strokeWidth: 8.0,
                  gradientStops: const [
                    0.2,
                    100.0,
                  ],
                  gradientColors: [
                    Color(0xffB81736),
                    Color(0xffE48260),
                  ],
                  child: Text(''),
                ),
              )
            // CircularProgressIndicator(
            //     color: Colors.black,
            //     strokeWidth: 8.0,
            //   ),
          ),
        );
      });
}

void dismissLoad(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

void bottomAlert(BuildContext context, String message) {
  var sn = SnackBar(content: Text(message.toString()));
  ScaffoldMessenger.of(context).showSnackBar(sn);
}

void alert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0xff34135B),
                      Color(0xffA9163A),
                      // Color(0xff000000)
                    ],
                  ).createShader(Rect.fromLTWH(0.0, 0.0, 50.0, 15.0)),
              child: Text(
                "Alert",
                style: TextStyle(color: Colors.white),
              )),
          content: Text(message.toString()),
          elevation: 0,
          actions: [
            TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff34135B)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color(0xff34135B),
                            Color(0xffA9163A),
                            // Color(0xff000000)
                          ],
                        ).createShader(Rect.fromLTWH(0.0, 0.0, 50.0, 15.0)),
                    child: Text("OK", style: TextStyle(color: Colors.white))))
          ],
        );
      });
}
void successAlert(BuildContext context, String message, widget) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Succes",
            style: TextStyle(
              foreground: Paint()
              // ignore: prefer_const_constructors
                ..shader = LinearGradient(
                  colors: [Color(0xffB81736), Color(0xffE48260)],
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                ).createShader(
                  const Rect.fromLTWH(0.0, 0.0, 320.0, 80.0),
                ),
            ),
          ),
          content: Text(message.toString()),
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  STM().redirect2page(context, widget);
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                    foreground: Paint()
                    // ignore: prefer_const_constructors
                      ..shader = LinearGradient(
                        colors: [Color(0xffB81736), Color(0xffE48260)],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                      ).createShader(
                        const Rect.fromLTWH(0.0, 0.0, 320.0, 80.0),
                      ),
                  ),
                ))
          ],
        );
      });
}
void Message(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Succes",
            style: TextStyle(
              foreground: Paint()
              // ignore: prefer_const_constructors
                ..shader = LinearGradient(
                  colors: [Color(0xffB81736), Color(0xffE48260)],
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                ).createShader(
                  const Rect.fromLTWH(0.0, 0.0, 320.0, 80.0),
                ),
            ),
          ),
          content: Text(message.toString()),
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                 Navigator.pop(context);
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                    foreground: Paint()
                    // ignore: prefer_const_constructors
                      ..shader = LinearGradient(
                        colors: [Color(0xffB81736), Color(0xffE48260)],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                      ).createShader(
                        const Rect.fromLTWH(0.0, 0.0, 320.0, 80.0),
                      ),
                  ),
                ))
          ],
        );
      });
}
void errorAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Error",
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
                  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),),),
          ),
          content: Text(message.toString()),
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color(0xff34135B),
                            Color(0xffA9163A),
                            // Color(0xff000000)
                          ],
                        ).createShader(Rect.fromLTWH(0.0, 0.0, 50.0, 15.0)),
                    child: Text("OK", style: TextStyle(color: Colors.white))))
          ],
        );
      });
}

Future<bool> getLoginSession() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool isLogin =
      sp.getBool('is_login') != null ? sp.getBool("is_login")! : false;
  bool isID = sp.getString('user_id') != null ? true : false;
  return isLogin;
}

void setLoginTrue() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setBool('is_login', true);
}

void setLoginFalse() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setBool('is_login', false);
}

void checkLoginAndGotoHome(context) async {
  if (await getLoginSession()) {
    log("User is login : true");
    STM().gotoPage(context, Home());
  } else {
    log("User is login : false");
  }
}

class STM {
  void redirect2page(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }
  void errorDialog(BuildContext context, String message) {
    AwesomeDialog(
        context: context,
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        dialogType: DialogType.ERROR,
        animType: AnimType.SCALE,
        headerAnimationLoop: true,
        title: 'Note',
        desc: message,
        btnOkText: "OK",
        btnOkOnPress: () {},
        btnOkColor: Clr().errorRed)
        .show();
  }
  void replacePage(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ),
    );
  }
  openWeb(String url) async {
    await launch(url);
  }
  void errorDialogWithFunction(context, message, function) {
    AwesomeDialog(
        context: context,
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        dialogType: DialogType.ERROR,
        animType: AnimType.SCALE,
        headerAnimationLoop: true,
        title: 'Note',
        desc: message,
        btnOkText: "OK",
        btnOkOnPress: function,
        btnOkColor: Clr().errorRed)
        .show();
  }
  void finishAffinity(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ),
          (Route<dynamic> route) => false,
    );
  }
  void successDialogWithReplace(
      BuildContext context, String message, Widget widget) {
    AwesomeDialog(
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.SCALE,
        headerAnimationLoop: true,
        title: 'Success',
        desc: message,
        btnOkText: "OK",
        btnOkOnPress: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => widget,
            ),
                (Route<dynamic> route) => false,
          );
        },
        btnOkColor: Clr().successGreen)
        .show();
  }

  void gotoPage(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ),
      (route) => false,
    );
  }
  Future<dynamic> post(ctx, title, name, body) async {
    //Dialog
    // AwesomeDialog dialog = STM().loadingDialog(ctx, title);
    // dialog.show();
    load(ctx);
    Dio dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
      ),
    );
    String url = AppUrl.mainUrl + name;
    if (kDebugMode) {
      print("Url = $url\nBody = ${body.fields}");
    }
    dynamic result;
    try {
      Response response = await dio.post(url, data: body);
      if (kDebugMode) {
        print("Response = $response");
      }
      if (response.statusCode == 200) {
        // dialog.dismiss();
        Navigator.of(ctx).pop();
        result = json.decode(response.data.toString());
      }
    } on DioError catch (e) {
      // dialog.dismiss();
      Navigator.of(ctx).pop();
    STM().errorDialog(ctx, e.message);
    }
    return result;
  }

  List<BottomNavigationBarItem> getBottomList(index) {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/bn_home.svg",
          color: index == 0 ? Color(0xFF69A9F0) : null,
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/bn_order.svg",
          color: index == 1 ? Color(0xFF69A9F0) : null,
        ),
        label: 'Leads',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/Services.svg",
          color: index == 2 ? Color(0xFF69A9F0) : null,
        ),
        label: 'Services',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/bn_profile.svg",
          color: index == 3 ? Color(0xFF69A9F0) : null,
        ),
        label: 'Profile',
      ),
    ];
  }

  void back2Previous(BuildContext context) {
    Navigator.pop(context);
  }
}
