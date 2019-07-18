import 'package:flutter/material.dart';

///我们的数据就是一个 int 类型的 _count，下划线代表私有。
///通过 get value 把 _count 值暴露出来。并提供 increment 方法用于更改数据
class CounterModel with ChangeNotifier {
  int _count = 0;
  int get value => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}
