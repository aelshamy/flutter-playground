import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 10),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
      ),
    );
  }
}

class LinearProgress extends StatelessWidget {
  const LinearProgress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      // padding: EdgeInsets.only(top: 10),
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
      ),
    );
  }
}
