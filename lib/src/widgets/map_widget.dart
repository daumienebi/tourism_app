import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapWidget extends StatefulWidget{
  const MapWidget({Key? key}) : super(key: key);

  @override

  State<MapWidget> createState() => _MapWidgetState();

}

class _MapWidgetState extends State<MapWidget>{

  //double latitude =  43.362343;
  //double longitude = -8.411540;
  //camera initial position
  Set<Marker> _markerList = {};
  Marker? _location;
  final Marker _marker = Marker(markerId: MarkerId("randomMarker"),
    infoWindow: const InfoWindow(
      title: 'Damian',
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    position: LatLng(43.362343,-8.411540)
  );
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(43.362343,-8.411540),
      zoom: 11.5
  );



  //Google Map stuffs
  CameraPosition _cameraPosition = _initialCameraPosition;
  final bool _mapCreated = false;
  final bool _mapMoving = false;
  final bool _compasActivated = true;
  final bool _toolBarActivated = true;
  final CameraTargetBounds _cameraTargetBounds = CameraTargetBounds.unbounded;
  final MinMaxZoomPreference _minMaxZoomPreference = MinMaxZoomPreference.unbounded;
  final MapType _mapType = MapType.normal;
  final bool _rotationActivated = true;
  final bool _scrollActivated = true;
  final bool _tiltActivated = true;
  final bool _zoomGestureActivated = true;
  final bool _zoomControlsActivated = true;
  final bool _interiorViewActivated = true;
  final bool _trafficActivated = false;
  final bool _localizationActivated = true;
  final bool _localizationButtonActivated = true;
  late GoogleMapController _mapController; //must be instanciated or defined as late
  final bool _nightMode = false;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   final GoogleMap googleMap = GoogleMap(

     initialCameraPosition: _initialCameraPosition,
     compassEnabled: _compasActivated,
     mapToolbarEnabled: _toolBarActivated,
     cameraTargetBounds: _cameraTargetBounds,
     minMaxZoomPreference: _minMaxZoomPreference,
     mapType: _mapType,
     rotateGesturesEnabled: _rotationActivated,
     scrollGesturesEnabled: _scrollActivated,
     tiltGesturesEnabled: _tiltActivated,
     zoomControlsEnabled: _zoomControlsActivated,
     zoomGesturesEnabled: _zoomGestureActivated,
     myLocationButtonEnabled: _localizationActivated,
     myLocationEnabled: _localizationButtonActivated,
     onMapCreated: onMapCreate,
     //onCameraMove: _updateCameraPosition,
     trafficEnabled: _trafficActivated,
     onLongPress: _addMarkerToMap,
     markers: _markerList

   );

   return Scaffold(
     body: googleMap,
     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.map),
       onPressed: (){}
     ),
   );
  }

  void _onLongPress(){
    setState(() {
      _mapController.animateCamera
        (CameraUpdate.newCameraPosition(_initialCameraPosition));
    });
  }

  void _updateCameraPosition (CameraPosition position){
    setState(() {
      _cameraPosition = position;
    });
  }


  void _addMarkerToMap(LatLng position){
    //Receives the position add add the marker to the map
      setState(() {
        int id =1;
        Marker newMarker = Marker(
            markerId: MarkerId('selectedLocation'),
            infoWindow: const InfoWindow(
              title: 'Selected Location'
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
            position: position

        );
        _markerList.add(newMarker);
        openDialog();
      });
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add new Location"),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Enter the location name'
          ),
        ),
        actions: [
          TextButton(
              onPressed: (){print("tpm");},
              child: Text("submit")
          )
        ],
      )
  );
  void onMapCreate(GoogleMapController mapController){
    setState(() {
      _mapController = _mapController;
    });
  }
}