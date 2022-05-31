import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'db_provider.dart';

class MarkerProvider with ChangeNotifier{

  Set<Marker> _markers = {};

  Future<Set<Marker>> getMarkers() async{
    _markers = await DbProvider.instance.getMarkers();
    notifyListeners();
    return _markers;
  }
}