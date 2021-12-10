import 'package:flutter/material.dart';
import 'package:cueme/pages/home.dart';
import 'package:cueme/pages/loading_screen.dart';


void main()=>runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/home': (context)=>Home(),
    '/': (context)=>Loading(),
  },
));

