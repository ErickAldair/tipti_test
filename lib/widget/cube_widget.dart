import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeLogo extends StatefulWidget {
  const GyroscopeLogo({Key key}) : super(key: key);

  @override
  State<GyroscopeLogo> createState() => _GyroscopeLogoState();
}

class _GyroscopeLogoState extends State<GyroscopeLogo> {
  GyroscopeEvent _gyroscopeEvent;
  StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;

  @override
  void initState() {
    super.initState();
    _gyroscopeSubscription = gyroscopeEvents.listen((event) {
      setState(() {
        _gyroscopeEvent = event;
      });
    });
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double rotationX = _gyroscopeEvent?.x ?? 0;
    double rotationY = _gyroscopeEvent?.y ?? 0;
    return Transform(
      transform: Matrix4.rotationX(rotationX) * Matrix4.rotationY(rotationY),
      child: Image.asset('assets/images/logo.png'),
    );
  }
}
