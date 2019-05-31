import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class MapX extends StatefulWidget {
  @override
  _MapXState createState() => _MapXState();
}

class _MapXState extends State<MapX>{
  PermissionStatus _status;
  Position currPosition;
  
  @override
  void initState(){
    super.initState();

    PermissionHandler().requestPermissions([PermissionGroup.locationWhenInUse])
    .then(_onStatusRequested);

    PermissionHandler().checkPermissionStatus(PermissionGroup.locationWhenInUse)
    .then(_updateStatus);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initCurrentLocation() async {
    Position position;
    // Platform messages may fail, so we use a try/catch PlatformException.
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = true;
      position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      currPosition = position;
    });
  }

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses){
    final status = statuses[PermissionGroup.locationWhenInUse];
    _updateStatus(status);
  }

  void _updateStatus(PermissionStatus status){
    if(status != _status){
      setState(() {
        _status = status;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    GoogleMapController mapController;
    LatLng _center = const LatLng(37.422, -122.084);
    Set<Marker> markers = Set();

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
      }
    // TODO: implement build
    return (GoogleMap(
            myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          )));
    }
}