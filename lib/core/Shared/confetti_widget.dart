import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiWidget extends StatefulWidget {
  final Widget child;

  const ConfettiWidget({Key key, this.child}) : super(key: key);

  @override
  _ConfettiWidgetState createState() => _ConfettiWidgetState();
}

class _ConfettiWidgetState extends State<ConfettiWidget> {
  ConfettiController controller;

  @override
  void initState() {
    controller = ConfettiController(duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget();
  }
}
