import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quick_room_services/values/dimens.dart';
import 'package:quick_room_services/values/global_urls.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'manage/static_method.dart';
import 'place_order.dart';
import 'values/colors.dart';
import 'values/styles.dart';

// void main() => runApp(Altroz());

class CarModelInspectionDetails extends StatefulWidget {
  String? brand_name;
  String? car_model;
  String? brandId;
  String? modelId;
  String? manufacturingYear;
  String? inspectionPrice;

  CarModelInspectionDetails(this.brand_name, this.car_model, this.manufacturingYear, this.inspectionPrice, this.brandId, this.modelId);

  @override
  State<CarModelInspectionDetails> createState() => _CarModelInspectionDetailsState(brand_name, car_model, manufacturingYear, inspectionPrice, brandId, modelId);
}

class _CarModelInspectionDetailsState extends State<CarModelInspectionDetails> {
  late BuildContext ctx;
  String? brand_name;
  String? car_model;
  String? brandId;
  String? modelId;
  String? manufacturingYear;
  String? inspectionPrice;

  _CarModelInspectionDetailsState(this.brand_name, this.car_model, this.manufacturingYear, this.inspectionPrice, this.brandId, this.modelId);
    TextEditingController supplierNameController = TextEditingController();
    TextEditingController mobileNumberController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController addressNearByLandmarkController = TextEditingController();
    TextEditingController addressPincodeController = TextEditingController();
    TextEditingController addressStateController = TextEditingController();
    TextEditingController addressCityController = TextEditingController();
    TextEditingController dateForInspectionController = TextEditingController();

    String? selectedCity;
    String? selectedState;

    List<dynamic> onlyCities = [];
    
    final formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    ctx = context;




    return Scaffold(
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
            '$brand_name > $car_model',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                foreground: Paint()
                  ..shader = Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dim().d16),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Align(
            
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'Seller Name',
                          style: TextStyle(
                            fontSize: 16,
                            color: Clr().black
                          ),
                          children: [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Clr().red
                              )
                            )
                          ]
                        ),
                      ),
                  ),
                  SizedBox(
                    height: Dim().d12,
                  ),
                  TextFormField(
                    controller: supplierNameController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please fill this field";
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      // label: Text('Enter Your Number'),
                      hintText: "Enter Seller Name",
            
            
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Clr().black,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                          text: 'Contact Number',
                          style: TextStyle(
                              fontSize: 16,
                              color: Clr().black
                          ),
                          children: [
                            TextSpan(
                                text: ' *',
                                style: TextStyle(
                                    color: Clr().red
                                )
                            )
                          ]
                      ),
                    ),),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: mobileNumberController,
                    validator: (value) {
                      if(value!.length != 10){
                        return "Please enter your valid mobile number";
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      // label: Text('Enter Your Number'),
                      counterText: "",
                      hintText: "Enter Mobile Number",
            
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Clr().black,
                      )),
                    ),
                  ),
            
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Address',
                          style: Sty().largeText.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Clr().black,
                              ))),
            
                  SizedBox(
                    height: 16,
                  ),
            
                  // Outined Text Form Field
                  TextFormField(
                    controller: addressController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please fill this field";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'House No., Building Name',
                      // errorText: 'Error message',
                      border: OutlineInputBorder(),
                    ),
                  ),
            
                  SizedBox(
                    height: 20,
                  ),
            
                  // Outined Text Form Field
                  TextFormField(
                    controller: addressNearByLandmarkController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please fill this field";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Add Nearby Famous Shop/Mall/Landmark',
                      // errorText: 'Error message',
                      border: OutlineInputBorder(),
                    ),
                  ),
            
                  SizedBox(
                    height: 20,
                  ),
                  // Outined Text Form Field
                  TextFormField(
                    controller: addressPincodeController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please fill this field";
                      }
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      labelText: 'Pincode',
                      // errorText: 'Error message',
                      border: OutlineInputBorder(),
                    ),
                  ),
            
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("   State"),
                            Container(
                              decoration: BoxDecoration(border: Border.all(width: 2, color:Color.fromARGB(255, 230, 230, 230)), borderRadius: BorderRadius.circular(10)),
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<dynamic>(
                      hint: Text(
                            selectedState ?? 'Select State',
                            style: TextStyle(color: selectedState != null ? Colors.black : Colors.grey),
                      ),
                      onTap: () {
                            FocusManager.instance.primaryFocus!.unfocus();
                      },
                      // value: categoriesSelectedString,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      onChanged: (value) {
                            setState(() {
                              selectedState = value.toString();
                              selectedCity = null;
                              onlyCities = stateRespectiveCitiesJson[0][selectedState];
                            });
                      },
                      items: statesJson.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                      }).toList(),
                    ),
                  ),
                ),
              ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("   City"),
                            Container(
                              decoration: BoxDecoration(border: Border.all(width: 2, color:Color.fromARGB(255, 230, 230, 230)), borderRadius: BorderRadius.circular(10)),
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<dynamic>(
                      hint: Text(
                            selectedCity ?? 'Select City',
                            style: TextStyle(color: selectedCity != null ? Colors.black : Colors.grey),
                      ),
                      onTap: () {
                            FocusManager.instance.primaryFocus!.unfocus();
                      },
                      // value: categoriesSelectedString,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      onChanged: (value) {
                            setState(() {
                              selectedCity = value.toString();
                            });
                      },
                      items: onlyCities.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                      }).toList(),
                    ),
                  ),
                ),
              ),
                          ],
                        ),
                      ),
                    ],
                  ),
            
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Select Date for Inspection ',
                          style: Sty().largeText.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Clr().black,
                              ))),
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2100));
 
                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    dateForInspectionController.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                  // errorAlert(context, "No Date selected");
                }
                    },
                    child: TextFormField(
                      
                      controller: dateForInspectionController,
                      validator: (value){
                      if(value!.isEmpty){
                        return "Please fill this field";
                      }
                    },
                      // readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_today_outlined),
                        contentPadding: EdgeInsets.all(8),
                        // label: Text('Enter Your Number'),
                        // hintText: dateForInspectionController.text.isNotEmpty ? dateForInspectionController.text : "Pick date",
                              
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Clr().black,
                        )),
                      ),
                    ),
                  ),
            
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if(formkey.currentState!.validate() && (selectedState != null && selectedCity != null)){
                        STM().redirect2page(ctx, PlaceOrder(
                          brand_name.toString(),
                          car_model.toString(),
                          manufacturingYear.toString(),
                          supplierNameController.text.toString(),
                          mobileNumberController.text.toString(),
                          addressController.text.toString(),
                          addressNearByLandmarkController.text.toString(),
                          addressPincodeController.text.toString(),
                          // addressStateController.text.toString(),
                          // addressCityController.text.toString(),
                          selectedState.toString(),
                          selectedCity.toString(),
                          dateForInspectionController.text.toString(),
                          inspectionPrice.toString(),
                          brandId.toString(),
                          modelId.toString()
                        ));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dim().d16, horizontal: Dim().d60),
                      decoration: BoxDecoration(
                        gradient: Sty().linearGradient,
                        borderRadius: BorderRadius.circular(
                          Dim().d4,
                        ),
                      ),
                      margin: EdgeInsets.all(20),
                      child: Text(
                        'Proceed',
                        style: Sty().mediumText.copyWith(
                              color: Clr().white,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
