import 'package:flutter/material.dart';
import 'package:tourisim_app/src/widgets/my_drawer.dart';
import 'package:tourisim_app/src/widgets/widgets.dart';

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.visibility_sharp),
            onPressed: (
                //Address finder
                ){}
        ),
      drawer: MyDrawer(),
      appBar: AppBar(
        actions: [
          Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.search,size: 25,)
          )
        ],
        title: Text("Tourisim App"),
      ),
      body: MapWidget()
    );
  }

}