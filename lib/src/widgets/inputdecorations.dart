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

  static InputDecoration searchPlaces(){
    BorderSide borderSide = BorderSide(color: Colors.cyan);
    BorderRadius borderRadius = BorderRadius.circular(20);
    return  InputDecoration(
      hintText: 'Name of the place',
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide,

      ),
      prefixIcon: Icon(Icons.search)

    );
  }
}