import 'package:flutter/material.dart';
import 'package:quick_room_services/toolbar/toolbar.dart';
import 'package:quick_room_services/values/dimens.dart';
import 'package:quick_room_services/values/styles.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({Key? key}) : super(key: key);

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbar1Layout('About Us', context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dim().d20,
              ),
              Text(
                "About The Cars Doctor (TCD)",
                style: Sty().mediumText,
              ),
              Text(
                "Inspect before you invest ",
                style: Sty().mediumText,
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Text(
                "A comprehensive used car evaluation package, to help determine the quality of the car before you invest. With TCD, get the speed of automation and the assurance of physical inspection. Our qualified engineers take care to thoroughly inspect the vehicle across a comprehensive checklist and provide a detailed evaluation report, including vehicle & documents details with images and chassis imprint along with refurbishment cost.",
                style: Sty().mediumText,
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Text(
                "Our Work Process",
                style: Sty().mediumText,
              ),
              Text(
                "We only need the name, address and phone number of the seller along with the Make and Model of car. We contact the seller to let him know that you have retained our services and that our nearest inspector will be calling him shortly to arrange a convenient time to inspect the car. When the completed report is ready, we send you an email to let you know that you can view it on our website. We also provide a phone number for you to call us if you have any questions. That's it! - The whole thing is usually accomplished in 24 hours. Our detailed reports cover an extensive amount of information, digital photos & pricing guidance",
                style: Sty().mediumText,
              ),
              SizedBox(
                height: Dim().d28,
              ),
              Text(
                "Why Choose Us",
                style: Sty().mediumText,
              ),
              SizedBox(
                height: Dim().d16,
              ),
              Text(
                "Simply, because our mission is to provide you with a premium service. Our feeling has always been that you should get all the information you need from an inspection, because one key thing that gets missed could end up costing you hundreds or even thousands of Rupees. You need to know all the car's faults BEFORE you invest it, not when it gets delivered to you.",
                style: Sty().mediumText,
              ),
              SizedBox(
                height: Dim().d16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
