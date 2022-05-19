import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'widgets.dart';

class MapWidget extends StatefulWidget{
  const MapWidget({Key? key}) : super(key: key);

  @override

  State<MapWidget> createState() => _MapWidgetState();

}

class _MapWidgetState extends State<MapWidget>{
  final location = Location().getLocation();
  late LocationData _userLocation;
  late LocationData _markerLocation;
  Set<Marker> _markerList = {};
  late Marker? _location;
  final Marker _marker = Marker(
      markerId: MarkerId("randomMarker"),
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
  String placeName = "";
  String desc = "";


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
    final GoogleMap googleMap = GoogleMap(

      initialCameraPosition: const CameraPosition(
          target: LatLng(43.362343,-8.411540),
          zoom: 11.5
      ),
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
      onCameraMove: _updateCameraPosition,
      trafficEnabled: _trafficActivated,
      onLongPress: _addMarkerToMap,
      markers: _markerList
    );

    return Scaffold(
      body: _createMap(),
   );

  }

  Widget _getMap(double latitude,double longitude){
    final GoogleMap googleMap = GoogleMap(

        initialCameraPosition: CameraPosition(
            target: LatLng(latitude,longitude),
            zoom: 11.5
        ),
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
        onCameraMove: _updateCameraPosition,
        trafficEnabled: _trafficActivated,
        onLongPress: _addMarkerToMap,
        markers: _markerList

    );
    return googleMap;
  }

  Widget _createMap(){
    //porque se tiene que recoger la ubicacion actual del usuario antes de crear el mapa
    return FutureBuilder(
        future: location,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            final position = snapshot.data;
            //_userLocation = position;
            return SafeArea(
                child: _getMap(position.latitude, position.longitude)
            );
          }else{
            return const Center(child: LinearProgressIndicator());
          }
        }
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
    _popUpForm();
    setState(() {
      _markerList.add(Marker(
          markerId: MarkerId('markerid'),
          infoWindow: InfoWindow(
            title: placeName,
            snippet: 'Place of interest',

          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          position: position
      )
      );
    });

  }

   _popUpForm() async{
    showDialog(
      context: context,
      builder: (_) {
        TextEditingController nameController = TextEditingController();
        TextEditingController descController = TextEditingController();
        TextEditingController latitudeController = TextEditingController(text: _cameraPosition.target.latitude.toString());
        TextEditingController longitudeController = TextEditingController(text: _cameraPosition.target.longitude.toString());
        return AlertDialog(
          title: const Text('Add a new place of interest'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecorations.nameField()
                ),
                TextFormField(
                  controller: descController,
                  decoration: InputDecorations.descField(),
                  maxLines: null,
                ),
                TextFormField(
                  controller: latitudeController,
                  decoration: InputDecorations.latField(),
                  enabled: false,
                ),
                TextFormField(
                  controller: longitudeController,
                  decoration: InputDecorations.lngField()
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                placeName = nameController.text;
                desc = descController.text;
                Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          );
        },
      );
  }

    void onMapCreate(GoogleMapController mapController){
    setState(() {
      //corregido, the equaled value vas _mapController b4
      _mapController = mapController;
    });
  }
}