import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourisim_app/src/pages/pages.dart';
import 'package:tourisim_app/src/providers/visitplace_provider.dart';

void main() {
  runApp(AppState());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      routes: {
        'home': (_) => HomePage(),
        'placeslist': ( _ ) => VisitPlaceListPage()
      },
      initialRoute: 'home',

    );
  }

}
class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => VisitPlaceProvider()),
      ],
      child: MyApp(),
    );
  }

}
