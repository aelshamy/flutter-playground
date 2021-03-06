import 'dart:math';

import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String activeText;
  final String inactiveText;
  final Color activeColor;
  final Color inactiveColor;

  CustomSwitch({
    this.inactiveText = "OFF",
    this.activeText = "ON",
    this.inactiveColor = Colors.grey,
    this.activeColor = Colors.blue,
  });

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> with SingleTickerProviderStateMixin {
  late bool _checked;
  late String _text;
  late AnimationController _controller;
  late SwitchAnimation _animation;

  @override
  void initState() {
    super.initState();
    _checked = false;
    _text = widget.inactiveText;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = SwitchAnimation(_controller, activeColor: widget.activeColor, inactiveColor: widget.inactiveColor);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onClick,
      child: AnimatedBuilder(
        animation: _animation.controller,
        builder: (BuildContext context, Widget? child) {
          return Container(
            width: 100,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: _animation.containerBorder.value,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            alignment: _animation.handlerAlignment.value,
            child: Transform.rotate(
              angle: _animation.handlerRotation.value,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: _animation.handlerColor.value,
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: Center(
                  child: Text(
                    _text,
                    style: TextStyle(color: _animation.handlerTextColor.value),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onClick() {
    setState(() {
      _checked = !_checked;
      _text = _checked ? widget.activeText : widget.inactiveText;
      _checked ? _controller.forward() : _controller.reverse();
    });
  }
}

class SwitchAnimation {
  SwitchAnimation(this.controller, {required this.activeColor, required this.inactiveColor})
      : handlerAlignment = AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight).animate(controller),
        handlerRotation = Tween<double>(begin: -2 * pi, end: 0).animate(controller),
        handlerColor = ColorTween(begin: inactiveColor, end: activeColor).animate(controller),
        handlerTextColor = ColorTween(begin: Colors.black, end: Colors.white).animate(controller),
        containerBorder = BorderTween(begin: Border.all(width: 3, color: inactiveColor), end: Border.all(width: 3, color: activeColor))
            .animate(controller);

  final AnimationController controller;
  final Animation<Alignment> handlerAlignment;
  final Animation<double> handlerRotation;
  final Animation<Color?> handlerColor;
  final Animation<Color?> handlerTextColor;
  final Animation<Border?> containerBorder;
  final Color activeColor;
  final Color inactiveColor;
}
