import 'package:flutter/material.dart';
import 'package:tapdat_v0/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tapdat_v0/ui/inbox.dart';
import 'package:tapdat_v0/ui/location.dart';
import 'package:tapdat_v0/ui/archive.dart';
import 'package:tapdat_v0/ui/settings.dart';
import 'package:tapdat_v0/ui/taprate.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;


  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  NfcData _nfcData;

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  FirebaseUser currentUser;



  @override
  void initState() {
    super.initState();
    loadCurrentUser();
  }

  void loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        // call setState to rebuild the view
        this.currentUser = user;
      });
    });
  }

  String email() {
    if (currentUser != null) {
      return currentUser.email;
    } else {
      return "no current user";
    }
  }

  String name() {
    if (currentUser != null) {
      return currentUser.displayName;
    } else {
      return "no name on file";
    }
  }

  Future<void> startNFC() async {
    NfcData response;

    setState(() {
      _nfcData = NfcData();
      _nfcData.status = NFCStatus.reading;
    });

    print('NFC: Scan started');

    try {
      print('NFC: Scan readed NFC tag');
      response = await FlutterNfcReader.read();
    } on PlatformException {
      print('NFC: Scan stopped exception');
    }
    setState(() {
      _nfcData = response;
    });
  }

  Future<void> stopNFC() async {
    NfcData response;

    try {
      print('NFC: Stop scan by user');
      response = await FlutterNfcReader.stop();
    } on PlatformException {
      print('NFC: Stop scan exception');
      response = NfcData(
        id: '',
        content: '',
        error: 'NFC scan stop exception',
        statusMapper: '',
      );
      response.status = NFCStatus.error;
    }

    setState(() {
      _nfcData = response;
    });
  }

//  void route() {
//    runApp(MaterialApp(
//      title: 'Named Routes Demo',
//      // Start the app with the "/" named route. In our case, the app will start
//      // on the FirstScreen Widget
//      initialRoute: '/',
//      routes: {
//        // When we navigate to the "/" route, build the FirstScreen Widget
//        '/': (context) => HomePage(),
//        // When we navigate to the "/second" route, build the SecondScreen Widget
//        '/messaging': (context) => SecondScreen(),
//      },
//    ));
//  }
// , actions: <Widget>[ new FlatButton(child: new Text('Logout',style: new TextStyle(fontSize: 17.0,color: Colors.white)),onPressed: _signOut)],

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tap Dat')),
      drawer: Drawer(
        // column holds all the widgets in the drawer
        child: Column(
          children: <Widget>[
            Expanded(
              // ListView contains a group of widgets that scroll inside the drawer
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      //name(),
                      'FirstName',
                    ),
                    accountEmail: Text(
                      email(),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).platform == TargetPlatform.iOS
                              ? Colors.blue
                              : Colors.white,
                      child: Text(
                        email()[0].toUpperCase(), //Letter for name
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),

                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 200),
                              child: HomePage()));
                      //                   .push(context, PageTransition(type: PageTransitionType.leftToRight, child: HomePage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.question_answer),
                    title: Text('Slide into those DM\'s'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 200),
                              child: InboxPage()));
                      // .push(MaterialPageRoute(builder: (BuildContext context) => InboxPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.attach_money),
                    title: Text('Set Tap Rate'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 200),
                              child: TapRatePage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.archive),
                    title: Text('Archived Stuff'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 200),
                              child: ArchivePage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.my_location),
                    title: Text('Find me'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 200),
                              child: LocationPage()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 200),
                              child: SettingsPage()));
                    },
                  ),
                ],
              ),
            ),
            // This container holds the align

            Container(
                // This align moves the children to the bottom
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    // This container holds all the children that will be aligned
                    // on the bottom and should not scroll with the above ListView
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.exit_to_app),
                          title: Text('Logout'),
                          onTap: () {
                            signOut();
                            // Update the state of the app
                            // ...
                            // Then close the drawer
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.help),
                          title: Text('Help and Feedback'),
                          onTap: () {
                            // Update the state of the app
                            // ...
                            // Then close the drawer
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.downToUp,
                                    duration: Duration(milliseconds: 200),
                                    child: SettingsPage()));


                          },
                        ),
                      ],
                    ))))
          ],
        ),
      ),
      body: Center(

          child: ListView(
            children: <Widget>[
              new SizedBox(
                height: 10.0,
              ),
              new Text(
                '- NFC Status -\n',
                textAlign: TextAlign.center,
              ),
              new Text(
                _nfcData != null ? 'Status: ${_nfcData.status}' : '',
                textAlign: TextAlign.center,
              ),
              new Text(
                _nfcData != null ? 'Identifier: ${_nfcData.id}' : '',
                textAlign: TextAlign.center,
              ),
              new Text(
                _nfcData != null ? 'Content: ${_nfcData.content}' : '',
                textAlign: TextAlign.center,
              ),
              new Text(
                _nfcData != null ? 'Error: ${_nfcData.error}' : '',
                textAlign: TextAlign.center,
              ),
              new RaisedButton(
                child: Text('Start NFC'),
                onPressed: () {
                  startNFC();
                },
              ),
              new RaisedButton(
                child: Text('Stop NFC'),
                onPressed: () {
                  stopNFC();
                },
              ),
            ],
          ),
//          child: ButtonTheme(
//        minWidth: 400.0,
//        height: 100.0,
//            child: new RawMaterialButton(
//              onPressed: () {
//                startNFC();
//              },
//              child: new Icon(
//                Icons.attach_money,
//                color: Colors.red,
//                size: 40.0,
//              ),
//              shape: new CircleBorder(),
//              elevation: 2.0,
//              fillColor: Colors.red[200],
//              padding: const EdgeInsets.all(70.0),
//            ),
      ),
    );
  }
}
