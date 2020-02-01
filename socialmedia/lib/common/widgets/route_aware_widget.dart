import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialmedia/app.dart';

class RouteAwareWidget extends StatefulWidget {
  final String name;
  final Widget child;

  const RouteAwareWidget(this.name, {@required this.child});

  @override
  State<RouteAwareWidget> createState() => RouteAwareWidgetState();
}

// Implement RouteAware in a widget's state and subscribe it to the RouteObserver.
class RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  // Called when the current route has been pushed.
  void didPush() {
    log('didPush ${widget.name}');
  }

  @override
  // Called when the top route has been popped off, and the current route shows up.
  void didPopNext() {
    log('didPopNext ${widget.name}');
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
