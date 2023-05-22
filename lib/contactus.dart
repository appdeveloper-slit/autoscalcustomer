import 'package:flutter/material.dart';
import 'package:quick_room_services/toolbar/toolbar.dart';
import 'package:quick_room_services/values/dimens.dart';
import 'package:quick_room_services/values/styles.dart';

class Contactus extends StatefulWidget {
  const Contactus({Key? key}) : super(key: key);

  @override
  State<Contactus> createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbar1Layout('Contact Us', context),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('==Mobile==',style: Sty().mediumBoldText,),
          Text('8669665959',style: Sty().mediumBoldText,),
          SizedBox(height: Dim().d12,),
          Text('==Email Id==',style: Sty().mediumBoldText,),
          Text('contactus@thecarsdoctor.com',style: Sty().mediumBoldText,),
          SizedBox(height: Dim().d12,),
          Text('==Address==',style: Sty().mediumBoldText,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: Dim().d32),
            child: Wrap(
              children: [
                Text('Opp Premier colony ground, Near hotel Tourist Dhabha, Kalyan - Shill road, Dombivali east, Dist- Thane- 421204.',style: Sty().mediumBoldText,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
