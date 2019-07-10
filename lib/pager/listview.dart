import 'package:flutter/material.dart';

class ListViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(
      height: 6,
      indent: 22,
      color: Colors.blue,
    );
    Widget divider2 = Divider(color: Colors.green,height: 6,);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white

      ),
      child: ListView.separated(
        itemCount: 50,
//        itemExtent: 50,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text("我是第$index条",style: TextStyle(backgroundColor: Colors.white,color: Colors.black),),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? divider1 : divider2;
        },
      ),
    );
  }
}
