import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourisim_app/src/models/visit_place.dart';
import 'package:tourisim_app/src/providers/visitplace_provider.dart';

class MySearchBar extends SearchDelegate{



  @override
  List<Widget>? buildActions(BuildContext context) {
    Consumer(
        builder: (_, VisitPlaceProvider provider, __) {
          List<String> suggestions = provider.suggestions;
          return
              Container();
        }
    );

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
    //List<String> suggestions = provider.suggestions;
    return Center(
        child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    VisitPlaceProvider provider = Provider.of<VisitPlaceProvider>(context,listen :true);
    //get visit place names from the db
    List<VisitPlace> placesList = provider.placesList;


    List<String> searchResults = provider.suggestions;
    List<String> suggestions = searchResults.where((searchResult){
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();
          return FutureBuilder(
              future: provider.getSuggestions(),
              builder: (_,AsyncSnapshot data){
                return ListView.separated(
                    itemBuilder: (_,pos){
                      final suggestion = suggestions[pos];
                      return ListTile(
                        leading: Icon(Icons.place,color: Colors.green,size: 35,),
                        title: Text(suggestion) ,
                        onTap: (){
                          query =  suggestion;
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