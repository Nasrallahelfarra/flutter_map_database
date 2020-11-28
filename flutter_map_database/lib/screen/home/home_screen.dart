import 'package:flutter/material.dart';
import 'package:flutter_map_database/component/RoundButtom.dart';
import 'package:flutter_map_database/component/WidjetRelase.dart';
import 'package:flutter_map_database/screen/add_address/screen_add_addresss.dart';
import 'package:flutter_map_database/screen/view_all_address/screen_view_location.dart';
import 'package:flutter_map_database/utility/size_config.dart';
import 'package:get/get.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: WidjetRelase.getIntanse().appBar(title: "Main"),

      body: Container(
        padding: EdgeInsets.all(20),
        height: SizeConfig.screenHeight,
        alignment:Alignment.center ,
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(100),),

            ReoundButtom(title: "Add location",
              press: (){
              //  Get.back();
              Get.to(AddAddresses());
              },),
            SizedBox(height: 20,),
            ReoundButtom(title: "View location",
              press: (){
                Get.to(ViewLocations());

                //  Get.back();

              },),
          ],
        ),
      ),
    );
  }
}
