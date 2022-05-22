import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: _drawerContent(context),
    );
  }


  List<Widget> _drawerList(context){
      //Returns the items for our drawer
      List<Widget> lista = [];
      lista.add(ListTile(
          title: Text("Saved Locations"),
          trailing: Icon(Icons.place),
          onTap: ()=> Navigator.pushNamed(context, 'placeslist')

      ));
      lista.add(ListTile(
        title: Text("Change to Terrain map"),
        trailing: Icon(Icons.web),
        onTap: ()=>_unImplementedFu(context),
      ));
      lista.add(ListTile(
        title: Text("Change to Hybrid map"),
        trailing: Icon(Icons.map),

      ));
      lista.add(ListTile(
        title: Text("Change to Satelite map"),
        trailing: Icon(Icons.satellite),
        onTap: ()=>_unImplementedFu(context),
      ));
      lista.add(ListTile(
        title: Text("Night mode"),
        trailing: Icon(Icons.nightlight_round,color: Colors.black12,),
        onTap: ()=>_unImplementedFu(context),
      ));
      return lista;
    }

  Widget _drawerContent(context){
    return Container(
      color: Colors.redAccent[200],
      child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40),
              child: Row(
                children:[
                  //foto
                  Container(
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/google_maps.png"),
                      maxRadius: 50,
                    ),
                  ),
                  //puntos
                  SizedBox(width: 20,),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.indigo[100],
                child: ListView(
                    children:
                    _drawerList(context)
                ),
              ),
            ),
          ]),
    );
  }

  _unImplementedFu (context){
    return showDialog(
        context: context,
        builder: (_) =>AlertDialog(
          title: Text("Lo sentimos"),
          content: Text("La función elegida aun no se encuentra implementada"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancelar')), // Cerramos el diálogo
            TextButton(onPressed: (){
              // Pondríamos el código que queramos
              Navigator.pop(context,'Valor de vuelta');     // Envío de vuelta a quien llamó la información que quiera. NO ES OBLIGATORIO
            },
                child: Text('Aceptar')),
          ],
        )
    );
  }
}