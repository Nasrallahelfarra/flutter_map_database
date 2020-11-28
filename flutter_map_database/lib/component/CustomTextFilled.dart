import 'package:flutter/material.dart';
import 'package:flutter_map_database/Helper/constants.dart';
import 'package:get/get.dart';

class CustomTextFilled extends StatelessWidget {
   String hintText;
   String iconsvg;
   String lable;
   FormFieldValidator<String> validator;
   ValueChanged<String> onChanged;
   TextEditingController controller;


  CustomTextFilled({
    Key key,
    this.hintText,
    this.lable,
    this.iconsvg ,
    this.onChanged,
    this.controller,
    this.validator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return TextFormField(
    controller: controller,
    onChanged: onChanged,
    validator: validator,

    cursorColor: kPrimaryColor,
    decoration: InputDecoration(
     labelText: lable.tr,
      hintText: hintText.tr,
    border: InputBorder.none,
    ),

    );
    }


}
