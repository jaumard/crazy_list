import 'dart:core';

import 'package:crazy_list/crazy_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var itemCount = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: CrazyList(
              itemCount: itemCount,
              mode: CrazyListMode.list,
              color1: Colors.green[50],
              color2: Colors.green[300],
              onTap: (index) => print('$index tapped'),
              builder: (context, index, mode) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('My Label $index'),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Text('-1'),
                onPressed: () {
                  setState(() {
                    if (itemCount > 1) {
                      itemCount--;
                    }
                  });
                },
              ),
              FlatButton(
                child: Text('+1'),
                onPressed: () {
                  setState(() {
                    itemCount++;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
