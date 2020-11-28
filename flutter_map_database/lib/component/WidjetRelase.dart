import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_database/Helper/constants.dart';
import 'package:get/get.dart';

import 'RoundButtom.dart';
class WidjetRelase{

  static WidjetRelase WidjetRelaseInstabse=null;

  static WidjetRelase getIntanse(){
    if(WidjetRelaseInstabse==null){
      WidjetRelaseInstabse=new WidjetRelase();
    }
    return WidjetRelaseInstabse;
  }
  Widget Loading(){
    return  Center(

        child: CircularProgressIndicator(),
      );

  }

  AppBar appBar({String title,List<Widget> actions}){
    return AppBar(
      centerTitle:true,
      title: Text(title.tr,style: TextStyle(color: Colors.white),),
      backgroundColor:kPrimaryColor,
      actions: (actions!=null)?<Widget>[]:actions

    );
  }

}