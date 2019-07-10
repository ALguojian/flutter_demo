import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo/pager/listview.dart';
import 'package:flutter_demo/pager/gridview.dart';
import 'package:flutter_demo/pager/CustomScrollView.dart';
import 'package:flutter_demo/pager/ScrollListener.dart';
import 'package:flutter_demo/pager/listviewloadmore.dart';
import 'package:flutter_demo/pager/tablayout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPaintBaselinesEnabled = false;
    return MaterialApp(
      title: '😁',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        backgroundColor: Colors.white,
      ),
      home: MyHomePage(title: '我是一个demo'),
      routes: {
        "new_page": (context) => NewRoute(),
        "widget_status": (context) => TapboxA(),
        "widget_status_b": (context) => ParentWidget(),
        "tablayout": (context) => TabLayout(),
        "listview": (context) => ListViewWidget(),
        "gridview": (context) => GridViewWidget(),
        "ScrollListenerWidget": (context) => ScrollListenerWidget(),
        "CustomScrollViewWidget": (context) => CustomScrollViewWidget(),
        "listviewloadmore": (context) => ListViewLoadMoreWidget(),
      },
    );
  }
}

//自己管理自己的状态
class TapboxA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: Text(
            _active ? 'Active' : "Inactive",
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[500]),
      ),
    );
  }
}

class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = true;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TaspboxB(active: _active, onChange: _handleTapboxChanged),
    );
  }
}

class TaspboxB extends StatelessWidget {
  TaspboxB({Key key, this.active: false, @required this.onChange})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChange;

  void _handleTap() {
    onChange(!active);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: Text(
            active ? 'Active' : "Inactive",
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
            color: active ? Colors.red[200] : Colors.blue[500]),
      ),
    );
  }
}

class RandomWordsWight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: RaisedButton(
        onPressed: () {},
        child: Text(
          "我是随机字符串----${wordPair.toString()}",
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

///新页面
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    print("------$args");

    return Scaffold(
      appBar: AppBar(
        title: Text("我是新页asd面"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("哈哈哈哈哈哈😸"),
            Text("哈哈哈哈哈哈😸"),
            Text("哈哈哈哈哈哈😸"),
            Image(
              image: AssetImage("images/ic_launcher.png"),
              width: 100.0,
            ),
            Image.asset(
              "images/ic_launcher.png",
              width: 80,
            ),
            Image(
              image: NetworkImage(
                  "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
              width: 80.0,
            ),
            Image.network(
              "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
              width: 60.0,
            ),
            Icon(
              Icons.access_time,
              color: Colors.deepPurpleAccent,
            )
          ],
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    //第一次插入到widget树时会被调用
    debugPrint(widget.title);
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint("---------热加载更新了页面--------");
  }

  @override
  void deactivate() {
    //当State对象从树中被移除时，会调用此回调
    super.deactivate();
  }

  @override
  void dispose() {
    //永久移除
    super.dispose();
  }

  @override
  void reassemble() {
    //移除又插入到其他位置
    super.reassemble();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
//当State对象的依赖发生变化时会被调用；例如：在之前build() 中包含了一个InheritedWidget，
// 然后在之后的build() 中InheritedWidget发生了变化，那么此时InheritedWidget的子widget的didChangeDependencies()
// 回调都会被调用。典型的场景是当系统语言Locale或应用主题改变时，Flutter framework会通知widget调用此回调。
    debugPrint("");
  }

  void _incrementCounter() {
    debugDumpRenderTree();
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      Future.delayed(new Duration(seconds: 1), () {
        throw AssertionError("asdasdasdasdasd");
      })
          .then((it) {
            print("--------$_counter-----$it");
          }, onError: (ec) {
            print("---------asdasdasdadasdadasdasdas");
          })
          .catchError((ex) => print("--------失败了"))
          .whenComplete(() {
            print('--------结束了');
          });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.storage, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: new MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text('Business')),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text('School')),
        ],
        currentIndex: _selectIndex,
        fixedColor: Colors.deepPurpleAccent,
        onTap: _onItemTapped,
      ),
      body: Scrollbar(
          child: SingleChildScrollView(
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'You have asdasdasd the button this many times:',
                  )),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
              RaisedButton(
                child: Text("widget自身管理状态"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "widget_status");
                },
              ),
              RaisedButton(
                child: Text("父widget来管理子widget的状态"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "widget_status_b");
                },
              ),
              RaisedButton(
                child: Text("tablayout展示"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "tablayout");
                },
              ),
              RaisedButton(
                child: Text("使用路由地址打开新的页面"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "new_page", arguments: "我是一个参数");
                },
              ),
              RandomWordsWight(),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text("listview展示"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "listview", arguments: "我是一个参数");
                },
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text("listview分页加载更多"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "listviewloadmore", arguments: "我是一个参数");
                },
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text("gridview展示"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "gridview", arguments: "我是一个参数");
                },
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text("CustomScrollViewWidget展示"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "CustomScrollViewWidget", arguments: "我是一个参数");
                },
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text("ScrollListenerWidget滑动监听"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "ScrollListenerWidget", arguments: "我是一个参数");
                },
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text("😸"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "listviewloadmore", arguments: "我是一个参数");
                },
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text("😸"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "listviewloadmore", arguments: "我是一个参数");
                },
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text("😸"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "listviewloadmore", arguments: "我是一个参数");
                },
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text("😸"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "listviewloadmore", arguments: "我是一个参数");
                },
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text("😸"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "listviewloadmore", arguments: "我是一个参数");
                },
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text("😸"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "listviewloadmore", arguments: "我是一个参数");
                },
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text("😸"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "listviewloadmore", arguments: "我是一个参数");
                },
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text("😸"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "listviewloadmore", arguments: "我是一个参数");
                },
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text("😸"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "listviewloadmore", arguments: "我是一个参数");
                },
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text("😸"),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, "listviewloadmore", arguments: "我是一个参数");
                },
              ),
            ],
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '点我',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      child: Drawer(
          child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            child: ClipOval(
                              child: Image.asset(
                                "images/ic_launcher.png",
                                width: 60,
                              ),
                            ),
                          ),
                          Text(
                            "我是一个侧滑菜单",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.add),
                          title: const Text("Add account"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text("Manage account"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.alarm_off),
                          title: const Text("Add account"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.ac_unit),
                          title: const Text("Add account"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.account_balance_wallet),
                          title: const Text("Add account"),
                        ),
                      ],
                    ))
                  ],
                ),
              ))),
    );
  }
}
