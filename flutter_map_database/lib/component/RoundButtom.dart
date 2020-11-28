import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_database/Helper/constants.dart';
import 'package:flutter_map_database/utility/size_config.dart';

import 'package:get/get.dart';
class ReoundButtom extends StatelessWidget {

   const ReoundButtom({Key key,
   this.title, this.colore, this.press}):super (key: key);
   final String title;
   final Color colore;
   final Function press;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.symmetric(vertical: 2),
      child: ClipRRect(
        borderRadius:BorderRadius.circular(20),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 18,horizontal: 10),
          color:(colore==null)?kColorButtom:colore ,
          onPressed: press,
          splashColor: kPrimaryColor,
          hoverColor:kPrimaryColor,
          highlightColor: kPrimaryColor,
          child: Text(title.tr,style: TextStyle(color: kTextColorButtom),),
        ),
      ),
    );
  }
}
