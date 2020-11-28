class Locations {
  int _id;
  String _lat;
  String _lng;
  String _title;
  String _desc;
  String _image;


  Locations(dynamic obj){
    _id = obj['id'];
    _lat = obj['lat'];
    _lng = obj['lng'];
    _title = obj['title'];
    _desc = obj['desc'];
    _image = obj['image'];
  }
  Locations.fromMap(Map<String,dynamic> obj){
    _id = obj['id'];
    _lat = obj['lat'];
    _lng = obj['lng'];
    _title = obj['title'];
    _desc = obj['desc'];
    _image = obj['image'];
  }
  Map<String, dynamic> toMap() => {'id' : _id,'lat' : _lat,'lng' : _lng, 'title' : _title,'desc' : _desc, 'image':_image};
  int get id => _id;
  String get lat => _lat;
  String get lng => _lng;
  String get title => _title;
  String get desc => _desc;
  String get image => _image;

}