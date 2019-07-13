import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

//自定义UI分为三种情况
//1. 通过其他widget的组合方式
class CustomerUIRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomerUIRouteState();
}

class CustomerUIRouteState extends State<CustomerUIRoute> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      appBar: AppBar(
        title: Text("自定义UI"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "自定义组合UI",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GradientButton(
              child: Text("hahahha"),
              height: 50,
              onTap: onTap,
              colors: [Colors.orange, Colors.red],
            ),
            GradientButton(
              child: Text("hahahha"),
              height: 50,
              onTap: onTap,
              colors: [Colors.lightGreen[300], Colors.green[900]],
            ),
            GradientButton(
              child: Text("hahahha"),
              height: 50,
              onTap: onTap,
              colors: [Colors.lightBlue[100], Colors.blueAccent],
            ),
            TurnBox(
              turns: _turns,
              speed: 500,
              child: Icon(
                Icons.refresh,
                size: 50,
              ),
            ),
            TurnBox(
              turns: _turns,
              speed: 1000,
              child: Icon(
                Icons.refresh,
                size: 150,
              ),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _turns += .2;
                });
              },
              child: Text("顺时针旋转1/5圈"),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _turns -= .5;
                });
              },
              child: Text("逆时针旋转1/2圈"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "绘制UI",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CustomPaintRouter(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "绘制UI动画控制",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GradientCircularProgressRoute()
          ],
        ),
      ),
    );
  }

  onTap() {
    Toast.show("👌", context);
  }
}

//通过组合实现一个背景渐变的button
class GradientButton extends StatelessWidget {
  //1，第一步，先定义一些自定义属性
  final double height; //按钮高度
  final double width; //按钮宽度
  final Widget child; //这里想要显示一个text，所以直接把text传过来，并且使用者可以设置text的样式
  final List<Color> colors; //渐变颜色数组

  final GestureTapCallback onTap; //点击回调

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    List<Color> _colors = colors ?? [themeData.primaryColor, themeData.primaryColorDark ?? themeData.primaryColor];

    return DecoratedBox(
      decoration: BoxDecoration(gradient: LinearGradient(colors: _colors)),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: colors.last,
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(height: height, width: width),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DefaultTextStyle(style: TextStyle(fontWeight: FontWeight.bold), child: child),
                ),
              )),
        ),
      ),
    );
  }

  //构造函数里面就是需要自定义属性，必须传的值需要使用@required标记
  GradientButton({this.colors, this.width, this.height, this.onTap, @required this.child});
}

class TurnBox extends StatefulWidget {
  final double turns;
  final int speed;
  final Widget child;

  const TurnBox(
      {Key key,
      this.turns = .0, //旋转的圈数
      this.speed = 200, //动画执行的总时长
      this.child})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => TurnBoxState();
}

class TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, lowerBound: -double.infinity, upperBound: double.infinity);
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(widget.turns, duration: Duration(milliseconds: widget.speed ?? 400), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }
}

class CustomPaintRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(330, 330),
        painter: MyPainter(),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 15;
    double eHeight = size.width / 15;

    //先画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true //设置抗锯齿
      ..style = PaintingStyle.fill //填充模式
      ..color = Color(0x77cdb175); //背景为黄色
    //代表原点，以及绘制的宽高
    canvas.drawRect(Offset.zero & size, paint);

    paint
      ..style = PaintingStyle.stroke //线模式
      ..color = Colors.black87
      ..strokeWidth = 1.1;
    for (int i = 0; i <= 15; i++) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }
    for (int i = 0; i <= 15; i++) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }


    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(Offset(size.width / 2 - eWidth / 2, size.height / 2 - eHeight / 2), eWidth / 2, paint);

    paint
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawCircle(Offset(size.width / 2 + eWidth / 2, size.height / 2 + eHeight / 2), eWidth / 2, paint);
  }

//在UI树重新build时，控件在绘制前都会先调用该方法以确定是否有必要重绘；假如我们绘制的UI不依赖外部状态，
// 那么就应该始终返回false，因为外部状态改变导致重新build时不会影响我们的UI外观；
// 如果绘制依赖外部状态，那么我们就应该在shouldRepaint中判断依赖的状态是否改变，
// 如果已改变则应返回true来重绘，反之则应返回false不需要重绘。
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

//自定义圆环
class GradientCircularProgressIndicator extends StatelessWidget {
  GradientCircularProgressIndicator({
    this.strokeWidth = 10.0,
    @required this.radius,
    @required this.colors,
    this.value,
    this.stops,
    this.totalAngle = 2 * pi,
    this.backgroundColor = Colors.deepPurple,
    this.strokeCapRound = true,
  });

  //首先还是先自定义属性
  final double strokeWidth; //圆环粗细
  final double radius; //圆环半径
  final bool strokeCapRound; //两端是否是圆角
  final double value; //当前进度，取值范围[0.0-1.0]
  final Color backgroundColor; //进度条背景色
  final double totalAngle; //进度条的总弧度，2*PI为整圆，小于2*PI则不是
  final List<Color> colors; //渐变色
  final List<double> stops; //渐变色的终止点，对应colors属性

  @override
  Widget build(BuildContext context) {
    double _offset = .0;

    //如果两端是圆角，则需要对起始位置进行调整，否则圆角部分会偏离其实位置
    //下面调整的角度的计算公式为
    if (strokeCapRound) {
      _offset = asin(strokeWidth / (radius * 2 - strokeWidth));
    }
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).primaryColor;
      _colors = [color, color];
    }

    return Transform.rotate(
      angle: -pi / 2 - _offset,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
            colors: colors,
            radius: radius,
            total: totalAngle,
            value: value,
            backgroundColor: backgroundColor,
            strokeCapRound: strokeCapRound,
            strokeWidth: strokeWidth),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter(
      {this.strokeWidth: 10.0,
      this.strokeCapRound = true,
      this.value,
      this.backgroundColor = Colors.deepPurple,
      @required this.colors,
      this.total = 2 * pi,
      this.radius,
      this.stops});

  //自定义画笔先接受传过来的各属性值，先定义
  final double strokeWidth;
  final bool strokeCapRound;
  final double value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double radius;
  final List<double> stops;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius);
    }
    double _offset = strokeWidth / 2;
    double _value = (value ?? .0);
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;

    if (strokeCapRound) {
      _start = asin(strokeWidth / (size.width - strokeWidth));
    }

    Rect rect = Offset(_offset, _offset) & Size(size.width - strokeWidth, size.height - strokeWidth);
    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;

    //先画背景
    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }

    //再画前景，应用渐变
    if (_value > 0) {
      paint.shader = SweepGradient(colors: colors, startAngle: .0, endAngle: _value, stops: stops).createShader(rect);
      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


class GradientCircularProgressRoute extends StatefulWidget {
  @override
  GradientCircularProgressRouteState createState() {
    return new GradientCircularProgressRouteState();
  }
}

class GradientCircularProgressRouteState
    extends State<GradientCircularProgressRoute> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 3));
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: <Widget>[
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 16.0,
                        children: <Widget>[
                          GradientCircularProgressIndicator(
                            // No gradient
                            colors: [Colors.blue, Colors.blue],
                            radius: 50.0,
                            strokeWidth: 3.0,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            colors: [Colors.red, Colors.orange],
                            radius: 50.0,
                            strokeWidth: 3.0,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            colors: [Colors.red, Colors.orange, Colors.red],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            colors: [Colors.teal, Colors.cyan],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            strokeCapRound: true,
                            value: CurvedAnimation(
                                parent: _animationController,
                                curve: Curves.decelerate)
                                .value,
                          ),
                          TurnBox(
                            turns: 1 / 8,
                            child: GradientCircularProgressIndicator(
                                colors: [Colors.red, Colors.orange, Colors.red],
                                radius: 50.0,
                                strokeWidth: 5.0,
                                strokeCapRound: true,
                                backgroundColor: Colors.red[50],
                                totalAngle: 1.5 * pi,
                                value: CurvedAnimation(
                                    parent: _animationController,
                                    curve: Curves.ease)
                                    .value),
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: GradientCircularProgressIndicator(
                                colors: [Colors.blue[700], Colors.blue[200]],
                                radius: 50.0,
                                strokeWidth: 3.0,
                                strokeCapRound: true,
                                backgroundColor: Colors.transparent,
                                value: _animationController.value),
                          ),
                          GradientCircularProgressIndicator(
                            colors: [
                              Colors.red,
                              Colors.amber,
                              Colors.cyan,
                              Colors.green[200],
                              Colors.blue,
                              Colors.red
                            ],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            strokeCapRound: true,
                            value: _animationController.value,
                          ),
                        ],
                      ),
                      GradientCircularProgressIndicator(
                        colors: [Colors.blue[700], Colors.blue[200]],
                        radius: 100.0,
                        strokeWidth: 20.0,
                        value: _animationController.value,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: GradientCircularProgressIndicator(
                          colors: [Colors.blue[700], Colors.blue[300]],
                          radius: 100.0,
                          strokeWidth: 20.0,
                          value: _animationController.value,
                          strokeCapRound: true,
                        ),
                      ),
                      //剪裁半圆
                      ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          heightFactor: .5,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                              //width: 100.0,
                              child: TurnBox(
                                turns: .75,
                                child: GradientCircularProgressIndicator(
                                  colors: [Colors.teal, Colors.cyan[500]],
                                  radius: 100.0,
                                  strokeWidth: 8.0,
                                  value: _animationController.value,
                                  totalAngle: pi,
                                  strokeCapRound: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 104.0,
                        width: 200.0,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Positioned(
                              height: 200.0,
                              top: .0,
                              child: TurnBox(
                                turns: .75,
                                child: GradientCircularProgressIndicator(
                                  colors: [Colors.teal, Colors.cyan[500]],
                                  radius: 100.0,
                                  strokeWidth: 8.0,
                                  value: _animationController.value,
                                  totalAngle: pi,
                                  strokeCapRound: true,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "${(_animationController.value * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


