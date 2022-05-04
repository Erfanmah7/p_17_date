
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:p_17_date/models/event.dart';
import 'package:p_17_date/models/todo.dart';
import 'package:p_17_date/register/singin.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(todoAdapter());
  Hive.registerAdapter(EventAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SingIn(),
     // theme: ThemeData.dark(),
    );
  }



}