import 'package:flutter/material.dart';

final double _frameHeight = 140;
final double _frameWidth = 100;
final double _offsetValue = 25.0;

class FaceTimePage extends StatefulWidget {
  @override
  _FaceTimePageState createState() => _FaceTimePageState();
}

class _FaceTimePageState extends State<FaceTimePage> with SingleTickerProviderStateMixin {
  final List _positions = [
    {'top': _offsetValue, 'left': _offsetValue, 'bottom': null, 'right': null},
    {'top': _offsetValue, 'left': null, 'bottom': null, 'right': _offsetValue},
    {'top': null, 'left': null, 'bottom': _offsetValue, 'right': _offsetValue},
    {'top': null, 'left': _offsetValue, 'bottom': _offsetValue, 'right': null},
  ];

  Animation<Offset> _animation;
  AnimationController _controller;

  Offset _calculateAnimation({Size screenSize, Offset dragOffset}) {
    bool isRight = dragOffset.dx > ((screenSize.width - _frameWidth) / 2);
    bool isTop = dragOffset.dy < ((screenSize.height - _frameHeight) / 2);
    if (isRight && isTop) {
      // Top Right
      return Offset(screenSize.width - _offsetValue - _frameWidth, _offsetValue);
    } else if (isRight && !isTop) {
      // Bottom Right
      return Offset(screenSize.width - _offsetValue - _frameWidth, screenSize.height - 2 * _offsetValue - _frameHeight);
    } else if (!isRight && isTop) {
      // Top Left
      return Offset(_offsetValue, _offsetValue);
    } else if (!isRight && !isTop) {
      // Bottom Left
      return Offset(_offsetValue, screenSize.height - 2 * _offsetValue - _frameHeight);
    }
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Color(0xff141114),
      child: Stack(
        children: <Widget>[
          ..._positions.map((pos) => Positioned(
                top: pos['top'],
                left: pos['left'],
                right: pos['right'],
                bottom: pos['bottom'],
                child: DragTargetBlock(),
              )),
          AnimatedBuilder(
            animation: _controller,
            builder: (ctx, widget) {
              return Transform.translate(
                offset: _animation?.value ?? Offset(_offsetValue, _offsetValue),
                child: Draggable(
                  child: DraggableBlock(),
                  feedback: DraggableBlock(),
                  childWhenDragging: Container(),
                  onDragEnd: (DraggableDetails details) {
                    if (_controller.status == AnimationStatus.completed) _controller.reset();
                    var calculated = _calculateAnimation(screenSize: MediaQuery.of(context).size, dragOffset: details.offset);
                    _animation = Tween<Offset>(begin: details.offset, end: calculated).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: Curves.decelerate,
                      ),
                    );
                    _controller.forward();
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class DragTargetBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _frameHeight,
      width: _frameWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0), color: Colors.black, border: Border.all(color: Colors.white.withOpacity(0.4), width: 3.0)),
    );
  }
}

class DraggableBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _frameHeight,
      width: _frameWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            colors: [
              Colors.deepOrangeAccent,
              Colors.orangeAccent,
            ],
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
          )),
    );
  }
}
