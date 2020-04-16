import 'package:flutter/material.dart';
import 'package:tapdat_v0/services/auth.dart';

class TapRatePage extends StatefulWidget {
  TapRatePage({Key key, this.auth, this.userId}) : super(key: key);

  final BaseAuth auth;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _TapRatePageState();
}

class _TapRatePageState extends State<TapRatePage> {
//  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

// , actions: <Widget>[ new FlatButton(child: new Text('Logout',style: new TextStyle(fontSize: 17.0,color: Colors.white)),onPressed: _signOut)],

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Tap Rate Page')),
        body: Center(child: Text('Tap Rate Page')));
  }
}
