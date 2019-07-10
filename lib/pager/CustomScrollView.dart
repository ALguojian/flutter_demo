import 'package:flutter/material.dart';

//可以嵌套多个滑动布局的widget
class CustomScrollViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CustomScrollViewState();
}

class CustomScrollViewState extends State<CustomScrollViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("我是一个嵌套的widget"),
              background: Image.network(
                "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
                delegate: new SliverChildBuilderDelegate((builder, index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text('grid item $index'),
                  );
                }, childCount: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 2.5)),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('list item $index'));
            }, childCount: 50),
          ),
        ],
      ),
    );
  }
}
