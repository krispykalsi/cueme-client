import 'package:flutter/material.dart';
import 'package:cueme/pages/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env.secret");
  runApp(
    const MaterialApp(
      home: HomePage(),
    ),
  );
}
