import 'package:flutter/material.dart';

class HeroRouter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeroRouterState();
}

class HeroRouterState extends State<HeroRouter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: Card(
        child: InkWell(
          child: Hero(
              tag: "avatar",
              child: ClipOval(
                child: Image.asset(
                  "images/ic_launcher.png",
                  width: 60,
                ),
              )),
          onTap: () {
            Navigator.push(context,
                PageRouteBuilder(pageBuilder: (context, animation, animation2) {
                  return FadeTransition(
                    opacity: animation,
                    child: Scaffold(
                      appBar: AppBar(
                        title: Text("共享元素浏览大图"),
                      ),
                      body: HeroRouterB(),
                    ),
                  );
                }));
          },
        ),
      ),
    );
  }
}

class HeroRouterB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(tag: "avatar", child: Image.asset("images/ic_launcher.png")),
    );
  }
}
