import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quick_room_services/manage/static_method.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'car_model_inspection_details_form.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/global_urls.dart';
import 'values/styles.dart';

// void main() => runApp(Mahindra());

class CarModelInspectionForm extends StatefulWidget {

  String? brand_name;
  String? brand_id;
  CarModelInspectionForm(this.brand_name, this.brand_id);

  @override
  State<CarModelInspectionForm> createState() => _CarModelInspectionFormState(brand_name, brand_id);
}

class _CarModelInspectionFormState extends State<CarModelInspectionForm> {
  late BuildContext ctx;
  String? brand_name;
  String? brand_id;
  _CarModelInspectionFormState(this.brand_name, this.brand_id);

  String? selectedModelNumber;
  String? selectedModelNumberId;
  List<dynamic> arrayList = [];
  List<String> manufacturingYearDropDownList = [];
  String? selectedManufacturingYear;
  String inspectionPrice = "";
  // String v = "0";

  // String? modelId;


  void getCarModelInspectionFormData() async {
    load(context);
    SharedPreferences sp = await SharedPreferences.getInstance();
    var dio = Dio();
    var formData = FormData.fromMap({
      "id" : brand_id.toString()
    });
    var response = await dio.post(getModelUrl(), data: formData);
    if(globalDebugMode()){
    print(response);
    }
    final result = response.data;
    dismissLoad(context);

    // if(result['error'] != true){
      arrayList = [];
      for(int i = 0; i < result.length; i++){
        arrayList.add(result[i]);
      }

      var yearnow = new DateTime.now().year.toInt();
      for (int i = 0; i < 30; i++){
        manufacturingYearDropDownList.add(yearnow.toString());
        yearnow = yearnow - 1;  
      }

      setState(() {
        arrayList = arrayList;
      });
    // }
    // else{

    // }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, (){
     getCarModelInspectionFormData(); 
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return  Scaffold(
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
                brand_name.toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    foreground: Paint()
                      ..shader = Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
              ),
            ),
            body: SingleChildScrollView(
              child: (arrayList.length != 0) ? Padding(
                padding: EdgeInsets.all(Dim().d16),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Car Model',
                            style: Sty()
                                .largeText
                                .copyWith(fontWeight: FontWeight.w500))),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          (arrayList.length != 0) ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(Dim().d8)),
                                border: Border.all(
                                  color: Clr().lightGrey,
                                )),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<dynamic>(
                                // value: selectedValue,
                                hint: Text(selectedModelNumber != null ? selectedModelNumber.toString(): "Select a model"),
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down),
                                style: TextStyle(color: Color(0xff000000)),
                                items: arrayList.map((value) {
                                  return DropdownMenuItem<dynamic>(
                                    value: value,
                                    child: Text(value['model_no']),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  // STM().redirect2page(ctx, Home());
                                  print(value['model_no']);
                                  setState(() {
                                    // selectedValue = v;
                                    // if(value != null){
                                       inspectionPrice = value['price'];
                                       selectedModelNumber = value['model_no'];
                                       selectedModelNumberId = value['id'].toString();

                                    //    print(inspectionPrice);
                                    // }
                                   
                                  });
                                },
                              ),
                            ),
                          ) : Text("No Model Found"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Manufacturing Year',
                            style: Sty()
                                .largeText
                                .copyWith(fontWeight: FontWeight.w500))),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(Dim().d8)),
                                border: Border.all(
                                  color: Clr().lightGrey,
                                )),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                // value: selectedManufacturingYear,
                                hint: Text(selectedManufacturingYear != null ? selectedManufacturingYear.toString() : "Select Manufacturing Year"),
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down),
                                style: TextStyle(color: Color(0xff000000)),
                                items: manufacturingYearDropDownList.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  // STM().redirect2page(ctx, Home());
                                  setState(() {
                                    // selectedValue = value!;
                                    selectedManufacturingYear = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    (arrayList.length != 0) ? InkWell(
                      onTap: () {
                        if(inspectionPrice.isNotEmpty && selectedManufacturingYear != null && selectedModelNumber != null){
                          STM().redirect2page(ctx, CarModelInspectionDetails(brand_name.toString(), selectedModelNumber.toString(), selectedManufacturingYear.toString(), inspectionPrice.toString(), brand_id.toString(), selectedModelNumberId.toString()));
                        }
                        else{
                          alert(context, "Please select manufacturing year and model in order to continue.");
                        }
                        
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dim().d16, horizontal: Dim().d40),
                        decoration: BoxDecoration(
                          gradient: Sty().linearGradient,
                          borderRadius: BorderRadius.circular(
                            Dim().d4,
                          ),
                        ),
                        margin: EdgeInsets.all(0),
                        child: Wrap(
                          children: [
                            Text(
                              inspectionPrice.isNotEmpty ? 'Inspection Price : \u20b9 $inspectionPrice' : 'Select model to continue',
                              style: Sty().mediumText.copyWith(
                                color: Clr().white,
                              ),
                            ),
                            SizedBox(width: 22,),
                            Icon(Icons.arrow_forward_ios_rounded,
                            color: Clr().white,
                            size: 18,)
                          ],
                        ),
                      ),
                    ) : Container(),
                  ],
                ),
              ) : Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
                child: Center(child: Text("No Model Found"),)),
            ));
  }
}
