import 'package:flutter/material.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({
    Key? key,
    required this.duration,
  }) : super(key: key);

  final Duration duration;

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  String get counterText {
    final Duration duration = controller.duration! * controller.value;
    return duration.inSeconds.toString();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    controller.reverse(from: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      // child: child,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  value: controller.value,
                  strokeWidth: 2,
                  color: Colors.white),
            ),
            Text(
              counterText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
}
