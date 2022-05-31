import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:tourisim_app/src/models/visit_place.dart';
import 'package:tourisim_app/src/pages/pages.dart';
import 'package:tourisim_app/src/providers/visitplace_provider.dart';

import 'widgets.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget>
    with AutomaticKeepAliveClientMixin {
  final location = Location().getLocation();

  Set<Marker> _markerList = {};

  static const _initialCameraPosition =
      CameraPosition(target: LatLng(43.362343, -8.411540), zoom: 7.5);
  String placeName = "";
  String desc = "";
  VisitPlace p = new VisitPlace(name: 'name', description: 'description', latitude: 'latitude', longitude: 'longitude');
  //Google Map stuffs
  CameraPosition _cameraPosition = _initialCameraPosition;
  bool _mapCreated = false;
  final bool _mapMoving = false;
  final bool _compasActivated = true;
  final bool _toolBarActivated = false;
  final CameraTargetBounds _cameraTargetBounds = CameraTargetBounds.unbounded;
  final MinMaxZoomPreference _minMaxZoomPreference =
      MinMaxZoomPreference.unbounded;
  MapType _mapType = MapType.hybrid;
  final bool _rotationActivated = true;
  final bool _scrollActivated = true;
  final bool _tiltActivated = true;
  final bool _zoomGestureActivated = true;
  final bool _zoomControlsActivated = false;
  final bool _interiorViewActivated = true;
  final bool _trafficActivated = false;
  final bool _localizationActivated = true;
  final bool _localizationButtonActivated = true;
  late GoogleMapController
      _mapController; //must be instanciated or defined as late
  final bool _nightMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(context: context, builder: (BuildContext ctx){
            return Container(
                height: MediaQuery.of(context).size.height * 50,
              child:
                  ListView(
                    children: _drawerItems(context)
                  )
            );
          });
        },
        child: Icon(Icons.more_sharp,),
        backgroundColor: Colors.cyan[300] ,
      ),
      appBar: NewGradientAppBar(
        title: Text('Tourism App'),
        gradient: LinearGradient(colors: [Colors.cyan, Colors.cyan, Colors.blueAccent]),
        actions: [
          InkWell(
              child: Icon(Icons.list_alt, size: 30,),
              onTap: ()=> Navigator.pushNamed(context, 'placeslist',arguments: moveToLocation)
          ),
          //GetPlacesCount(moveToLocation: moveToLocation),
          SizedBox(width: 15,),
          InkWell(
              child: Icon(Icons.search, size: 30,),
              onTap: ()=> showSearch(context: context, delegate: MySearchBar())
            ),
          SizedBox(width: 10,),
        ],
      ),
      body: _createMap(),
    );
  }

  aa(){
    setState(() {

    });
}

  Future<Marker> _defaultMarker(latitude, longitude) async {
    BitmapDescriptor mybitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/map_icon_.png",
    );
    Marker m;
    m = Marker(
      markerId: MarkerId('default'),
      //icon: BitmapDescriptor.defaultMarker,
      icon: mybitmap,
      position: LatLng(latitude, longitude),
    );
    _markerList.add(m);
    return m;
  }

  Widget _getMap(double latitude, double longitude) {
    //VisitPlaceProvider visitPlaceProvider =
    // Provider.of<VisitPlaceProvider>(context, listen: true);
    //_markerList = visitPlaceProvider.markers;
    //print("count + ${visitPlaceProvider.markers.length}");
    return
      Consumer(
          builder: (_, VisitPlaceProvider provider, __) {
            final GoogleMap googleMap = GoogleMap(
                initialCameraPosition:
                CameraPosition(target: LatLng(latitude, longitude), zoom: 7),
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
                markers: provider.markers

            );

            //_defaultMarker(latitude,longitude);
            return googleMap;
          }
      );
  }

  Widget _getMap2(double latitude, double longitude) {
    VisitPlaceProvider visitPlaceProvider =
        Provider.of<VisitPlaceProvider>(context, listen: true);
    _markerList = visitPlaceProvider.markers;
    //print("count + ${visitPlaceProvider.markers.length}");

    final GoogleMap googleMap = GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(latitude, longitude), zoom: 7),
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
        markers: visitPlaceProvider.markers

    );

    //_defaultMarker(latitude,longitude);
    return googleMap;
  }

  Widget _createMap() {
    //porque se tiene que recoger la ubicacion actual del usuario antes de crear el mapa
    return FutureBuilder(
        future: location,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final position = snapshot.data;
            _mapCreated = true;
            //_userLocation = position;
            return SafeArea(

                child: _getMap(position.latitude, position.longitude));

          } else {
            return const Center(child: LinearProgressIndicator(semanticsLabel: 'Loading map'));
          }
        });
  }

  void _updateCameraPosition(CameraPosition position) {
    setState(() {
      _cameraPosition = position;
      //_defaultMarker(_cameraPosition.target.latitude, _cameraPosition.target.longitude);
    });
  }

  void _addMarkerToMap(LatLng position) async {
    //set the image i need
    BitmapDescriptor mybitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/map_icon_.png",
    );
    VisitPlaceProvider visitPlaceProvider =
    Provider.of<VisitPlaceProvider>(context, listen: false);
    //Receives the position add add the marker to the map
    await _popUpForm();
      if (placeName.isNotEmpty) {
        Marker newMarker = Marker(
            markerId: MarkerId(position.latitude.toString()),
            infoWindow: InfoWindow(
              title: placeName,
              snippet: desc,
            ),
            //icon: mybitmap,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            position: position);
        //_markerList.add(newMarker);
        visitPlaceProvider.markers.add(newMarker);
      }
  }

   moveToLocation(VisitPlace place){
    if(_mapCreated){
      LatLng target = LatLng(double.parse(place.latitude), double.parse(place.longitude));
      setState(() {

        CameraPosition camaraPosition = CameraPosition(target: target,zoom: 18);
        _mapController.animateCamera(
            CameraUpdate.newCameraPosition(camaraPosition));
        _mapType = MapType.hybrid;
      });
    }else
      _mapNotCreated;

  }

  _mapNotCreated (context){
    return showDialog(
        context: context,
        builder: (_) =>AlertDialog(
          title: Text("Sorry"),
          content: Text("The map must be loaded first"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')), // Cerramos el diálogo
            TextButton(onPressed: (){
              // Pondríamos el código que queramos
              Navigator.pop(context,'Valor de vuelta');     // Envío de vuelta a quien llamó la información que quiera. NO ES OBLIGATORIO
            },
                child: Text('Accept')),
          ],
        )
    );
  }

  List<Widget> _drawerItems(context) {
    final listTextStyle = TextStyle(
        fontSize: 15, color: Colors.black, fontWeight: FontWeight.normal);
    //Returns the items for our drawer
    List<Widget> items = [];
    items.add(ListTile(
        title: Text("Saved Locations"),
        trailing: Icon(Icons.place,color: Colors.green),
        onTap: (){
          if(_mapCreated){
            Navigator.pushNamed(context, 'placeslist',arguments: moveToLocation);
          }else
            _mapNotCreated;
        }

        //Navigator.pushNamed(context, 'placeslist')
        //onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => VisitPlaceListPage()))

        ));
    items.add(ListTile(
      title: Text("Default map"),
      trailing: Icon(Icons.map,color: Colors.cyan),
      onTap: () {
        setState(() {
          _mapType = MapType.normal;
          Navigator.pop(context);
        });
      },
    ));
    items.add(ListTile(
      title: Text("Terrain map"),
      trailing: Icon(Icons.terrain,color: Colors.cyan),
      onTap: () {
        setState(() {
          _mapType = MapType.terrain;
          Navigator.pop(context);
        });
      },
    ));
    items.add(ListTile(
      title: Text("Hybrid map"),
      trailing: Icon(Icons.map,color: Colors.cyan,),
      onTap: () {
        setState(() {
          _mapType = MapType.hybrid;
          Navigator.pop(context);
        });
      },
    ));
    return items;
  }

  Future _popUpForm() {
    //VisitPlaceProvider visitPlaceProvider =
    //Provider.of<VisitPlaceProvider>(context, listen: true);
    return showDialog(
      context: context,
      builder: (_) {
        TextEditingController nameController = TextEditingController();
        TextEditingController descController = TextEditingController();
        TextEditingController latitudeController = TextEditingController(
            text: _cameraPosition.target.latitude.toString());
        TextEditingController longitudeController = TextEditingController(
            text: _cameraPosition.target.longitude.toString());
        return Consumer(
          builder: (_, VisitPlaceProvider provider, __) {
            return AlertDialog(
              title: const Text('Add a new place of interest'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                        controller: nameController,
                        decoration: InputDecorations.nameField()),
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
                        decoration: InputDecorations.lngField()),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                      placeName = nameController.text;
                      desc = descController.text;
                      VisitPlace newName = VisitPlace(
                          name: placeName.toUpperCase(),
                          description: desc,
                          latitude: latitudeController.text,
                          longitude: longitudeController.text);
                          int result = await provider.addVisitPlace(newName);
                          _checkResult(result);
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  _checkResult(int result) {
    result > 0
        ? ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('New Location saved')))
        : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text('The location was not saved, introduce a valid name')));
    Navigator.pop(context);
  }

  void onMapCreate(GoogleMapController mapController) {
    setState(() {
      //corregido, the equaled value vas _mapController b4
      _mapController = mapController;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  //https://stackoverflow.com/questions/56632225/google-maps-dequeuebuffer-bufferqueue-has-been-abandoned
  bool get wantKeepAlive => true;
}

/*
InkWell(
                child:Stack(
                  alignment: Alignment.center,
                    children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.list_alt),
                            Text('Places', overflow: TextOverflow.ellipsis),
                          ],
                      ),
                 Positioned(
                     top: 0,
                     right: 0,
                     child: Container(
                       padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                       decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                       alignment: Alignment.center,
                       child: Text('${provider.placesList.length}'),
                     ),
                 )
                  ]
              ),
              onTap: () => Navigator.pushNamed(context, 'placeslist',arguments: moveToLocation)
            ),
 */

class GetPlacesCount extends StatelessWidget{
  Function moveToLocation;
  GetPlacesCount({Key? key,required this.moveToLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VisitPlaceProvider provider =
    Provider.of<VisitPlaceProvider>(context, listen: true);
    // TODO: implement build
    return InkWell(
        child:Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.list_alt),
                  Text('Places', overflow: TextOverflow.ellipsis),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  alignment: Alignment.center,
                  child: Text('${provider.placesList.length}'),
                ),
              )
            ]
        ),
        onTap: () {

          Navigator.pushNamed(context, 'placeslist',arguments: moveToLocation);
        }
    );
  }

}
