import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  // const MyApp({Key? key}) : super(key: key); //?default constructor - we can call from anywhere (general cons..)
  
  //! Each one have deferent instance 
  // MyApp app1 = const MyApp();
  // MyApp app2 = const MyApp();
  // MyApp app3 = const MyApp();
  // ! default constructor doesn't work for the idea of single instance app class or core
  // the value will not be the same coz we can use multi instance of the class

  //? named constructor => create instance with specific name
  // the value of the class will be the same value anywhere in the app coz we use one instance
  // !......
  MyApp._internal(); //? private named constructor 

  static final MyApp _instance = MyApp._internal();       // !... singleton or single instance 
  
  // to use the constructor outside the class //!factory
  factory MyApp() => _instance;



  //**
  // ? Overloading constructor (ex: in Java) -> to use more than one constructor with different *parameters*
  // ! dart do not support overloading -> the alternative is the *named constructor*
  // */

  // only for test ex:
  int appState = 0;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


// ! ex: ON SINGLETON || SINGLE INSTANCE FROM CLASS
class Test1 extends StatelessWidget {
  const Test1({Key? key}) : super(key: key);

  void updateAppState() {
    MyApp().appState = 11;
  }

  void getAppState() {
    print(MyApp().appState); // 11
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Test2 extends StatelessWidget {
  const Test2({Key? key}) : super(key: key);


  // note
  //**
  // if we update the value of appState to 33 it will be changed everywhere we use it
  // ? void updateAppState() {
  // ?   MyApp().appState = 33;
  // ? }
  // */

  //**
  //#
  // ! This method will print the same value 
  // ? coz it's the same instance from the class MyApp
  // it doesn't create another instance from the class as we do when we use the constructor
  //#
  // */
  void getAppState() {
    print(MyApp().appState); // 11
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}