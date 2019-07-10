import 'package:flutter/material.dart';

class ScrollListenerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ScrollListenerState();
}

//如果滑动超过1000像素，下方显示回到顶部按钮
class ScrollListenerState extends State<ScrollListenerWidget> {
  ScrollController _scrollController = ScrollController();
  bool showToTop = false;
  String _progress="0%";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      debugPrint('-------现在的位置是---${_scrollController.offset}');
      if (_scrollController.offset < 1000 && showToTop) {
        setState(() {
          showToTop = !showToTop;
        });
      } else if (_scrollController.offset > 1000 && !showToTop) {
        setState(() {
          showToTop = !showToTop;
        });
      }
    });
  }

  @override
  void dispose() {
//为了避免内存泄漏，需要调用
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("滑动监听"),
      ),
      body: Scrollbar(
          child: NotificationListener<ScrollNotification>(onNotification: (ScrollNotification notification){
            double progress=notification.metrics.pixels/notification.metrics.maxScrollExtent;
            setState(() {
              _progress="${(progress*100).toInt()}%";
            });
            debugPrint("----------BottomEdge: ${notification.metrics.extentAfter == 0}");
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('$index'),
                  );
                },
                itemCount: 100,
                itemExtent: 50,
                controller: _scrollController,
              ),
              CircleAvatar(
                radius: 30,
                child: Text(_progress),
                backgroundColor: Colors.deepPurple,
              )
            ],
          ),)),
      floatingActionButton: !showToTop
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _scrollController.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              }),
    );
  }
}
