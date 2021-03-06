import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourisim_app/src/models/visit_place.dart';
import 'package:tourisim_app/src/providers/visitplace_provider.dart';
import 'package:tourisim_app/src/widgets/widgets.dart';

class VisitPlaceList extends StatelessWidget{
  List<VisitPlace>placesList;
  //Function _moveToLocation;
  VisitPlaceList({Key? key, required this.placesList}) : super(key: key);

  final titleStyle = TextStyle(color: Colors.black,fontSize: 20);

  final descTile = TextStyle(color: Colors.black,fontSize: 15);

  final txtFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Function moveToLocation = ModalRoute.of(context)!.settings.arguments as Function;

    VisitPlaceProvider provider = Provider.of<VisitPlaceProvider>(context, listen: false);
    return Column(
      children: [
        Expanded(child: _listElements(provider, moveToLocation))
      ],
    );
  }


  Widget _listElements(VisitPlaceProvider provider,moveToLocation){
    return ListView.separated(
      itemCount: placesList.length,
      itemBuilder: (context,pos){
        VisitPlace place = placesList[pos];
        return
          InkWell(
              onLongPress: (){
                //go to the place on the map
              },
              child: ListTile(
                leading: Icon(Icons.place,color: Colors.green,size: 35,),
                title: Text(place.name,style: titleStyle,) ,
                subtitle: place.description.isNotEmpty ? Text(place.description,style: descTile,) : Text("No description"),
                onTap: (){
                  //move the user to the location
                  Navigator.pop(context);
                  moveToLocation(place);
                },
                trailing: GestureDetector(
                  child: const Icon(
                    Icons.delete_forever,
                    size: 35,
                    color: Colors.redAccent,
                  ),
                  onTap: (){
                    provider.deleteVisitPlace(place);
                  },
                ),
              )
          );
      },
      separatorBuilder: (_, int pos)  => Divider(height: 20),
    );
  }
}