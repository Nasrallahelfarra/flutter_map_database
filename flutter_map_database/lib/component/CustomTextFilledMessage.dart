import 'package:flutter/material.dart';
import 'package:flutter_map_database/Helper/constants.dart';


class CustomTextFilledMessage extends StatelessWidget {
   String hintText;
   String iconsvg;
   String lable;
   int type=0;
   FormFieldValidator<String> validator;
  ValueChanged<String> onChanged;
    TextEditingController controller;


   CustomTextFilledMessage({
    Key key,
    this.hintText,
    this.lable,
    this.iconsvg ,
    this.onChanged,
    this.controller,
    this.validator,
    this.type
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      textAlignVertical: TextAlignVertical.top,


      expands:true ,
      maxLines: null,
      controller: controller,
    onChanged: onChanged,
    validator: validator,
    cursorColor: kPrimaryColor,
    decoration: InputDecoration(
      labelText: lable,
    hintText: hintText,
    border: InputBorder.none,
    ),

    );
    }


}
