import 'package:flutter/material.dart';
import 'package:tapdat_v0/services/auth.dart';

class InboxPage extends StatefulWidget {
  InboxPage({Key key, this.auth, this.userId}) : super(key: key);

  final BaseAuth auth;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
//  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

// , actions: <Widget>[ new FlatButton(child: new Text('Logout',style: new TextStyle(fontSize: 17.0,color: Colors.white)),onPressed: _signOut)],

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Inbox')),
        body: Center(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
                // This align moves the children to the bottom
                child: Align(
                    // This container holds all the children that will be aligned
                    // on the bottom and should not scroll with the above ListView
                    child: Container(
                        child: Column(
              children: <Widget>[
// Eventually add a for each loop for each message in the persons inbox present listtile
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Person 1'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Person 2'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Person 3'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Person 4'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Person 5'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ))))
          ],
        )));
  }
}
