import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'logInScreen.dart';
import 'nearbyTrails.dart';
import 'distanceTraveled.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        'home': (context) => home(),
        '/distanceTraveled': (context) => distanceTraveled(),
        '/nearbyTrails': (context) => nearbyTrails(),
        '/loginScreen': (context) => LogInScreen(),
      },
      title: 'Pedal Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LogInScreen(),
    );
  }
}
