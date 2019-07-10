import 'package:flutter/material.dart';

class GridViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GridViewState();
}

//两种布局算法
//1.SliverGridDelegateWithFixedCrossAxisCount固定横轴的条目数量，crossAxisCount，3，，简单用法 GridView.count
//2.SliverGridDelegateWithMaxCrossAxisExtent固定子条目的最大宽度，最终还是平分屏幕宽度，maxCrossAxisExtent，120.0
// ，简单用法GridView.extent
//如果需要动态创建和listview类似使用builder方法创建

//写死的数据
class GridViewState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(color: Colors.white),
        child:
//      GridView(
//        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//            crossAxisCount: 3, childAspectRatio: 1.0),
//        children: <Widget>[
//          Icon(Icons.ac_unit),
//          Icon(Icons.airport_shuttle),
//          Icon(Icons.all_inclusive),
//          Icon(Icons.beach_access),
//          Icon(Icons.cake),
//          Icon(Icons.free_breakfast)
//        ],
////      ),
//            GridView.count(
//          crossAxisCount: 3,
//          childAspectRatio: 1.0,
//          children: <Widget>[
//            Icon(Icons.ac_unit),
//            Icon(Icons.airport_shuttle),
//            Icon(Icons.all_inclusive),
//            Icon(Icons.beach_access),
//            Icon(Icons.cake),
//            Icon(Icons.free_breakfast)
//          ],
//        )
            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1.0),
                itemCount: 14,
                itemBuilder: (context, index) {}));
  }
}
