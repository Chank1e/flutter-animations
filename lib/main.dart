import 'package:flutter/material.dart';
import 'package:just_animations/pages/facetime.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just Animations',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: Scaffold(
          drawer: Drawer(
            elevation: 0,
            child: Container(
              color: Colors.black12,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.face),
                    title: Text(
                      'facetime',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => FaceTimePage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.border_inner),
                    title: Text(
                      'calculator button',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => FaceTimePage()));
                    },
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(child: FaceTimePage())),
      debugShowCheckedModeBanner: false,
    );
  }
}
