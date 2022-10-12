import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> with TickerProviderStateMixin {
  double _margin = 0;
  double _opacity = 1;
  double _width = 200;
  Color _color = Colors.blue;
  bool _selected = false;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat();
  double _size = 50.0;
  bool _large = false;

  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 100.0;
      _large = !_large;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        margin: EdgeInsets.all(_margin),
        width: _width,
        color: _color,
        duration: Duration(seconds: 1),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => setState(() {
                          if (_margin == 50) {
                            _margin = 0;
                          } else {
                            _margin = 50;
                          }
                        }),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Text("animate margin")),
                ElevatedButton(
                    onPressed: () => setState(() {
                          if (_color == Colors.blue) {
                            _color = Colors.purpleAccent;
                          } else {
                            _color = Colors.blue;
                          }
                        }),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Text("animate color")),
                ElevatedButton(
                    onPressed: () => setState(() {
                          if (_width == 400) {
                            _width = 200;
                          } else {
                            _width = 400;
                          }
                        }),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Text("animate width")),
                ElevatedButton(
                    onPressed: () => setState(() {
                          if (_opacity == 1) {
                            _opacity = 0;
                          } else {
                            _opacity = 1;
                          }
                        }),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Text("animate opacity")),
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: Duration(seconds: 2),
                  child: Text(
                    "Hide me",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selected = !_selected;
                    });
                  },
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: _width - 50.0,
                      height: 150.0,
                      color: Colors.red,
                      child: AnimatedAlign(
                        alignment: _selected
                            ? Alignment.topRight
                            : Alignment.bottomLeft,
                        duration: const Duration(seconds: 1),
                        curve: Curves.slowMiddle,
                        child: const FlutterLogo(size: 50.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AnimatedBuilder(
                  animation: _controller,
                  child: Container(
                    width: 100,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.yellow,
                    ),
                    child: const Center(
                      child: Text('Whee!'),
                    ),
                  ),
                  builder: (BuildContext context, Widget? child) {
                    return Transform.rotate(
                      angle: _controller.value * 2.0 * math.pi,
                      child: child,
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  child: AnimatedCrossFade(
                    duration: const Duration(seconds: 3),
                    firstChild: const FlutterLogo(
                        style: FlutterLogoStyle.horizontal, size: 100.0),
                    secondChild: const FlutterLogo(
                        style: FlutterLogoStyle.markOnly, size: 100.0),
                    crossFadeState: _selected
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => _updateSize(),
                  child: Container(
                    color: Colors.amberAccent,
                    child: AnimatedSize(
                      curve: Curves.slowMiddle,
                      duration: const Duration(seconds: 1),
                      child: FlutterLogo(size: _size),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
