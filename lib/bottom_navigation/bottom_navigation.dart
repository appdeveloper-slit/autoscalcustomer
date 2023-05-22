import 'package:flutter/material.dart';
import 'package:quick_room_services/bn_order.dart';
import 'package:quick_room_services/bn_profile.dart';

import '../bn_home.dart';
import '../manage/static_method.dart';
import '../service.dart';
import '../values/colors.dart';

Widget bottomBarLayout(ctx, index) {
  return BottomNavigationBar(
    backgroundColor: Clr().white,
    selectedItemColor: Color(0xFF69A9F0),
    unselectedItemColor: Clr().black,
    type: BottomNavigationBarType.fixed,
    currentIndex: index,
    onTap: (i) async {
      switch (i) {
        case 0:
          if(index != 0){
            STM().redirect2page(ctx, Home());
          }
          break;
        case 1:
          if(index != 1){
            STM().redirect2page(ctx, const Order());
          }
          break;
        case 2:
          if(index != 2){
            STM().redirect2page(ctx, const Services());
          }
          break;
        case 3:
          if(index != 3){
            STM().redirect2page(ctx, const Profile());
          }
          break;
      }
    },
    items: STM().getBottomList(index),
  );
}