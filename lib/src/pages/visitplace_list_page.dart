import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourisim_app/src/models/visit_place.dart';
import 'package:tourisim_app/src/providers/visitplace_provider.dart';
import 'package:tourisim_app/src/widgets/visitplace_list.dart';

class VisitPlaceListPage extends StatelessWidget{
  const VisitPlaceListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    VisitPlaceProvider provider = Provider.of<VisitPlaceProvider>(context,listen :true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Your places of interest"),
        actions: [
          TextButton(
              onPressed: (){},
              child:
                    Text("${provider.placesList.length}",style: TextStyle(color: Colors.black),),
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey,
              fixedSize: Size(15,15),
            ),
          )
        ],
      ),

      body: SafeArea(
        child:
          FutureBuilder(
          future: provider.getVisitPlaces(),
        builder: (_,AsyncSnapshot <List<VisitPlace>> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            );

          }

          final List<VisitPlace> placesList = snapshot.data!;
          return VisitPlaceList(placesList: placesList);
        }
        ),
      ),
    );
  }

}