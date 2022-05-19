import 'package:flutter/material.dart';

class InputDecorations{

  static InputDecoration nameField(){
      return const InputDecoration(
          labelText: "Name",
          icon: Icon(Icons.place),
          enabled: true
      );
    }

  static InputDecoration descField(){
    return const InputDecoration(
        labelText: "Description",
        icon: Icon(Icons.description),
        enabled: true
    );
  }

  static InputDecoration latField(){
    return const InputDecoration(
        labelText: "Latitude",
        icon: Icon(Icons.gps_fixed),
        enabled: false
    );
  }

  static InputDecoration lngField(){
    return const InputDecoration(
        labelText: "Longitude",
        icon: const Icon(Icons.gps_fixed),
        enabled: false
    );
  }

}