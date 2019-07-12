import 'package:flutter/material.dart';

//自定义UI分为三种情况
//1. 通过其他widget的组合方式
class CustomerUIRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomerUIRouteState();
}

class CustomerUIRouteState extends State<CustomerUIRoute> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

//通过组合实现一个背景渐变的button
class GradientButton extends StatelessWidget{

  //1，第一步，先定义一些自定义属性
  final double height;//按钮高度
  final double width;//按钮宽度
  final Widget child;//这里想要显示一个text，所以直接把text传过来，


  @override
  Widget build(BuildContext context) {
    return null;
  }

  GradientButton();

}
