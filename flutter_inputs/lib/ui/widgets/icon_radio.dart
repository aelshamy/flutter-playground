import 'package:flutter/material.dart';

/// A single radio button
class IconRadio<T> extends StatefulWidget {
  /// Creates a single radio button. A radio is only selectable
  ///
  /// [icon] and [value] must not be null.
  const IconRadio({
    Key key,
    @required this.icon,
    @required this.value,
    this.groupValue,
    this.color = const Color(0xFF58C140),
    this.label,
    this.semanticsLabel,
    this.onChange,
  })  : assert(
          icon != null,
          value != null,
        ),
        super(key: key);

  /// The color of the radio button when it is selected.
  final Color color;

  /// The icon for the radio button.
  final IconData icon;

  /// Optional text to display under the radio button.
  final String label;

  /// Optional semantics-specific label, otherwise it will read [label].
  final String semanticsLabel;

  /// The value of this radio button.
  final T value;

  final T groupValue;

  final void Function(String value) onChange;

  @override
  _IconRadioState createState() => _IconRadioState();
}

class _IconRadioState extends State<IconRadio>
    with SingleTickerProviderStateMixin {
  AnimationController _animation;
  bool selected = false;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.groupValue == widget.value) {
      selected = true;
      _animation.forward();
    } else {
      selected = false;

      _animation.reverse();
    }
    return GestureDetector(
      onTap: () {
        widget.onChange(widget.value);
      },
      child: Column(
        children: <Widget>[
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) => Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      selected && _animation.status == AnimationStatus.completed
                          ? widget.color
                          : Color(0xFF58C140),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Transform.scale(
                    scale: _animation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.color,
                      ),
                    ),
                  ),
                  Icon(
                    widget.icon,
                    size: 44,
                    color: selected ? Colors.white : Color(0xFF58C140),
                  ),
                ],
              ),
            ),
          ),
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Semantics(
                excludeSemantics: true,
                label: widget.semanticsLabel,
                child: Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            )
        ],
      ),
    );
  }
}
