import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map_database/Helper/dbhelper.dart';
import 'package:flutter_map_database/component/CustomeText.dart';
import 'package:flutter_map_database/component/WidjetRelase.dart';
import 'package:flutter_map_database/data/model/Location.dart';
import 'package:flutter_map_database/utility/size_config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class ViewLocations extends StatefulWidget {
  @override
  _ViewLocationsState createState() => _ViewLocationsState();
}

class _ViewLocationsState extends State<ViewLocations> {
  double latitude=0.0;
  double longitude=0.0;
  List<Marker> myMarkers = []; //collection
  Completer<GoogleMapController> _controller ;
  CameraPosition _kGooglePlexx=null;
  Position currentLocation;
  DbHelper dbHelper;
   GlobalKey<ScaffoldState> _scaffoldKey;
  BuildContext mcontext;
  @override
  void initState() {
    _scaffoldKey = GlobalKey<ScaffoldState>();
     dbHelper=DbHelper();
     _controller = Completer();
    getUserLocation();
    getLocation();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
  }
  getLocation(){
    myMarkers=[];
    dbHelper.alllocation().then((value) {
      List<Locations>listLocations=[];
      setState(() {
        for(var item in value){
          listLocations.add(Locations.fromMap(item));
          LatLng latLng=LatLng(double.parse(Locations.fromMap(item).lat),double.parse(Locations.fromMap(item).lng));
          _handleTap(latLng,Locations.fromMap(item).title,Locations.fromMap(item));

        }
      });

      print(listLocations.length);

    });
  }
  @override
  Widget build(BuildContext context) {
    mcontext=context;
    return Scaffold(
      key: _scaffoldKey,
      appBar: WidjetRelase.getIntanse().appBar(title: "add Location"),
      body: Container(
        height: SizeConfig.screenHeight,

        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(0.0, 0.0),
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          //onTap: _handleTap,
          markers: Set.from(myMarkers),

        ),
      ),
    );;
  }
  _handleTap(LatLng point,String title,Locations locations) {
    latitude=point.latitude;
    longitude=point.longitude;
    setState(() {
      myMarkers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: title,
        ),

        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
          onTap: () {
            _showBottomSheetInvoice(mcontext,locations);
          },
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
      //_handleTap(point,'my Locaion');
    });

  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex(latitude,longitude)));
  }
  CameraPosition _kGooglePlex(double lat,double long){
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 14.4746,
    );
    return _kGooglePlex;
  }
  void _showBottomSheetInvoice(BuildContext context,Locations locations) {
    //_logger.d("_showBottomSheetInvoice: ");
    _scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                margin: EdgeInsets.only(top: 100/2),
                padding: EdgeInsets.all(20),
                width: SizeConfig.screenWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomeText(title:locations.title ,fontSize: 14,color: Colors.black,),
                          IconButton(icon:Icon(Icons.remove_circle,color: Colors.red,), onPressed: (){
                            dbHelper.delete(locations.id);
                            getLocation();
                            Get.back();
                          })
                        ],
                      ),
                      SizedBox(height: 10,),
                      CustomeText(title:locations.desc ,fontSize: 12,color: Colors.black45,),

                    ],
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network('https://lh3.googleusercontent.com/VS01XqTu-LBSNvt85tukkgGh4msW4JP18wN6geHQRDzs59nX_6Pb_trS2NvBExs33Es1',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),

                ],
              )
            ],
          ));
    });
  }
}
