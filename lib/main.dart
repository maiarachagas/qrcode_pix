import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/view/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDb7NdmnFi44QqR233FFFVUMF6uk9e2QnE",
        authDomain: "my-pix-9e10f.firebaseapp.com",
        projectId: "my-pix-9e10f",
        storageBucket: "my-pix-9e10f.appspot.com",
        messagingSenderId: "429318882426",
        appId: "1:429318882426:web:2fed97cfc5bed550f027c3",
        measurementId: "G-GHBEL1X4T2"),
  );

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
