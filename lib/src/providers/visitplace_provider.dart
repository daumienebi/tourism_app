import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourisim_app/src/models/visit_place.dart';
import 'package:tourisim_app/src/providers/db_provider.dart';

class VisitPlaceProvider with ChangeNotifier{

  List<VisitPlace> placesList = [];
  List<String> suggestions = [];
  Set<Marker> _markers = {};

  Future<VisitPlace> getVisitPlace(int id)async{
    VisitPlace place = await DbProvider.instance.getVisitPlace(id);
    return place;
  }

  Set<Marker> get markers{
    if(_markers.isNotEmpty) return _markers;
    getMarkers();
    //notifyListeners();
    return _markers;
  }

  Future<Set<Marker>> getMarkers() async{
    _markers = await DbProvider.instance.getMarkers();
    notifyListeners();
    return _markers;
  }

  Future<List<String>> getSuggestions() async{
    suggestions =  await DbProvider.instance.getSuggestions();
    notifyListeners();
    return suggestions;
  }

  Future<List<VisitPlace>> getVisitPlaces() async{
    //DbProvider.instance.aa();
    placesList = await DbProvider.instance.getAllVisitPlaces();
    notifyListeners();
    return placesList;

  }

  Future <int> deleteVisitPlace(VisitPlace visitPlace) async{
    int deletedId = await DbProvider.instance.deleteVisitPlace(visitPlace);
    //print('DELETED PLACE : ${visitPlace.toString()}');
    notifyListeners();
    return deletedId;
  }

  Future<int> addVisitPlace(VisitPlace visitPlace) async{
    if(visitPlace.name.isNotEmpty){
      int id = await DbProvider.instance.addVisitPlace(visitPlace);
      notifyListeners();
      return id;
    }

    return -1;
  }
}