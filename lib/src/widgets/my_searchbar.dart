import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourisim_app/src/models/visit_place.dart';
import 'package:tourisim_app/src/providers/visitplace_provider.dart';

class MySearchBar extends SearchDelegate{

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
    IconButton(
        onPressed: (){
          query = '';
        },
        icon: Icon(Icons.clear)
    )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null); //close the search bar
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    VisitPlaceProvider provider = Provider.of<VisitPlaceProvider>(context,listen :false);
    //get visit place names from the db
    List<VisitPlace> suggestions = provider.placesList;

    final suggestionList = query.isEmpty
        ? []
        : suggestions.where((p) => p.name.contains(query)).toList();
    VisitPlace place = suggestionList[0];
    print(suggestionList.length);
    print(place.toString());
    return SingleChildScrollView(child: DetailHead(place: place));


  }

  @override
  Widget buildSuggestions(BuildContext context) {
    VisitPlaceProvider provider = Provider.of<VisitPlaceProvider>(context,listen :true);
    //get visit place names from the db
    List<VisitPlace> placesList = provider.placesList;

    List<VisitPlace> suggestions = placesList.where((visitPlace){

      final visitPlaceName = visitPlace.name.toLowerCase();
      final userInput  = query.toLowerCase();

      return visitPlaceName.contains(userInput);
    }).toList();
          return FutureBuilder(
              future: provider.getVisitPlaces(),
              builder: (_,AsyncSnapshot data){
                return ListView.separated(
                    itemBuilder: (_,pos){
                      final suggestion = suggestions[pos];
                      return ListTile(
                        leading: Icon(Icons.place,color: Colors.green,size: 35,),
                        title: Text(suggestion.name) ,
                        onTap: (){
                          query =  suggestion.name;
                          showResults(context);
                        },
                      );
                    },
                    separatorBuilder:  (_, int pos)  => Divider(height: 20),
                    itemCount: suggestions.length
                );
              }
          );
        }

}

class DetailHead extends StatelessWidget{
  VisitPlace place;
  DetailHead({required this.place});
   //final controller = TextEditingController(text: place.description);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        children: [
          _details(context)
        ],
      ),
    );
  }


  Widget _details(context){

    return Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            height: 200,
            width : 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.asset('assets/images/damian.jpg',fit: BoxFit.cover,)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: TextFormField(
              //controller: controller,
              initialValue: place.description.isEmpty ? 'No Description' : place.description,
              maxLines: null,
              enabled: false,
              decoration: InputDecoration(
                label: Text('Description' ,style: TextStyle(color: Colors.cyan,fontSize: 22),)
              ),
              style: TextStyle(fontSize: 17),
            )
          ),
          Container(
            margin:EdgeInsets.only(top: 20,bottom: 10),
            child: ListTile(
              title: Text("Name: ",style: TextStyle(fontSize: 17,color: Colors.white),),
              tileColor: Colors.black87,
              leading: Icon(Icons.place_outlined,color: Colors.white,),
              trailing: Text(place.name.toUpperCase(),style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold)),
            ),
          ),

          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
                title: Text("Latitude :",style: TextStyle(fontSize: 17,color: Colors.white),),
                tileColor: Colors.black87,
                leading: Icon(Icons.map,color: Colors.white,),
                trailing: Text(place.latitude,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
                title: Text("Longitude :",style: TextStyle(fontSize: 17,color: Colors.white),),
                tileColor: Colors.black87,
                leading: Icon(Icons.map,color: Colors.white,),
                trailing: Text(place.longitude,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),
            ),
          ),

          TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Close",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              fixedSize: Size(100,40),
            ),
          )
          /*
        Container(
          margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Text(mascota.desc, style: TextStyle(fontSize: 18,overflow: TextOverflow.visible ),)
          ),
        */
        ]
    );
  }


}