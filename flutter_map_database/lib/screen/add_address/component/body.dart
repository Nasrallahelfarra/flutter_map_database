import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_database/Helper/dbhelper.dart';
import 'package:flutter_map_database/component/CustomTextFilled.dart';
import 'package:flutter_map_database/component/CustomTextFilledMessage.dart';
import 'package:flutter_map_database/component/RoundButtom.dart';
import 'package:flutter_map_database/data/model/Location.dart';
import 'package:flutter_map_database/utility/size_config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
class Body extends StatefulWidget {
static  LatLng center=LatLng(0.0, 0.0);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double latitude=0.0;
  double longitude=0.0;
  List<Marker> myMarkers = []; //collection
  StreamSubscription<Position> _positionStreamSubscription;
  Completer<GoogleMapController> _controller ;
  Position currentLocation;
  DbHelper dbHelper;
  GlobalKey<FormState> fromKey;

  TextEditingController _textEditingControllerTitle;
  TextEditingController _textEditingControllerDetails;
  @override
   initState() {
    dbHelper=DbHelper();
    fromKey=GlobalKey<FormState>();

    _textEditingControllerTitle=TextEditingController();
    _textEditingControllerDetails=TextEditingController();
   _controller = Completer();

   getUserLocation();
   // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription.cancel();
      _positionStreamSubscription = null;
    }

    _textEditingControllerTitle.dispose();
    _textEditingControllerDetails.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("Body.center");
    print(Body.center);
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.topCenter,
      child: Form(
        key: fromKey,
        child: Column(
          children: [
            Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 10,),
                      BildeTextTitle(),
                      SizedBox(height: 10,),
                      SizedBox(
                        height: getProportionateScreenHeight(100),
                        child: BildeTextDesc()),
                      SizedBox(height: 10,),

                      SafeArea(
                        child: Container(
                          height: SizeConfig.screenHeight*0.5,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                              target: Body.center,
                              zoom: 14.4746,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            onTap: _handleTap,
                            markers: Set.from(myMarkers),

                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

            SizedBox(height: 10,),

            ReoundButtom(title: "Add Addresse",
              press: (){
               if(fromKey.currentState.validate()){


                Locations location=Locations({'lat':latitude.toString(),'lng':longitude.toString()
                ,'title':_textEditingControllerTitle.text,
                'desc':_textEditingControllerDetails.text,'image':"null"});
                dbHelper.createLocations(location).then((value) {
                  dbHelper.alllocation().then((value) {
                   List<Locations>listLocations=[];
                   for(var item in value){
                     listLocations.add(Locations.fromMap(item));

                   }
                    print(listLocations.length);

                  });

                });
                   Get.back();

               }

            },)
          ],
        ),
      ),
    );
  }
  CameraPosition _kGooglePlex(double lat,double long){
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 14.4746,
    );
    return _kGooglePlex;
  }
    Widget BildeTextTitle(){
    return  CustomTextFilled(
    hintText: "title ",
    lable: 'title' ,
    controller: _textEditingControllerTitle,

    validator: (value) {
    if (value.isEmpty) {
    return "not Empty";
    }
    return null;
    },

    );

    }
  Widget BildeTextDesc(){
    return  CustomTextFilledMessage(
      hintText: "Details ",
      lable: 'Details' ,
      controller: _textEditingControllerDetails,

      validator: (value) {
        if (value.isEmpty) {
          return "not Empty";
        }
        return null;
      },

    );

  }
  Future<void> getLoacation() async {
    Geolocator.getCurrentPosition().then((value) {
      Position mPosition=value;
      print("lat");
      print(mPosition.latitude);
      print(mPosition.longitude);



    });

  }
  _handleTap(LatLng point) {
    latitude=point.latitude;
    longitude=point.longitude;
    setState(() {
      myMarkers=[];
      myMarkers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'I am a marker',
        ),
        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ));
    });
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    locateUser().then((value) {
      currentLocation=value;
      latitude=currentLocation.latitude;
      longitude=currentLocation.longitude;
      _goToTheLake();
      LatLng point=LatLng(latitude,longitude);
      _handleTap(point);
      print('center ${Body.center}');
    });

  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex(latitude,longitude)));
  }
}

