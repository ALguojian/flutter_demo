import 'package:flutter/material.dart';

class TabLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new TabLayoutState();
}

class TabLayoutState extends State<TabLayout>
    with SingleTickerProviderStateMixin {
  //先定义一个Controller
  TabController _tabController;
  List tabs = ["首页", "活动", "消息", "我的"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      switch (_tabController.index) {
        case 1:

        case 2:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("tablayout"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            )
          ],
          backgroundColor: Colors.lightGreen,
          bottom: TabBar(
              controller: _tabController,
              tabs: tabs
                  .map((e) => Tab(text: e, icon: Icon(Icons.account_balance)))
                  .toList()),
        ),
        body: TabBarView(
            controller: _tabController,
            children: tabs.map((e) {
              return Container(
                alignment: Alignment.center,
                child: Text(e, textScaleFactor: 7),
              );
            }).toList()),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(), //底部导航栏先打一个圆形的洞
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.home),onPressed: (){},),
              SizedBox(), //中间位置空出来
              IconButton(icon: Icon(Icons.business),onPressed: (){},),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
            FloatingActionButton(child: Icon(Icons.add), onPressed: () {}));
  }
}
