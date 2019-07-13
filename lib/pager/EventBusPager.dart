import 'package:flutter/material.dart';

class EventBusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: new Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: RaisedButton(
          onPressed: () {
            bus.emit("click");
          },
          child: Text("点击发送一个事件到首页"),
        ),
      ),
    );
  }
}

typedef void EventCallBack(org);

class EventBusPager {
  //私有构造函数
  EventBusPager._internal();

  //保存单例
  static EventBusPager _singleton = EventBusPager._internal();

  //工厂构造函数
  factory EventBusPager() => _singleton;

  //保存事件订阅者队列，key：事件名（id），value：对应事件的订阅者队列
  var _emap = Map<Object, List<EventCallBack>>();

  //添加订阅者
  void on(eventName, EventCallBack f) {
    if (eventName == null || f == null) return;
    _emap[eventName] ??= List<EventCallBack>();
    _emap[eventName].add(f);
  }

  //移除订阅者
  void off(eventName, [EventCallBack f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  //添加一个事件，事件出发后所有的订阅者都会受到事件回调
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;
    var len = list.length - 1;

    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}

//定义一个top-level变量，页面引入该文件后就可以直接使用bus
var bus = EventBusPager();
