import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quick_room_services/manage/static_method.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bn_order.dart';
import 'manage/app_url.dart';

class WebViewPage extends StatefulWidget {
  final String key1;

  const WebViewPage(this.key1, {Key? key}) : super(key: key);

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  late BuildContext ctx;

  bool isLoading = true, isLoaded = false;
  String? sID;

  @override
  void initState() {
    getSessionData();
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: isLoaded
              ? WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: AppUrl.mainUrl + "place_order?${widget.key1}",
                  onPageFinished: (String url) {
                    setState(() {
                      isLoading = false;
                      if (url.contains("success")) {
                        STM().successDialogWithReplace(
                            ctx, "Order Placed successfully", const Order());
                      } else if (url.contains("error")) {
                        var separated = url.split("error/");
                        String message = separated[1];
                        message = message.replaceAll("%20", " ");
                        function() {
                          STM().back2Previous(ctx);
                        }
                        STM().errorDialogWithFunction(ctx, message, function);
                      }
                    });
                  },
                )
              : Container()),
    );
  }

  //Get detail
  getSessionData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      sID = sp.getString("user_id");
      isLoaded = true;
    });
  }
}
