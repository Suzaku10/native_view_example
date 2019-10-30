import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_plugin_lagi/flutter_plugin_lagi.dart';
import 'package:flutter_plugin_lagi/controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController text1 = TextEditingController(text: "hello");

  String _albumId;
  ImageListController ctrl ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: text1,
              ),
              FlatButton(
                child: Text("Button"),
                onPressed: () {
                  setState(() {
                    _albumId = text1.text;
                    ctrl.setText(text1.text);
                  });
                },
              ),
              Expanded(
                child: ImageList(
                  albumId: _albumId,
                  onListCreated: fs
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fs(ImageListController test){
//    print("hello");
  ctrl = test;
  }
}
