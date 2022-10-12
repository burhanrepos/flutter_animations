import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _colorAnimation;
  late Animation<double> _sizeAnimation;
  late Animation _curve;
  bool isFavourite = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(_controller);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30, end: 50), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 50, end: 30), weight: 30),
    ]).animate(_controller);

    _curve = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);

    _controller.addListener(() {
      setState(() {});
      // print(_sizeAnimation.value.toString());
    });

    _controller.addStatusListener((status) {
      print(_sizeAnimation.value.toString());

      if (status == AnimationStatus.completed) {
        setState(() {
          isFavourite = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFavourite = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: _colorAnimation.value,
            size: _sizeAnimation.value,
          ),
          onPressed: () {
            isFavourite ? _controller.reverse() : _controller.forward();
          },
        );
      },
    );
  }
}
