import 'package:flutter/material.dart';

class MyNotification extends Notification {
  final String msg;

  MyNotification(this.msg);
}

class NotificationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationRouteState();
}

class NotificationRouteState extends State<NotificationRoute> {
  var _mag = "";

  @override
  Widget build(BuildContext context) {
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        setState(() {
          _mag += notification.msg + "-";
        });
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(builder: (context) {
              return RaisedButton(
                onPressed: () {
                  MyNotification("你好").dispatch(context);
                },
                child: Text("发送一个通知"),
              );
            }),
            Text(_mag),
          ],
        ),
      ),
    );
  }
}
