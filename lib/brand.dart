import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'car_model_inspection_form.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/global_urls.dart';
import 'values/styles.dart';

void main() => runApp(Brand());

class Brand extends StatefulWidget {
  @override
  State<Brand> createState() => _BrandState();
}

class _BrandState extends State<Brand> {
  late BuildContext ctx;

  List<dynamic> resultList = [];
  List<dynamic> searchList = [];
  bool searchTriggered = false;
  TextEditingController searchController = TextEditingController();


  void getAllBrands() async {
    load(context);
    SharedPreferences sp = await SharedPreferences.getInstance();
    var dio = Dio();
    var formData = FormData.fromMap({
      "user_id" : sp.getString("user_id").toString()
    });
    // , data: formData
    var response = await dio.get(getAllBrandsUrl());
    if(globalDebugMode()){
    print(response);
    }
    final result = response.data;
    dismissLoad(context);    

    setState(() {
      resultList = result;
    });

    // if(result['error'] != true){

    // }
    // else{

    // }
  }

  void performInAppBrandSearch(){
     if(!searchController.text.isNotEmpty){
        setState(() {
          searchTriggered = false;
        });
      }
      else{
        setState(() {
          searchList = [];
          RegExp reg = new RegExp((searchController.text.toString()), caseSensitive: false);
          resultList.forEach((element) {
            if(reg.firstMatch(element['brand_name'].toString()) != null){
              searchList.add(element);
            }
          });
          searchTriggered = true;
          searchList = searchList;
        });
      }
}

   @override
  void initState() {
    Future.delayed(
      Duration.zero,
      (){
        getAllBrands();
      }
    );
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
              'Brands',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  foreground: Paint()
                    ..shader = Sty().linearGradient.createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
            ),
          ),
          body: resultList.length != 0 ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [

                  TextFormField(
                    controller: searchController,
                    onChanged: (value){
                      performInAppBrandSearch();            
                    },
                    decoration: InputDecoration(
                      fillColor: Color(0xffFBF7F6),
                      filled: true,
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(Icons.search_outlined,color: Color(0xffE48260),),
                      ),

                      hintText: "Search by Brand",
                      hintStyle: TextStyle(color: Color(0xffE48260)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Clr().transparent,
                          )),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Clr().transparent,
                      )),
                    ),
                  ),
                  Visibility(
                    visible: !searchTriggered,
                    child: Padding(
                      padding: EdgeInsets.all(Dim().d8),
                      child: GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(resultList.length, (index) {
                          return InkWell(
                            onTap: (){
                             STM().redirect2page(context, CarModelInspectionForm(resultList[index]['brand_name'].toString(), resultList[index]['id'].toString(), )) ;
                            },
                            child: Column(
                              children: [
                                // Padding(
                                // padding: EdgeInsets.symmetric(
                                //     vertical: Dim().d2
                                //     , horizontal: Dim().d2
                                // ),
                                // ),
                                Container(
                                  decoration: BoxDecoration(
                          
                                      color: Clr().white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Clr().lightGrey)),
                                  child: Column(
                                    children: [
                                      Center(
                                          child:
                                              Padding(
                                                padding: const EdgeInsets.only(top: 2, bottom: 2),
                                                child: CachedNetworkImage(imageUrl: resultList[index]['image_path'].toString(), width: 50, height: 50,),
                                              )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(resultList[index]['brand_name'].toString(),overflow: TextOverflow.ellipsis,)
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),




                  // on search text box trigger
                  Visibility(
                    visible: searchTriggered,
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Text("Search"),
                        SizedBox(height: 10,),
                        searchList.length != 0 ? Padding(
                          padding: EdgeInsets.all(Dim().d8),
                          child: GridView.count(
                            crossAxisCount: 4,
                            shrinkWrap: true,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 10,
                            physics: NeverScrollableScrollPhysics(),
                            children: List.generate(searchList.length, (index) {
                              return InkWell(
                                onTap: (){
                                 STM().redirect2page(context, CarModelInspectionForm(searchList[index]['brand_name'].toString(), searchList[index]['id'].toString(), )) ;
                                },
                                child: Column(
                                  children: [
                                    // Padding(
                                    // padding: EdgeInsets.symmetric(
                                    //     vertical: Dim().d2
                                    //     , horizontal: Dim().d2
                                    // ),
                                    // ),
                                    Container(
                                      decoration: BoxDecoration(
                              
                                          color: Clr().white,
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(color: Clr().lightGrey)),
                                      child: Column(
                                        children: [
                                          Center(
                                              child:
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                                                    child: CachedNetworkImage(imageUrl: searchList[index]['image_path'].toString(), width: 50, height: 50,),
                                                  )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(searchList[index]['brand_name'].toString())
                                  ],
                                ),
                              );
                            }),
                          ),
                        ) : Text("No match found"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ) : Center(child: Text("No brands found!"),),
        );
  }
}
