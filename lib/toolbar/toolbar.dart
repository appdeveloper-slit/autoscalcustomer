import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import '../values/colors.dart';

import '../values/dimens.dart';
import '../values/styles.dart';

PreferredSizeWidget toolbar1Layout(title, ctx) {
  return AppBar(
    backgroundColor: Clr().white,
    elevation: 5,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          foreground: Paint()
            ..shader = Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 35.0, 200.0, 70.0))),
    ),
    leading: Padding(
      padding: EdgeInsets.all(
        Dim().d20,
      ),
      child: InkWell(
          onTap: () {
            // STM.back2Previous(ctx);
            Navigator.pop(ctx);
          },
          child: Icon(
            Icons.arrow_back,
            color: Color(0xffE48260),
          )
          // Image.asset(
          //   'assets/arrow-left.png',
          //   color: Colors.black,
          //   height: Dim().d100,
          // ),
          ),
    ),
  );
}

PreferredSizeWidget toolbar3Layout(ctx, scaffoldKey) {
  return AppBar(
      backgroundColor: Clr().white,
      elevation: 0,
      centerTitle: true,
      title: Image.asset(
        'assets/Logo.png',
        height: Dim().d36,
      ),
      // ),
      leading: IconButton(
        onPressed: () => scaffoldKey.currentState!.openDrawer(),
        icon: Padding(
          padding: EdgeInsets.all(Dim().d8),
          child: Image.asset(
            'assets/menu.png',
            color: Clr().colorblue,
            height: Dim().d140,
          ),
        ),
      ));
}

PreferredSizeWidget toolbar2Layout(ctx, scaffoldKey) {
  return AppBar(
    toolbarHeight: Dim().d60,
    backgroundColor: Color(0xff2D61B6),
    leading: IconButton(
      padding: const EdgeInsets.only(
        left: 12,
      ),
      icon: SvgPicture.asset(
        'assets/menu.svg',
        height: Dim().d20,
        color: Clr().white,
      ),
      onPressed: () => scaffoldKey.currentState!.openDrawer(),
    ),
    centerTitle: true,
    title: Text(
      'Studyleague IT Solut ...',
      style: Sty().largeText.copyWith(
            color: Clr().white,
          ),
    ),
    actions: [
      Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: Image.asset(
                'assets/signin/notification.png',
                height: Dim().d40,
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {

          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(
          //       right: 20,
          //     ),
          //     child: SvgPicture.asset(
          //       'assets/cart.svg',
          //       height: Dim().d20,
          //     ),
          //   ),
          // ),
        ],
      ),
    ],
  );
}

PreferredSizeWidget toolbar5Layout(title) {
  return AppBar(
    backgroundColor: Clr().primaryColor,
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      style: Sty().mediumText.copyWith(
            color: Clr().white,
            fontSize: 20,
          ),
    ),
    leading: Padding(
      padding: EdgeInsets.all(
        Dim().d20,
      ),
      child: SvgPicture.asset(
        'assets/back.svg',
        color: Clr().white,
      ),
    ),
  );
}
