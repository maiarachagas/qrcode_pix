import 'package:flutter/material.dart';

import 'src/view/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pix',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: PixOptionScreen(),
    );
  }
}
