
import '/presentation/resources/all_resources.dart';

import 'package:flutter/material.dart';


class MyApp extends StatefulWidget {

  MyApp._internal(); //? private named constructor 
  
  static final MyApp _instance = MyApp._internal(); // !... singleton or single instance 
  
  // to use the constructor outside the class //!factory
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    onGenerateRoute: RoutesGenerator.getRoute,
    initialRoute: RoutesManager.splashRoute,
    theme: getApplicationTheme(),
  );
}