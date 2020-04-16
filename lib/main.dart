import 'package:flutter/material.dart';
import 'package:tapdat_v0/services/auth.dart';
import 'package:tapdat_v0/ui/rootpage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tap Dat',
        theme: new ThemeData(
          primarySwatch: Colors.red,
        ),
        home: new RootPage(auth: new Auth()));
  }
}
