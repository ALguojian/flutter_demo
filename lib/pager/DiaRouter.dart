import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DiaRouter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DiaRouterState();
}

class DiaRouterState extends State<DiaRouter> {
  var content = "";
  final Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dio_package"),
      ),
      body: Container(
        child: Text(content),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _requestHttp,
        child: Icon(Icons.add),
        tooltip: "点击",
      ),
    );
  }

  void _requestHttp() async {
    //get请求
    Response response;
    response = await dio.get("/test?id=12&name=wendu");
    debugPrint(response.data.toString());

    //get请求将query参数作为对象传递
    response = await dio.get("/test", queryParameters: {"id": 12, "name": "alguojian"});

    //post请求
    response = await dio.post("/test", data: {"id": 12, "name": "alguojian"});

    //发起多个并发请求
    List<Response> list = await Future.wait([dio.post("/info"), dio.get(".token")]);

    //下载文件
    response=await dio.download("https://aaaa.com/", null);


  }
}
