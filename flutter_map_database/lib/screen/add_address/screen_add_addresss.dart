import 'package:flutter/material.dart';
import 'package:flutter_map_database/component/WidjetRelase.dart';
import 'package:flutter_map_database/utility/size_config.dart';

import 'component/body.dart';
class AddAddresses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: WidjetRelase.getIntanse().appBar(title: "View Address"),
      body: Body(),
    );
  }
}
