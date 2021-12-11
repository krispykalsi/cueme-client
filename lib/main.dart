import 'package:flutter/material.dart';
import 'package:cueme/pages/home/home_page.dart';
import 'package:cueme/pages/loading/loading_page.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomePage(),
        '/': (context) => const LoadingPage(),
      },
    ),
  );
}
