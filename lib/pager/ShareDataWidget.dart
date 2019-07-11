import 'package:flutter/material.dart';

class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InheritedWidgetTestRouteState();
}

class InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ShareDataWidget(
          data: count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _TestWidget(),
              ),
              RaisedButton(
                child: Text("Increment"),
                onPressed: () => setState(() => ++count),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//传递数据共享数据
class ShareDataWidget extends InheritedWidget {
  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }

  ShareDataWidget({@required this.data, Widget child}) : super(child: child);

  final int data;

  static ShareDataWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ShareDataWidget);
  }
}

//实现一个子widget再build方法中引用ShareDataWidget中的数据，同时，在其didChangeDependencies回调中打印日志；
class _TestWidget extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或者祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    debugPrint("---------子widget依赖的widget变了");
  }
}
