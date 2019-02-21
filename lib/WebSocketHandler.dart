import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:rxdart/rxdart.dart';

class WebSocketHandler {
  WebSocket socket;
  Sink sink;

  WebSocketHandler(this.sink);

  Future<void> openConnection(Duration r) async {
    var reconnectTime = Duration(seconds: 1);
    try {
      //  print("TENTANDO da primeira VEZ");
      WebSocket connection =
          await WebSocket.connect(
            "ws://echo.websocket.org"
            //"ws://ea333e8b.ngrok.io/name"
            );
            

      socket = connection;

      connection.pingInterval = Duration(seconds: 10);

      connection.done.whenComplete(() {
        Timer(Duration(seconds: 1), () async {
            print(
               "DONE ------------------------------------------------------------------------------");
          await openConnection(Duration(seconds: 1));
        });
      });

      socket.add(jsonEncode({"name": "rully"}));

      socket.listen((dados) {
        // print("DADOS REceBidos do websocket");
        print("$dados s");
        sink.add(dados);
      });
    } catch (e) {
      // print("cai no catch --------------------------------- $e");
      Timer(reconnectTime, () async {
          print("erro de conexão , segunda tentativa");
        await openConnection(reconnectTime);
      });
    }
  }
}
