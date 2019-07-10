import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class ListViewLoadMoreWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ListViewLoadMoreState();
}

class ListViewLoadMoreState extends State<ListViewLoadMoreWidget> {
  static const loadingTag = "##loading##"; //结尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(_words.length - 1,
          generateWordPairs().take(22).map((e) => e.asPascalCase).toList());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Card(
                child: ListTile(
              title: Text("我只是一个头部"),
            )),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  //如果到了结尾
                  if (_words[index] == loadingTag) {
                    //不足100条，继续获取数据
                    if (_words.length < 101) {
                      _retrieveData();
                      return Container(
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 26,
                          height: 26,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "我也是有底线的",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                  }
                  return Card(
                    child: ListTile(
                      title: Text(_words[index]),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                      height: 0,
                    ),
                itemCount: _words.length),
          )
        ],
      ),
    );
  }
}
