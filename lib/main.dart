import 'package:flutter/material.dart';
import 'package:praktek/screens/list.dart';

import 'screens/add.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/" : (context) => const ListSceen(),
        "/add":(context) => const AddScreen(),
      },
    );
  }
}