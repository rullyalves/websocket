import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
  BehaviorSubject b;

/*
  Future<void> connect() async {
    IO.Socket socket = IO.io('http://704c5e39.ngrok.io');
    socket.on('connect', (_) {
      print('connect happened');
    });

    socket.on('olha', (data) {
      b.add(jsonDecode(data));
    });
    socket.on('disconnect', (_) {
      print('disconnect');
    });
    socket.on('fromServer', (_) => print(_));
  }
*/

  Future<void> c() async {
  
    WebSocket webSocket;
    try {
      Uri uri = Uri.parse('ws://echo.websocket.org');
      WebSocket webSocket = await WebSocket.connect("ws://echo.websocket.org");
      webSocket.listen(print);
      webSocket.add("hello");

      webSocket.done.then((_) {
        print("fechei");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    b = BehaviorSubject();
    c();
    // handler = new WebSocketHandler(b.sink);
    //  handler.openConnection(Duration(seconds: 10));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

/*
  Future<WebSocket> web() async {
    WebSocket socket;
    try {
      await WebSocket.connect('ws://c4cfdf9e.ngrok.io/websocket');
      return socket;
    } on WebSocketException catch (e) {
      print("exception $e");
      socket = await WebSocket.connect('ws://c10afa49.ngrok.io/websocket');
      return socket;
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: b.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Text(snapshot.data["status"])
              : CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
