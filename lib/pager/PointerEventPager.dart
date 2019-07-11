import 'package:flutter/material.dart';

class PointerEventPager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PointerEventPagerState();
}

class PointerEventPagerState extends State<PointerEventPager> {
  PointerEvent _pointerEvent;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        width: 300,
        height: 400,
        child: Text(
          _pointerEvent?.toString() ?? "",
          style: TextStyle( color: Colors.white,),
        ),
      ),

    );
  }
}
